<?php

    final class Password {
        private $input;
        private $password;
        private $time_target;
        private $cost;
        private $plain;
        public $return;

        public function __construct($password = null)
        {
            $this->input = $password;
            $this->return = $this->input;
            $this->time_target = 0.05;
            $this->plain = $password;
        }

        public function hash(){
            $cost = 8;
            do {
                ++$cost;
                $start = microtime(true);
                $this->password = password_hash(stripslashes($this->input), PASSWORD_BCRYPT, ['cost' => $cost]);
                $end = microtime(true);
            } while (($end - $start) < $this->time_target);

            return $this->password;
        }

        public function rehash(){
            $cost = 8;
            do {
                ++$cost;
                $start = microtime(true);
                if (password_needs_rehash($this->input, PASSWORD_BCRYPT, ['cost' => $cost])) {
                    return true;
                }
                $end = microtime(true);
            } while (($end - $start) < $this->time_target);

            return false;
        }

        public function match($password_hash){
            if (password_verify($this->plain, $password_hash)) {
                return true;
            }

            return false;
        }

        public function send_otp(string $email): bool | string {

            $string = [
                'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
                'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
                '0','1','2','3','4','5','6','7','8','9'
            ];

            $otp = '';
            
            for($i = 0; $i < 10; $i++) {
                $index = rand(0, count($string) - 1);
                $otp .= $string[$index];
            }

            $subject = 'Here is your One Time Password - ' . $GLOBALS['application']['application_name'];
            $message = "You recently requested a password reset.\n\n";
            $message .= "<span style='font-size:2em;'>OTP:</span>\n";
            $message .= "<span style='font-size:2.5em;font-weight:lighter;'>" . $otp . "</span>\n\n\n";
            $message .= "<strong>Note:</strong> this OTP will expire in 30 minutes, or after you close your browser.\n";

            if(Email::send_local_email($GLOBALS['webmaster'], $email, $subject, $message)) {
                return $otp;
            }

            return false;
        }

        public function reset_password(string $email): bool {

            $string = [
                'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
                'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
                '0','1','2','3','4','5','6','7','8','9',
                '*','/','#','[',']','{','}','+','=','-','%','$','@','!','?','<','>',':',';'
            ];

            $password = '';
            
            for($i = 0; $i < 8; $i++) {
                $index = rand(0, count($string) - 1);
                $password .= $string[$index];
            }

            $subject = 'Here is your new password - ' . $GLOBALS['application']['application_name'];
            $message = "You recently change your password.\n\n";
            $message .= "<span style='font-size:2em;'>Password:</span>\n";
            $message .= "<span style='font-size:2.5em;font-weight:lighter;'>" . $password . "</span>\n\n\n";
            $message .= "This is your new login password.\n";

            if(Email::send_local_email($GLOBALS['webmaster'], $email, $subject, $message)) {
                $this->input = $password;
                $this->plain = $password;
                $this->return = $password;
                $v1 = $v2 = null;
                $sql = 'UPDATE `users` SET `Password`=? WHERE `Email`=?;';
                $stmt = $GLOBALS['connection']->prepare($sql);
                $stmt->bind_param('ss', $v1, $v2);
                $v1 = $this->hash();
                $v2 = $email;
                $stmt->execute();
                $stmt->close();
                
                return true;
            }

            return false;
        }
    }