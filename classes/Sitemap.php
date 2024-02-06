<?php

    class Sitemap {

        protected $connection;
        private $pages_site_map = 'sitemap.pages.txt';
        private $posts_site_map = 'sitemap.posts.txt';
        private $posts_rss = 'rss.xml';

        public function __construct($connection) {
            $this->connection = $connection;
        }

        public function update_pages() {

            $sql = 'SELECT URI FROM pages ORDER BY ID DESC LIMIT 50000;';
            $result = $this->connection->query($sql);
            if($result->num_rows > 0) {

                $file = fopen($this->pages_site_map, 'w');
                
                while($row = $result->fetch_assoc()) {

                    $url = $GLOBALS['host_addr'] . '/p/' . $row['URI'] . "\n";
                    fwrite($file, $url);

                }
                
                fclose($file);

            }

        }
       
        public function update_posts() {

            $sql = 'SELECT URI FROM posts ORDER BY ID DESC LIMIT 50000;';
            $result = $this->connection->query($sql);
            if($result->num_rows > 0) {

                $file = fopen($this->posts_site_map, 'w');
                
                while($row = $result->fetch_assoc()) {

                    $url = $GLOBALS['host_addr'] . '/read/' . $row['URI'] . "\n";
                    fwrite($file, $url);

                }
                
                fclose($file);

                $this->update_rss();

            }

        }
       
        public function update_rss() {

            $sql = 'SELECT * FROM posts ORDER BY ID DESC LIMIT 15;';
            $result = $this->connection->query($sql);
            if($result->num_rows > 0) {
                $rss = '';

                $rss .= '<?xml version="1.0" encoding="UTF-8" ?>';
                $rss .= '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">';
                $rss .= '<channel>';
                $rss .= '<title>' . $GLOBALS['application']['application_name'] . '</title>';
                $rss .= '<link>' . $GLOBALS['host_addr'] . '</link>';
                $rss .= '<pubDate> ' . date('D, d M Y H:i:s O') . ' </pubDate>'."\n";
                $rss .= '<description>' . $GLOBALS['application']['application_description'] . '</description>';
                $rss .= '<atom:link href="' . $GLOBALS['host_addr'] . '/rss.xml" rel="self" type="application/rss+xml" />';
                $rss .= "\n";

                $rss_file = fopen($this->posts_rss, 'w');
                
                while($row = $result->fetch_assoc()) {

                    $img = '';
                    if(!strpos($row['FeatureImage'], '/404.png') > 0) {
                        $get_rel_url = str_replace($GLOBALS['host_addr'], '', $row['FeatureImage']);
                        $get_rel_url = substr($get_rel_url, 1);
                        $img_size = filesize($get_rel_url);
                        $img = '<enclosure url="' . $GLOBALS['host_addr'] . $row['FeatureImage'] . '" length="' . $img_size . '" type="image/jpg" />'."\n";
                    } 

                    $url = $GLOBALS['host_addr'] . '/read/' . $row['URI'];
                    $item = '<item>'."\n";
                    $item .= '<title>' . $row['Title'] . '</title>'."\n";
                    $item .= '<link>' . $url . '</link>'."\n";

                    $item .= $img;
                                        
                    $item .= '<description>' . strip_tags($row['Content']) . '</description>'."\n";
                    $item .= '<pubDate> ' . date('D, d M Y H:i:s O', strtotime($row['PostTime'])) . ' </pubDate>'."\n";
                    $item .= '</item>';
                    $item .= "\n";
                    $rss .= $item;

                    
                }
                
                $rss .= '</channel>';
                $rss .= '</rss>';
                
                
                fwrite($rss_file, $rss);
                fclose($rss_file);

            }

        }


    }