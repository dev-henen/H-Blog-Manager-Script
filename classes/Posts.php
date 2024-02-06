<?php

    class Posts {

        protected $connection;
        public function __construct($connection) {
            $this->connection = $connection;
        }

        public function total(): int {
            $sql = 'SELECT COUNT(ID) AS Total FROM posts;';
            $result = $this->connection->query($sql);
            $row = $result->fetch_assoc();
            return $row['Total'];
        }
        public function total_views(): int {
            $sql = 'SELECT SUM(NumberOfViews) AS Total FROM views;';
            $result = $this->connection->query($sql);
            $row = $result->fetch_assoc();
            return $row['Total'];
        }

        public function getPosts(int $limit = 10, int $offset = 0): array {
            settype($limit,"integer");
            settype($offset,"integer");
            $sql = sprintf('SELECT posts.ID, posts.Title, posts.URI, posts.Labels, posts.Status, posts.FeatureImage, posts.Content, posts.PostTime, views.NumberOfViews FROM `posts` LEFT JOIN views ON posts.ID = views.PostID ORDER BY posts.ID DESC LIMIT %d, %d;', $offset, $limit);
            $result = $this->connection->query($sql);
            $posts = [];
            while ($row = $result->fetch_assoc()) {
                $array = $row;
                $labels = '';
                $labels_list = json_decode($array['Labels']);
                $check_if_post_is_featured_sql = sprintf('SELECT ID FROM feature_post WHERE PostID=%d', $array['ID']);
                $is_post_featured = ($this->connection->query($check_if_post_is_featured_sql)->num_rows > 0)? true : false;
                foreach($labels_list as $value) {
                    $labels .= "<li>$value</li>";
                }
                $array['Labels'] = $labels;
                $array['PostTime'] = date('M d, Y', strtotime($array['PostTime']));
                $array['Content'] = (strlen($array['Content']) > 130)? substr(strip_tags(str_replace('<', ' <', $array['Content'])), 0, 130) . '...' : str_replace('<', ' <', strip_tags($array['Content']));
                $array['Views'] = Format::number_count($array['NumberOfViews'] ?? 0);
                $array['IsFeatured'] = $is_post_featured;
                $array['FeaturedPostAddableMessage'] = ($is_post_featured)? 'Remove as feature post' : 'Mark as feature post';
                array_push($posts, $array);
            }
            return $posts;
        }
        
        public function getPopularPost(): array {
            $sql = 'SELECT * FROM posts WHERE ID = (SELECT PostID FROM views WHERE NumberOfViews = (SELECT max(NumberOfViews) FROM views));';
            $result = $this->connection->query($sql);
            if($result->num_rows > 0) {
                $array = $result->fetch_assoc();
                $labels = '';
                $labels_list = json_decode($array['Labels']);
                foreach($labels_list as $value) {
                    $labels .= "<li>$value</li>";
                }
                $check_if_post_is_featured_sql = sprintf('SELECT ID FROM feature_post WHERE PostID=%d', $array['ID']);
                $is_post_featured = ($this->connection->query($check_if_post_is_featured_sql)->num_rows > 0)? true : false;
                $array['Labels'] = $labels;
                $array['PostTime'] = date('M d, Y', strtotime($array['PostTime']));
                $array['Content'] = (strlen($array['Content']) > 200)? substr(strip_tags($array['Content']), 0, 200) . '...' : strip_tags($array['Content']);
                $array['FeaturedPostAddableMessage'] = ($is_post_featured)? 'Remove as feature post' : 'Mark as feature post';
                
                return $array;
            } else {
                return [];
            }
        }
       
        
        public function getFeaturePost(int $length = 3, int $offset = 0): array {

            $sql = sprintf('SELECT ID, Title, URI, FeatureImage, PostTime FROM posts WHERE ID IN(SELECT PostID FROM feature_post) ORDER BY ID DESC LIMIT %d, %d;', $offset, $length);
            $result = $this->connection->query($sql);
            $feature_post = []; 

            
            while($array = $result->fetch_assoc()){

                $array['PostTime'] = date('M d, Y', strtotime($array['PostTime']));
                $array['Title'] = (strlen($array['Title']) > 50)? substr($array['Title'], 0, 50) . '...' : $array['Title'];
                array_push($feature_post, $array);

            }
            return $feature_post;

        }


        public function readPost(): array {
            $uri = $_SERVER['REQUEST_URI'];
            $uri = str_replace('/read/','', $uri);
            if(preg_match('/[^a-zA-Z0-9\-]/', $uri)) {
                header('Location: /error');
                exit;
            }

            $sql = 'SELECT * FROM posts WHERE URI="' . $uri . '";';
            $result = $this->connection->query($sql);
            if(!$result->num_rows > 0) {
                header('Location: /404');
                exit;
            }

            $array = $result->fetch_assoc();
            $labels = '';
            $labels_list = json_decode($array['Labels']);
            foreach($labels_list as $value) {
                $labels .= "<li>$value</li>";
            }
            $array['Labels'] = $labels;
            $array['PostTime'] = date('M d, Y h:ia', strtotime($array['PostTime']));

            $post = $array['ID'];
            $sql = "SELECT NumberOfViews FROM views WHERE PostID =$post;";
            $result = $this->connection->query($sql);
            try {
                if($result->num_rows > 0) {
                    $row = $result->fetch_assoc();
                    $total = $row['NumberOfViews'] + 1;
                    $sql = "UPDATE views SET NumberOfViews=$total WHERE PostID=$post;";
                    $this->connection->query($sql);
                } else {
                    $sql = "INSERT INTO views(PostID, NumberOfViews) VALUES($post, 1);";
                    $this->connection->query($sql);
                }
            } catch(Exception $e) {}
            
            return $array;

        }

        public function getAPost(int $post_id): bool | array {
            //$post_id = (int) $post_id;
            settype($post_id, 'integer');
            $sql = sprintf('SELECT * FROM posts WHERE ID=%d LIMIT 1;', $post_id);
            $result = $this->connection->query($sql);
            if($result->num_rows > 0) return $result->fetch_assoc();
            return false;
        }


        public function search(String $q): array {
            $q = preg_replace("/[^a-zA-Z0-9 ]/", "", $q);
            if(empty($q)) return [];
            if(strlen(trim($q)) > 30) $q = substr($q, 0, 30);
            $sql = "SELECT Title, URI, FeatureImage FROM posts WHERE Title LIKE '%$q%' OR Content LIKE '%$q%' ORDER BY ID LIMIT 50;";
            $result = $this->connection->query($sql);
            if($result->num_rows > 0) return $result->fetch_all(MYSQLI_ASSOC);
            return [];
        }


        public function addPost($title, $status, $labels, $body, bool $send_news_letters = false): void {

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
               
               $uri = preg_replace('/[^a-zA-Z0-9 ]/', '', $title);
               $uri = str_replace(' ', '-', $uri);
               $uri = strtolower($uri);
               $sql = "SELECT ID FROM posts WHERE URI='$uri' LIMIT 1;";
               $result = $this->connection->query($sql);
               if($result->num_rows > 0) {
                   http_response_code(400);
                   echo 'Error: post title conflict';
                   exit;
               }

                if(empty($status)) {
                   $status = 'publish';
                } elseif(!in_array($status, ['publish', 'draft', 'update'])) {
                   http_response_code(500);
                   echo 'Oops! That\' an error';
                   exit;
                }

                if(empty($labels)) {
                   $labels = '[]';
                } else {
                   if(json_decode($labels)) {

                       $getLabels = json_decode($labels);

                       if($getLabels !== false && count($getLabels) > 8) {

                           http_response_code(500);
                           echo 'Labels tool long';
                           exit;

                       }
                       array_map(function($label) {
                           if(preg_match('/[^a-zA-Z0-9 ]/', $label)) {
                               http_response_code(500);
                               echo 'A label is invalid';
                               exit;
                           } elseif(strlen($label) > 30) {
                               http_response_code(500);
                               echo 'A label is invalid';
                               exit;
                           }
                       }, $getLabels);
                       
                       
                   } else {
                       $labels = '[]';
                   }
                }

                if(empty($body)) {
                   http_response_code(500);
                   echo 'The post is empty';
                   exit;
               } elseif(strlen($body) > 2000000000) {
                    http_response_code(500);
                    echo 'This post is too long, exceeded 2,000,000,000 in length.';
                    exit;
                }

                
                @$doc = new DOMDocument();
                @$doc->loadHTML($body);
                @$xpath = new DOMXPath($doc);
                $featureImage = @$xpath->evaluate('string(//img/@src)'); #"uploads/image.jpg"

                

                
                $v1 = $v2 = $v3 = $v4 = $v5 = $v6 = '';
                $sql = 'INSERT INTO `posts`(`Title`, `URI`, `Labels`, `Status`, `FeatureImage`, `Content`) VALUES(?,?,?,?,?,?);';
                $stmt = $this->connection->prepare($sql);
                $stmt->bind_param('ssssss', $v1, $v2, $v3, $v4, $v5, $v6);
                $v1 = htmlentities($title);
                $v2 = $uri;
                $v3 = $labels;
                $v4 = $status;
                $v5 = empty(trim($featureImage))? '/uploads/404.png' : $featureImage;
                $v6 = $body;
                if($stmt->execute()){
                    echo 'Post was published successfully.';
                    if($send_news_letters === true) {

                        $get_post_body = strip_tags($body);
                        $email_message = "Hey,\nThere is a new post: ";
                        $email_message .= "<a href='".$GLOBALS['host_addr'].'/read/'.$uri."'><b>" . $title . '</b></a>';
                        $email_message .= "\n\n\n";
                        $email_message .= (strlen($get_post_body) > 500)? substr($get_post_body, 0, 500) . '...' : $get_post_body;
                        $email_message .= "<a href='".$GLOBALS['host_addr'].'/read/'.$uri."'>Read more</a>\n";
                        
                        $send = Email::send_newsletters($title, $email_message);
                        if($send !== false) {
                            echo $send['num_of_sent'] . ' newsletters was sent and ' . $send['num_of_fails'] . ' failed';
                        } else {
                            echo 'No users have subscribed to newsletters.';
                        }

                    }

                } else {
                    http_response_code(500);
                    echo 'Oops! Something went wrong while uploading your post, please try again or check if this post hasn\'t been publish on this blog already.';
                    exit;
                }
                

             }


        }

        public function updatePost($post_id, $title, $status, $labels, $body): void {

            if(!empty($status)) {

                $title =  trim($title);
                $status = trim($status);
                $body = trim($body);
                settype($post_id, 'integer');

                $get_updating_post = $this->getAPost($post_id);
                if($get_updating_post === false) {
                    echo 'Update failed';
                    exit;
                }

                if(
                    $get_updating_post['Title'] == $title && 
                    $get_updating_post['Labels'] == $labels && 
                    $get_updating_post['Content'] == $body
                ) {
                    http_response_code(409);
                    echo 'No changes were made.';
                    exit;
                }

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
                } elseif(!in_array($status, ['draft', 'update'])) {
                   http_response_code(500);
                   echo 'Oops! That\' an error';
                   exit;
                }

                if(empty($post_id)) {
                    echo 'Oops! That\' an error';
                }

                if(empty($labels)) {
                   $labels = '[]';
                } else {
                   if(json_decode($labels)) {

                       $getLabels = json_decode($labels);

                       if($getLabels !== false && count($getLabels) > 8) {

                           http_response_code(500);
                           echo 'Labels tool long';
                           exit;

                       }
                       array_map(function($label) {
                           if(preg_match('/[^a-zA-Z0-9 ]/', $label)) {
                               http_response_code(500);
                               echo 'A label is invalid';
                               exit;
                           } elseif(strlen($label) > 30) {
                               http_response_code(500);
                               echo 'A label is invalid';
                               exit;
                           }
                       }, $getLabels);
                       
                       
                   } else {
                       $labels = '[]';
                   }
                }

                if(empty($body)) {
                   http_response_code(500);
                   echo 'The post is empty';
                   exit;
               } elseif(strlen($body) > 2000000000) {
                    http_response_code(500);
                    echo 'This post is too long, exceeded 2,000,000,000 in length.';
                    exit;
                }

                @$doc = new DOMDocument();
                @$doc->loadHTML($body);
                @$xpath = new DOMXPath($doc);
                $featureImage = @$xpath->evaluate('string(//img/@src)'); #"uploads/image.jpg"
                
                $v1 = $v2 = $v3 = $v4 = $v5 = '';
                $sql = 'UPDATE `posts` SET `Title`=?, `Labels`=?, `FeatureImage`=?, `Content`=? WHERE ID=?;';
                $stmt = $this->connection->prepare($sql);
                $stmt->bind_param('ssssi', $v1, $v2, $v3, $v4, $v5);
                $v1 = htmlentities(html_entity_decode($title));
                $v2= $labels;
                $v3 = (!empty($featureImage))? $featureImage : '/uploads/404.png';
                $v4 =  $body;
                $v5 = (int) $post_id;
        
                if($stmt->execute()){
                    echo 'Post updated.';
                    exit;
                } else {
                    http_response_code(500);
                    echo 'Oops! Something went wrong while uploading your post, please try again or check if this post hasn\'t been publish on this blog already.';
                    exit;
                }
                       
                   
               

             }


        }

        public function delete_post(int $post_id): bool {

            settype($post_id,'integer');
            $posts_sql = sprintf('DELETE FROM posts WHERE ID=%d;', $post_id);
            $views_sql = sprintf('DELETE FROM views WHERE PostID=%d;', $post_id);
            $feature_post_sql = sprintf('DELETE FROM feature_post WHERE PostID=%d;', $post_id);

            $result1 = $this->connection->query($views_sql);
            $result2 = $this->connection->query($feature_post_sql);
            $result3 = $this->connection->query($posts_sql);
            if($result1 && $result2 && $result3) return true;
            return false;
            
        }


        public function add_feature_post(int $post_id): int {
            settype($post_id, 'integer');

            if($this->getAPost($post_id) !== false) {
                $sql = sprintf('SELECT ID FROM feature_post WHERE PostID=%d', $post_id);
                if($this->connection->query($sql)->num_rows > 0) {

                    $sql = sprintf('DELETE FROM feature_post WHERE PostID=%d', $post_id);
                    if($this->connection->query($sql)) {
                        return 1;
                    } else {
                        return 2;
                    }

                } else {

                    $sql = sprintf('INSERT INTO feature_post SET PostID=%d', $post_id);
                    if($this->connection->query($sql)) {
                        return 3;
                    }

                }
            }

            return 4;
        }
    }