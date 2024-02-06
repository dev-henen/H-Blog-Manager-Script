<?php 
    namespace Database;

    use mysqli;
    use exception;

    final class Connection {
        private static $serverName;
        private static $username;
        private static $password;
        private static $database;
        private static $port;
        private static $socket;
        public static $connection;
        public function __construct(String $sName, String $uName, String $pass, String $db = null, int $port = null, $soc = null)
        {
            self::$serverName = $sName;
            self::$username = $uName;
            self::$password = $pass;
            self::$database = $db;
            self::$port = $port;
        }
        public function __destruct() {
            if (self::$connection) {
                mysqli_close(self::$connection);
            }
        }
        public static function create_connection() {
            try {

                @$mysql = new mysqli(self::$serverName, self::$username, self::$password, self::$database, self::$port, self::$socket);
                if($mysql->connect_errno > 0):
                    throw new Exception($mysql->connect_error);
                endif;
                self::$connection = $mysql;
                //echo "<p style='color:#0f0;'>Database connected</p>";
                
            } catch(Exception $e) {
                die("<p style='color:#f00;'><b>Database Connection Failed:</b> " . $e->getMessage() . "</p>");
            }

        }
    }
?>