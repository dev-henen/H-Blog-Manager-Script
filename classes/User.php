<?php 

    class User {

        public static function get_info(string $email): array | bool {

            $v1 = null;
            $email = filter_var($email, FILTER_SANITIZE_EMAIL);
            $sql = "SELECT * FROM users WHERE Email=?";
            $stmt = $GLOBALS['connection']->prepare($sql);
            $stmt->bind_param('s', $v1);
            $v1 = $email;
            $stmt->execute();
            $result = $stmt->get_result();
            if($result->num_rows > 0) {
                return $result->fetch_assoc();
            }

            return false;
        }

        public static function user_error() {
            unset($_SESSION['login_user']);
            setcookie('login_token', '', time() - 3600);
            header('Location: /error');
            exit;
        }

        public static function login(string $email, string $password): string {

            @setcookie('test', 'test');
            if(!count($_COOKIE) > 0) {
                echo 'Please turn on cookies in your browser to login. <a href="/login">Go back!</a>';
                exit;
            }

            $v1 = null;
            $email = filter_var($email, FILTER_SANITIZE_EMAIL);
            $sql = "SELECT * FROM users WHERE Email=?";
            $stmt = $GLOBALS['connection']->prepare($sql);
            $stmt->bind_param('s', $v1);
            $v1 = $email;
            $stmt->execute();
            $result = $stmt->get_result();
            if(!$result->num_rows > 0) {
               return 'No account was found with this email address';
            } else {
                
                $row = $result->fetch_assoc();
                $hashed_password = $row['Password'];
                $password = new Password($password);
                if($password->match($hashed_password)) {
                    
                    $string = [
                       'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
                       'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
                       '0','1','2','3','4','5','6','7','8','9'
                    ];
  
                    $token = '';
                    for($i = 0; $i < count($string); $i++) {
                       $index = rand(0, count($string) - 1);
                       $token .= $string[$index];
                       $index2 = rand(0, count($string) - 1);
                       $token .= $string[$index2];
                    }
                    
                    $login_time = time();
                    $token .= '_t_' . $login_time;
                    $login_token = [
                       'token' => $token,
                       'email' => $email,
                       'password' => $password->return,
                       'last-login-time' => $login_time
                    ];
                    $json = json_encode($login_token);
                    $get_encrypted_string = Format::encrypt_string($json, $GLOBALS['encryption_key']);
  
                    $v1 = $v2 = $v3 = $v4 = $v5 = null;
                    $device_name = 'Unknown Device';
                    $sql = 'INSERT INTO login_devices(Token, DeviceName, IPAddress, State, LastLogedIn) VALUES(?,?,?,?,?);';
                    $stmt = $GLOBALS['connection']->prepare($sql);
                    $stmt->bind_param('sssss', $v1, $v2, $v3, $v4, $v5);
                    $v1 = $token;
                    $v2 = $device_name;
                    $v3 = Format::get_client_ip_address();
                    $v4 = 'loged_in';
                    $v5 = $login_time;
                    if($stmt->execute()) {
  
                        setcookie('login_token', $get_encrypted_string, time() + (86400 * 365), '/');//Last for 1 year
                        if($password->rehash()) {
                            $sql = 'UPDATE `users` SET `Password`=? WHERE `Email`=?;';
                            $stmtX = $GLOBALS['connection']->prepare($sql);
                            $stmtX->bind_param('ss', $v1, $v2);
                            $v1 = $password->hash();
                            $v2 = $email;
                            $stmtX->execute();
                            $stmtX->close();
                        }

                        $stmt->close();
                        header('Location: /dashboard');
                        exit;
                       
                    } else {
                        $stmt->close();
                        return 'There was an error logging you in';
                    }
                   
                } else {
                    return 'Wrong user password';
                }

            }

        }

        public static function check_if_loged_in() {

            if(!isset($_SESSION['login-user']) && isset($_COOKIE['login_token'])) {
                
                $login_token = $_COOKIE['login_token'];
                $description = Format::decrypt_string($login_token, $GLOBALS['encryption_key']);
                $get_array = json_decode($description, true);
                $login_email = $get_array['email'] ?? null;
                $login_password = $get_array['password'] ?? null;

                if($get_array) {
    
                    $v1 = $v2 = null;
                    $token = $get_array['token'];
                    $sql = 'SELECT * FROM login_devices WHERE Token=? AND State=?;';
                    $stmt = $GLOBALS['connection']->prepare($sql);
                    $stmt->bind_param('ss', $v1, $v2);
                    $v1 = $token;
                    $v2 = 'loged_in';
                    if($stmt->execute()) {
    
                        $result = $stmt->get_result();
                        if($result->num_rows > 0) {
    
                            $get_user = self::get_info($login_email);
                            if($get_user !== false) {

                                $confirm_password = new Password($login_password);
                                if($confirm_password->match($get_user['Password'])) {
                                    $get_user['login_token'] = $token;
                                    $_SESSION['login-user'] = $get_user;
                                    header('Location: /dashboard');
                                } else {
                                    self::user_error();
                                }
    
                            } else {
                                self::user_error();
                            }
                            
                            
                        } else {
                            $stmt->close();
                            self::user_error();
                        }
    
                        $stmt->close();
                        exit;
                        
                    } else {                    
                        $stmt->close();
                        self::user_error();
                    }
    
                } else {
                    self::user_error();
                }

            }


        }

        public static function logout() {
            session_start();

            $v1 = $v2 = null;
            $sql = 'UPDATE `login_devices` SET `State`=? WHERE `Token`=?;';
            $stmt = $GLOBALS['connection']->prepare($sql);
            $stmt->bind_param('ss', $v1, $v2);
            $v1 = 'loged_out';
            $v2 = $_SESSION['login-user']['login_token'];
            
            if($stmt->execute()) {
                unset($_SESSION['login_user']);
                session_destroy();
                setcookie('login_token', '', time() - 3600);
                if(isset($_GET['reset'])) {
                   header('Location: /reset-password');
                } else {
                   header('Location: /login');
                }
            } else {
                header('Location: /error');
            }
            $stmt->close();
            exit;
        }


        public static function get_login_devices($offset = 0): array {
            settype($offset, 'integer');
            $limit = 20;
            $sql = sprintf('SELECT * FROM `login_devices` WHERE `State`="loged_in" ORDER BY `ID` DESC LIMIT %d,%d;', $offset, $limit);
            $result = $GLOBALS['connection']->query($sql);
            if($result->num_rows > 0) {
                $get_array_set = [];
                while($row = $result->fetch_assoc()) {

                    $row['LogedDate'] = date('l, M d Y', strtotime($row['LogedDate']));
                    $row['LastLogedIn'] = date('l, M d Y', $row['LastLogedIn']);
                    $row['ShowLogoutButton'] = ($row['State'] == 'loged_in')? ' style="display:block;"' : ' style="display:none;"';
                    $row['State'] = ($row['State'] == 'loged_in')? "Loged in" : 'Loged out';
                    $row['CurrentDevice'] = ($row['Token'] == $_SESSION['login-user']['login_token'])? 'active' : '';
                    $row['IsCurrentDevice'] = ($row['Token'] == $_SESSION['login-user']['login_token'])? 'This device' : '';

                    array_push($get_array_set, $row);
                }

                return $get_array_set;
            }
            return [];
        }
        public static function get_loged_out_devices($offset = 0): array {
            settype($offset, 'integer');
            $limit = 500;
            $sql = sprintf('SELECT * FROM `login_devices` WHERE `State`="loged_out" ORDER BY `ID` DESC LIMIT %d,%d;', $offset, $limit);
            $result = $GLOBALS['connection']->query($sql);
            if($result->num_rows > 0) {
                $get_array_set = [];
                while($row = $result->fetch_assoc()) {

                    $row['LogedDate'] = date('l, M d Y', strtotime($row['LogedDate']));
                    $row['LastLogedIn'] = date('l, M d Y', $row['LastLogedIn']);
                    $row['ShowLogoutButton'] = ($row['State'] == 'loged_in')? ' style="display:block;"' : ' style="display:none;"';
                    $row['State'] = ($row['State'] == 'loged_in')? "Loged in" : 'Loged out';
                    $row['CurrentDevice'] = ($row['Token'] == $_SESSION['login-user']['login_token'])? 'active' : '';
                    $row['IsCurrentDevice'] = ($row['Token'] == $_SESSION['login-user']['login_token'])? 'This device' : '';

                    array_push($get_array_set, $row);
                }

                return $get_array_set;
            }
            return [];
        }

        public static function logout_devices(int $id, $is_all = false): bool {

            settype($id, 'integer');
            if($is_all === false) {
                $sql = sprintf('UPDATE `login_devices` SET `State`="%s" WHERE `ID`=%d;', 'loged_out', $id);
            } else {
                $sql = sprintf('UPDATE `login_devices` SET `State`="%s" WHERE `State`="%d";', 'loged_in', $id);
            }
            if($GLOBALS['connection']->query($sql)) {
                return true;
            }

            return false;

        }

    }