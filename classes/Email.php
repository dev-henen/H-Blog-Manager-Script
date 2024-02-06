<?php

    class Email {
    
        public static function send_local_email(string $from, string $to, string $subject, string $message): bool {

            if(file_exists('email_template.html')) {


                $headers = 'MIME-Version: 1.0' . "\r\n";
                $headers .= 'Content-type:text/html;charset=UTF-8' . "\r\n";
                $headers .= "From:<$from>" . "\r\n";
    
                $template = file_get_contents('email_template.html');
                $template = str_replace('{{email.subject}}', $subject, $template);
                $template = str_replace('{{email.to}}', $to, $template);
                $template = str_replace('{{email.message}}', $message, $template);
                $template = str_replace('{{host.address}}', $GLOBALS['host_addr'], $template);
                $template = str_replace('{{host.name}}', $GLOBALS['application']['application_name'], $template);
                foreach($GLOBALS['social_links'] as $handle) {
                    $template = str_replace('{{social.link.'.strtolower($handle['name']).'}}', $handle['URL'], $template);
                }

    
                if(@mail($to, $subject, $template, $headers)) {
                    return true;
                }


            } else {
                echo 'Email template does not exist';
            }


            return false;
        }


        public static function send_newsletters(string $title, string $body): bool | array {

            $limit = 10000;
            $offset = 0;

            function recursion($limit, $offset, $title, $body, $sends = 0, $fails = 0) {

                $sql = sprintf('SELECT Email FROM newsletters LIMIT %d,%d', $offset, $limit);
                $result = $GLOBALS['connection']->query($sql);
                if($result->num_rows > 0) {

                    while($row = $result->fetch_assoc()){

                        $set_message = $body;
                        $set_message .= "\n\n\nTo unsubscribe out of our newsletters go to: ";
                        $set_message .= "<a href='".$GLOBALS['host_addr']."/subscribe?unsub=".urlencode($row['Email'])."'>unsubscribe me</a>";

                        if(Email::send_local_email($GLOBALS['webmaster'], $row['Email'], $title, $body)) {
                            $sends += 1;
                        } else {
                            $fails += 1;
                        }

                    }

                    if($result->num_rows >= $limit) {
                       return recursion($limit, $offset + $limit, $title, $body, $sends, $fails);
                    } else {
                        return ['num_of_sent' => $sends, 'num_of_fails' => $fails];
                    }
                } else {
                    return false;
                }

            }

            return recursion($limit, $offset, $title, $body);

        }
    }