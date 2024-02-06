<?php

    class Pages {

        protected $connection;
        public function __construct($connection) {
            $this->connection = $connection;
        }

        public function total(): int {
            $sql = 'SELECT COUNT(ID) AS Total FROM pages;';
            $result = $this->connection->query($sql);
            $row = $result->fetch_assoc();
            return $row['Total'];
        }

        public function get_page($uri): array {

            if(preg_match("/[^a-zA-Z0-9\-]/", $uri)) header('Location: /error');
            $sql = "SELECT * FROM pages WHERE URI='$uri';";
            $result = $this->connection->query($sql);
            if(!$result->num_rows > 0) header("Location: /404");
            return $result->fetch_assoc();
        }
        
        public function list_pages(int $limit = 30, int $offset = 0): array {
            settype($limit, 'integer');
            settype($offset, 'integer');

            $sql = sprintf("SELECT ID, Title, URI FROM pages ORDER BY ID DESC LIMIT %d,%d;", $offset, $limit);
            $result = $this->connection->query($sql);
            if(!$result->num_rows > 0) return [];
            return $result->fetch_all(MYSQLI_ASSOC);
            
        }
        
        public function list_menu_pages(): array {

            $sql = "SELECT ID, Title, URI FROM pages WHERE ShowInMenu='true' ORDER BY ID DESC;";
            $result = $this->connection->query($sql);
            if(!$result->num_rows > 0) return [];
            return $result->fetch_all(MYSQLI_ASSOC);
            
        }

        public function add_page($title, $status, $body, $addToMenu) {

            if(!empty($status)) {

                $title =  trim($title);
                $status = trim($status);
                $body = trim($body);

                if(empty($title)) {
                    http_response_code(500);
                    echo 'Title is empty';
                    exit;
                } elseif(strlen($title) > 255) {
                     http_response_code(500);
                     echo 'Title is too long, exceeded 255 characters in length.';
                     exit;
                }
                
                if(empty($status)) {
                   $status = 'publish';
                } elseif($status != 'publish') {
                   http_response_code(500);
                   echo 'Oops! That\' an error';
                   exit;
                }

                if(empty($body)) {
                    http_response_code(500);
                    echo 'The page is empty';
                    exit;
                } elseif(strlen($body) > 2000000000) {
                     http_response_code(500);
                     echo 'This page content is too long, exceeded 2,000,000,000 characters in length.';
                     exit;
                 }
                 
                 
                $uri = preg_replace('/[^a-zA-Z0-9 ]/', '', $title);
                $uri = str_replace(' ', '-', $uri);
                $uri = strtolower($uri);

                $sql = "SELECT ID FROM pages WHERE URI='$uri' LIMIT 1;";
                $result = $this->connection->query($sql);
                if($result->num_rows > 0) {
                    http_response_code(400);
                    echo 'Error: page title conflict';
                    exit;
                }

                $v1 = $v2 = $v3 = $v4 = '';

                $sql = 'INSERT INTO pages(`Title`, `URI`, `ShowInMenu`, `Content`) VALUES(?,?,?,?);';
                $stmt = $this->connection->prepare($sql);
                $stmt->bind_param('ssss', $v1, $v2, $v3, $v4);
                $v1 = htmlentities($title);
                $v2 = $uri;
                $v3 = ($addToMenu === true || $addToMenu == 'true')? 'true' : 'false';
                $v4 = $body;
                if(!$stmt->execute()) {
                    http_response_code(500);
                   echo 'There was an error while publishing your page';
                } else {
                    //echo 'Page publish successfully';
                }
                $stmt->close();

            }

            
        }
      
        public function update_page($pageID, $title, $status, $body, $addToMenu) {

            if(!empty($status)) {

                $title =  trim($title);
                $status = trim($status);
                $body = trim($body);
                settype($pageID, 'integer');

                if(empty($title)) {
                    http_response_code(500);
                    echo 'Title is empty';
                    exit;
                } elseif(strlen($title) > 255) {
                     http_response_code(500);
                     echo 'Title is too long, exceeded 255 characters in length.';
                     exit;
                }
                
                if(empty($status)) {
                   $status = 'update';
                } elseif($status != 'update') {
                   http_response_code(500);
                   echo 'Oops! That\' an error';
                   exit;
                }

                if(empty($body)) {
                    http_response_code(500);
                    echo 'The page is empty';
                    exit;
                } elseif(strlen($body) > 2000000000) {
                     http_response_code(500);
                     echo 'This page content is too long, exceeded 2,000,000,000 characters in length.';
                     exit;
                 }
                

                $v1 = $v2 = $v3 = $v4 = '';

                $sql = 'UPDATE pages SET `Title`=?, `Content`=?, `ShowInMenu`=? WHERE ID=?;';
                $stmt = $this->connection->prepare($sql);
                $stmt->bind_param('sssi', $v1, $v2, $v3, $v4);
                $v1 = htmlentities($title);
                $v2 = $body;
                $v3 = ($addToMenu === true || $addToMenu == 'true')? 'true' : 'false';
                $v4 = (int) $pageID;
                if(!$stmt->execute()) {
                    http_response_code(500);
                    echo 'There was an error while updating your page';
                } else {
                    echo 'Page updated successfully';
                }
                $stmt->close();

            }

            
        }

        public function delete_page(int $page_id): bool {

            settype($page_id,'integer');
            $get_page_sql = sprintf('SELECT `Privilege` FROM pages WHERE ID=%d;', $page_id);
            $get_page_result = $this->connection->query($get_page_sql);
            if(!$get_page_result->num_rows > 0) return false;
            $row = $get_page_result->fetch_assoc();
            if($row['Privilege'] == 'default') return false;
            $sql = sprintf('DELETE FROM pages WHERE ID=%d;', $page_id);
            $result = $this->connection->query($sql);
            if($result) return true;
            return false;
            
        }

    }