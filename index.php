<?php

   /*
   * Note:
   * This file should only be edit by a backend PHP developer.
   * Thanks to PHP.
   * Thanks to the PHP team
   */

   /*
   * H-Blog-Manager-Script
   * Developer: Moses Henen
   * Developer contact information:
   * henen.programmer@proton.me
   * or
   * Social medias:
   * Github: HenenTheProgrammer
   * Facebook: HenenTheProgrammer
   * Instagram: henentheprogrammer
   */


   /*
   * WARNING! WARNING!! WARNING!!!
   * 
   * 
   * Be careful while editing this file, 
   * some mistakes may cause a proper functioning of the application
   * Or even completely down
   */

   /*
   * The following line makes sure that the application pages/posts should not be
   * embed in an iframe.
   */

   header('X-FRAME-OPTIONS: deny');
   header('Content-Security-Policy: frame-ancestors "none";');

   /*
   * Turn on or off error reporting.
   * by setting the:
   * ini_set("display_errors", 1);
   * To:
   * ini_set("display_errors", 0);
   * Will automatically turn of error reporting and warnings in the application.
   */
   error_reporting(E_ALL);
   ini_set("display_errors", 1);



   /*
   * This application uses Object-Oriented-Programming to organize a better clean code to be maintainable.
   * The following required classes are the core of the application.
   */

   require 'classes/Route.php';
   require 'classes/Database.php';
   require 'classes/Posts.php';
   require 'classes/Pages.php';
   require 'classes/Password.php';
   require 'classes/Upload.php';
   require 'classes/Format.php';
   require 'classes/Medias.php';
   require 'classes/Sitemap.php';
   require 'classes/Email.php';
   require 'classes/User.php';
   require 'lib/template_loader/Henen_template_loader.php';

   

   /*
   * Set global variables to be access able entirely in the application.
   */
   $GLOBALS['application'] = parse_ini_file('config.ini');
   $GLOBALS['social_links'] = json_decode(file_get_contents('social_links.json'), true);
   #SET MYSQL DATABASE INFORMATION
   #Database host
   #Database username
   #Database password
   #Database name
   $database = new Database\Connection('database_host', 'database_user', 'database_password', 'database_name');
   $database::create_connection();
   $GLOBALS['connection'] = $database::$connection;
   $current_scheme = (!empty($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == 'on')? 'https' : 'http';
   $current_host = $_SERVER["HTTP_HOST"];
   $GLOBALS['host_addr'] = $current_scheme . '://' . $current_host;

   $Route = new Route();
   $GLOBALS['pages'] = new Pages($GLOBALS['connection']);
   $GLOBALS['posts'] = new Posts($GLOBALS['connection']);
   $GLOBALS['medias'] = new Medias($GLOBALS['connection']);
   /*
   * A no-reply email address should be replace with the "webmaster@email.com"
   * for the application to be able to send emails.
   * 
   * And also set a strong encryption key on: $GLOBALS['encryption_key'] = 'Your Unique String Key';
   * 
   */
   $GLOBALS['webmaster'] = 'webmaster@email.com';
   $GLOBALS['encryption_key'] = 'shke48tiukI*$(3948iQ*@_$(df.?;sdfk-=+_seflk';
   

   /*
   * The following routes all incoming requests to specified URI.
   * Note: All requests and responses are handled in this file.
   */

   #Route for home page (Landing page)
   $Route->for('/', function() {


      $template = new henen_template\Loader('home'); //Load home.tpl template

      $feature_posts = $GLOBALS['posts']->getFeaturePost();
      $popular_posts = $GLOBALS['posts']->getPopularPost();

      $template->set('page.title', htmlentities($GLOBALS['application']['application_name']));
      $template->set('application.name', strtoupper(htmlentities($GLOBALS['application']['application_name'])));
      $template->set('application.description', strtoupper(htmlentities($GLOBALS['application']['application_description'])));
      $template->set('application.copyright', date('Y'));
      $template->forEach('list_pages', $GLOBALS['pages']->list_menu_pages());
      $template->forEach('feature_post', $feature_posts);
      $template->forEach('popular_post', $popular_posts);
      $template->forEach('latest_posts', $GLOBALS['posts']->getPosts(20));
      $template->forEach('header_social_links', $GLOBALS['social_links']);
      $template->forEach('footer_social_links', $GLOBALS['social_links']);

      (empty($feature_posts))? $template->set('feature.post.status', ' style="visibility:hidden;"') : $template->set('feature.post.status', ' style="visibility:visible;"');
      (empty($popular_posts))? $template->set('popular.post.status', ' style="display:none;"') : $template->set('popular.post.status', ' style="display:initial;"');

      $template->render(false);
      
   });


   #Route for posts (Load each post according to the current URL; e.g. /read/post-uri)
   $Route->match('/read/', function() {

      $template = new henen_template\Loader('post'); //Load post.tpl template

      $post = $GLOBALS['posts']->readPost();
      $feature_posts = $GLOBALS['posts']->getFeaturePost();

      
      $template->set('page.title', $post['Title'] . ' - ' . htmlentities($GLOBALS['application']['application_name']));
      $template->set('og.title', $post['Title']);
      $template->set('og.description', htmlentities((strlen($post['Content']) > 300)? substr(strip_tags($post['Content']), 0, 300) : strip_tags($post['Content'])));
      $template->set('og.image', $post['FeatureImage']);
      $template->set('og.url', $GLOBALS['host_addr'] . '/read/' . $post['URI']);
      $template->set('application.name', strtoupper(htmlentities($GLOBALS['application']['application_name'])));
      $template->set('application.description', strtoupper(htmlentities($GLOBALS['application']['application_description'])));
      $template->set('application.copyright', date('Y'));
      $template->set('host.addr', urlencode($GLOBALS['host_addr']));
      $template->forEach('list_pages', $GLOBALS['pages']->list_menu_pages());
      $template->forEach('post', $post);
      $template->forEach('recent_posts', $GLOBALS['posts']->getPosts(20));
      $template->forEach('feature_post', $feature_posts);
      $template->forEach('header_social_links', $GLOBALS['social_links']);
      $template->forEach('footer_social_links', $GLOBALS['social_links']);

      (empty($feature_posts))? $template->set('feature.post.status', 'style="display:none;"') : $template->set('feature.post.status', 'style="display:initial;"');

      $template->render(false);

   });


   #Route for feed (Loading more posts or reading posts in feed)
   $Route->match('/view-more-posts', function() {

      if(isset($_GET['offset'])) {
         $offset = $_GET['offset'];
         settype($offset, 'integer');
         $load_posts = $GLOBALS['posts']->getPosts(20, $offset);
         if(!count($load_posts) > 0) {
            http_response_code(204);
         }

         $template = new henen_template\Loader('home-recent-posts-container'); //Load home-recent-posts-container.tpl template

         $template->forEach('latest_posts', $load_posts);

         $template->render(false);

         exit;
      }

      $template = new henen_template\Loader('view-more-posts'); //Loading view-more-posts.tpl template

      $template->set('page.title', 'Feed - ' . htmlentities($GLOBALS['application']['application_name']));
      $template->set('application.name', strtoupper(htmlentities($GLOBALS['application']['application_name'])));
      $template->set('application.copyright', date('Y'));
      $template->set('host.addr', urlencode($GLOBALS['host_addr']));
      $template->forEach('list_pages', $GLOBALS['pages']->list_menu_pages());
      $template->forEach('header_social_links', $GLOBALS['social_links']);
      $template->forEach('latest_posts', $GLOBALS['posts']->getPosts(20));


      $template->render(false);

   });


   #Route for searches
   $Route->match('/search', function() {

      
      if(isset($_GET['q']) && !empty($_GET['q'])) {

         $template = new henen_template\Loader('search'); //Load search.tpl template

         $search_result = $GLOBALS['posts']->search($_GET['q']);

         $template->set('page.title', 'Search result for - ' . htmlentities($_GET['q']));
         $template->set('search.query.string', htmlentities($_GET['q']));
         $template->set('application.name', strtoupper(htmlentities($GLOBALS['application']['application_name'])));
         $template->set('application.description', strtoupper(htmlentities($GLOBALS['application']['application_description'])));
         $template->set('application.copyright', date('Y'));
         $template->forEach('list_pages', $GLOBALS['pages']->list_menu_pages());
         $template->forEach('search_result', $search_result);
         $template->forEach('header_social_links', $GLOBALS['social_links']);
         $template->forEach('footer_social_links', $GLOBALS['social_links']);
         
         if(empty($search_result)) {
            $template->set('empty.search.result', ' style="display:initial;"');
            $template->set('empty.search.result.message', 'No match found');
         } else {
            $template->set('empty.search.result', ' style="display:none;"');
            $template->set('empty.search.result.message', '');
         }

         $template->render(false);

      } else {
         header('Location: /');
         exit;
      }

   });

   #Route for featured posts/trend posts
   $Route->match('/trends', function() {

      $template = new henen_template\Loader('featured-posts'); //Load featured-posts.tpl template

      $trending_posts = $GLOBALS['posts']->getFeaturePost(500);

      
      $template->set('page.title', 'Trending posts - ' . htmlentities($GLOBALS['application']['application_name']));
      $template->set('application.name', strtoupper(htmlentities($GLOBALS['application']['application_name'])));
      $template->set('application.description', strtoupper(htmlentities($GLOBALS['application']['application_description'])));
      $template->set('application.copyright', date('Y'));
      $template->set('host.addr', urlencode($GLOBALS['host_addr']));
      $template->forEach('list_pages', $GLOBALS['pages']->list_menu_pages());
      $template->forEach('trending_posts', $trending_posts);
      $template->forEach('recent_posts', $GLOBALS['posts']->getPosts(10));
      $template->forEach('header_social_links', $GLOBALS['social_links']);
      $template->forEach('footer_social_links', $GLOBALS['social_links']);


      $template->render(false);

   });


   #Route for all custom pages (E.g. /p/about, /p/contact, /p/privacy-policy)
   $Route->match('/p/', function() {
      
      $uri = $_SERVER['REQUEST_URI'];
      $uri = str_replace('/p/','', $uri);

      $page = $GLOBALS['pages']->get_page($uri);
      $template = new henen_template\Loader('page'); //Load page.tpl template
      $template->set('page.title', $page['Title']);
      $template->set('application.name', strtoupper(htmlentities($GLOBALS['application']['application_name'])));
      $template->set('application.description', strtoupper(htmlentities($GLOBALS['application']['application_description'])));
      $template->set('application.copyright', date('Y'));
      $template->forEach('list_pages', $GLOBALS['pages']->list_menu_pages());
      $template->forEach('page', $page);
      $template->forEach('header_social_links', $GLOBALS['social_links']);
      $template->forEach('footer_social_links', $GLOBALS['social_links']);
      $template->render(false);

   });


   #Route for newsletters subscription
   $Route->match('/subscribe', function() {

      if($_SERVER['REQUEST_METHOD'] == 'POST') {

         if(isset($_POST['email'])) {

            $email = filter_var($_POST['email'], FILTER_SANITIZE_EMAIL);
            $email_title = 'You have subscribe to our newsletters';
            $email_message = "You recently subscribed to our newsletters, ";
            $email_message .= "and we guarantee you of no spam ever in your inbox\n\n";
            $email_message .= "to unsubscribe out of our newsletters go to: ";
            $email_message .= "<a href='".$GLOBALS['host_addr']."/subscribe?unsub=".urlencode($email)."'>unsubscribe me</a>";
            $message = '';
            $success_message = 'Thank you for subscribing to our newsletters!';
            $bad_email_message = 'The email address you provided seems to be invalid';
            $error_message = 'Please try again, we could not subscribe you to our newsletters at the moment';

            if(!filter_var($email, FILTER_VALIDATE_EMAIL)) {
               $message = $bad_email_message;
            } elseif(Email::send_local_email($GLOBALS['webmaster'], $email, $email_title, $email_message)) {
               $sql = 'INSERT INTO newsletters(Email) VALUES(?);';
               $stmt = $GLOBALS['connection']->prepare($sql);
               $v1 = null;
               $stmt->bind_param('s', $v1);
               $v1 = $email;
               $stmt->execute();
               $stmt->close();
               $message = $success_message;
            } else {
               $message = $error_message;
            }

            $template = new henen_template\Loader('newsletters'); //Load newsletters.tpl template
            $template->set('page.title', 'Newsletters - ' . htmlentities($GLOBALS['application']['application_name']));
            $template->set('application.name', strtoupper(htmlentities($GLOBALS['application']['application_name'])));
            $template->set('application.description', strtoupper(htmlentities($GLOBALS['application']['application_description'])));
            $template->set('application.copyright', date('Y'));
            $template->set('newsletter.message', $message);
            $template->forEach('list_pages', $GLOBALS['pages']->list_menu_pages());
            $template->forEach('header_social_links', $GLOBALS['social_links']);
            $template->forEach('footer_social_links', $GLOBALS['social_links']);
            $template->render(false);

            exit;
         }

      } elseif($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['unsub'])) {

         $email = filter_var($_GET['unsub'], FILTER_SANITIZE_EMAIL);
         $message = '';
         if(!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            header('Location: /error');
            exit;
         }

         $sql = 'DELETE FROM newsletters WHERE Email=?;';
         $stmt = $GLOBALS['connection']->prepare($sql);
         $v1 = null;
         $stmt->bind_param('s', $v1);
         $v1 = $email;
         if(!$stmt->execute()) {
            header('Location: /error');
            exit;
         }
         $stmt->close();

         $message = 'You have been opt out of our newsletters, and if you ever change your mind, we will love to have you back. Thanks!';

         $template = new henen_template\Loader('newsletters'); //Load newsletters.tpl template
         $template->set('page.title', 'Newsletters - ' . htmlentities($GLOBALS['application']['application_name']));
         $template->set('application.name', strtoupper(htmlentities($GLOBALS['application']['application_name'])));
         $template->set('application.description', strtoupper(htmlentities($GLOBALS['application']['application_description'])));
         $template->set('application.copyright', date('Y'));
         $template->set('newsletter.message', $message);
         $template->forEach('list_pages', $GLOBALS['pages']->list_menu_pages());
         $template->forEach('header_social_links', $GLOBALS['social_links']);
         $template->forEach('footer_social_links', $GLOBALS['social_links']);
         $template->render(false);

         exit;
      } 
      header('Location: /');

   });

   
   #Route for login page
   $Route->for('/login', function(){

      session_start();
      if(isset($_SESSION['login-user'])) { 
         header('Location: /dashboard');
      } else {
         User::check_if_loged_in();
      }

      $error = '';
      $email = '';

      if($_SERVER['REQUEST_METHOD'] == 'POST') {

         if(isset($_POST['login'])) {

            $email = $_POST['email'];
            $password = $_POST['password'];

            if(empty($email)) {
               $error = 'Please provide login email address';
            } elseif(!filter_var($email, FILTER_VALIDATE_EMAIL) || strlen($email) > 320) {
               $error = 'Sorry, this is not a valid email address';
            } else {

               if(empty($password)){
                  $error = "Enter login password";
               } elseif(strlen($password) < 6 || strlen($password) > 200) {
                  $error = "Wrong user password";
               } else {

                  $error = User::login($email, $password);

               }

            }


         }

      }
      
      $template = new henen_template\Loader('login'); //Load login.tpl template
      $template->set('page.title', 'Login - ' . htmlentities($GLOBALS['application']['application_name']));
      $template->set('application.name', strtoupper(htmlentities($GLOBALS['application']['application_name'])));
      $template->set('application.description', strtoupper(htmlentities($GLOBALS['application']['application_description'])));
      $template->set('application.copyright', date('Y'));
      $template->set('login.error', $error);
      $template->set('login.email', $email);
      $template->forEach('header_social_links', $GLOBALS['social_links']);
      $template->forEach('footer_social_links', $GLOBALS['social_links']);
      $template->render(false);

   });


   #Route for password reset page
   $Route->for('/reset-password', function(){

      session_start();
      if(isset($_SESSION['login-user'])) header('Location: /dashboard');

      $error = '';
      $email = '';
      $otp_field_visibility = 'style="display: none;"';

      if($_SERVER['REQUEST_METHOD'] == 'POST') {

         if(
            isset($_SESSION['reset_password_email'])
            && isset($_SESSION['reset_password_otp'])
            && isset($_POST['otp']) 
         ) {

            $email = $_POST['email'];
            $otp_field_visibility = 'style="display: initial;"';
            if($_POST['email'] != $_SESSION['reset_password_email']) {
               $otp_field_visibility = 'style="display: none;"';
               $error = 'Wrong email address';
               unset($_SESSION['reset_password_email']);
               unset($_SESSION['reset_password_otp']);
            } elseif($_POST['otp'] == $_SESSION['reset_password_otp']) {
               
               $password = new Password();
               if($password->reset_password(filter_var($_SESSION['reset_password_email'], FILTER_SANITIZE_EMAIL))) {
                  
                  unset($_SESSION['reset_password_email']);
                  unset($_SESSION['reset_password_otp']);
                  $error = 'Your password was changed! Please check your email address, a new password has been sent to your email address ' . $email;
                  $email = '';
                  $otp_field_visibility = 'style="display: none;"';
            
               } else {
                  $error = 'Something went wrong setting your password, please try again';
               }

            } else {
               $error = 'Wrong OTP';
            }


         } elseif(isset($_POST['reset'])) {

            $email = $_POST['email'];

            if(empty($email)) {
               $error = 'Please provide login email address';
            } elseif(!filter_var($email, FILTER_VALIDATE_EMAIL) || strlen($email) > 320) {
               $error = 'Sorry, this is not a valid email address';
            } else {

               $v1 = null;
               $email = filter_var($email, FILTER_SANITIZE_EMAIL);
               $sql = 'SELECT ID FROM users WHERE Email=?;';
               $stmt = $GLOBALS['connection']->prepare($sql);
               $stmt->bind_param('s', $v1);
               $v1 = $email;
               $stmt->execute();
               $result = $stmt->get_result();
               $stmt->close();
               if($result->num_rows > 0) {

                  $password = new Password();
                  $send_otp = $password->send_otp($email);
                  if($send_otp !== false) {

                     $_SESSION['reset_password_email'] = $email;
                     $_SESSION['reset_password_otp'] = $send_otp;
                     $otp_field_visibility = 'style="display: initial;"';
                     $error = 'Enter OTP from your email bellow.';

                  } else {
                     $error = 'There was an error sending OTP, please try again';
                  }
                  

               } else {
                  $error = 'Wrong email address';
               }

            }


         }

      }
      
      $template = new henen_template\Loader('login-reset-password'); //Load login-reset-password.tpl template 
      $template->set('page.title', 'Reset my password - ' . htmlentities($GLOBALS['application']['application_name']));
      $template->set('application.name', strtoupper(htmlentities($GLOBALS['application']['application_name'])));
      $template->set('application.description', strtoupper(htmlentities($GLOBALS['application']['application_description'])));
      $template->set('application.copyright', date('Y'));
      $template->set('login.error', $error);
      $template->set('login.email', $email);
      $template->set('login.otp.visibility', $otp_field_visibility);
      $template->forEach('header_social_links', $GLOBALS['social_links']);
      $template->forEach('footer_social_links', $GLOBALS['social_links']);
      $template->render(false);

   });

   #Route for logging user out
   $Route->match('/logout', function(){
      User::logout();
   });


   #Route for dashboard
   /*
   * This route, routes all the request to dashboard
   * which makes sure that all requests must pass the dashboard security check
   * before being processed
   * Example:
   * All requests containing /dashboard/
   * will be handle in this route, both background requests and submissions that must be authenticated.
   * 
   * THIS PROVIDES A CLEAR SECURITY STRUCTURE.
   */
   $Route->match('/dashboard', function(){
      session_start();
      if(!isset($_SESSION['login-user'])) {
         header('Location: /login');
         exit;
      } else {
         User::check_if_loged_in();
      }
      define('USER', $_SESSION['login-user']);
      $sitemap = new Sitemap($GLOBALS['connection']);

      if(function_exists('disk_free_space') && function_exists('disk_total_space')) {

         $total_space = disk_total_space($_SERVER['DOCUMENT_ROOT']);
         $free_space = disk_free_space($_SERVER['DOCUMENT_ROOT']);
         
         $percent_of_space_used = Format::percent($free_space, $total_space);
         $total_space = Format::size($total_space);
         $free_space = Format::size($free_space);



      }

      /*
      * This section handles all request that comes with /t/
      * Example: /dashboard/t/
      * 
      * The dashboard uses a client router, so this parses all tabs preloaded by the client router.
      *
      */
      if(preg_match('/\/t/', $_SERVER['REQUEST_URI'])) {

         $t = str_replace('/dashboard/t/', '', $_SERVER['REQUEST_URI']);
         switch($t) {
            case 'posts':

               $template = new henen_template\Loader('dashboard-posts'); //Load dashboard-posts.tpl template
               $template->forEach('posts', $GLOBALS['posts']->getPosts(30));
               $template->render(false);

            break;
            case 'feature-posts':

               $template = new henen_template\Loader('dashboard-featured-posts'); //Load dashboard-featured-posts.tpl template
               $template->forEach('posts', $GLOBALS['posts']->getFeaturePost(30));
               $template->render(false);

            break;
            case 'pages':

               $template = new henen_template\Loader('dashboard-pages'); //Load dashboard-pages.tpl template
               $template->forEach('pages', $GLOBALS['pages']->list_pages(30));
               $template->render(false);

            break;
            case 'create-post':

               $template = new henen_template\Loader('dashboard-create-post'); //Load dashboard-create-post.tpl template
               $template->render(false);

            break;
            case 'create-page':

               $template = new henen_template\Loader('dashboard-create-page'); //Load dashboard-create-page.tpl template
               $template->render(false);

            break;
            case 'settings':

               $template = new henen_template\Loader('dashboard-settings'); //Load dashboard-settings.tpl template
               $template->forEach('login.devices', User::get_login_devices());
               $template->forEach('logout.devices', User::get_loged_out_devices());
               $template->forEach('settings.social-handles', $GLOBALS['social_links']);
               $template->render(false);

            break;
            default:
            
               $template = new henen_template\Loader('dashboard-home'); //Load dashboard-home.tpl template
               $template->set('user.profile.name', USER['FullName']);
               $template->set('space.total', $total_space??'Not Available');
               $template->set('space.free', $free_space??'Not Available');
               $template->set('space.used', $percent_of_space_used??'Not Available');
               $template->set('space.used.set', 'style="width: ' . ($percent_of_space_used??'0%') . '"');
               $template->set('website.posts.total', $GLOBALS['posts']->total());
               $template->set('website.pages.total', $GLOBALS['pages']->total());
               $template->set('website.posts.views', $GLOBALS['posts']->total_views());
               $template->forEach('posts', $GLOBALS['posts']->getPosts(5));
               $template->render(false);
            
         }


      /*
      * This section handles all request that comes with /cgi/
      * Example: /dashboard/cgi/
      * 
      * This requests are requests sent in the background (Example: through, XMLHttpRequest, Fetch API...e.t.c)
      *
      */
      } elseif(preg_match('/\/cgi/', $_SERVER['REQUEST_URI'])) {

         $cgi = str_replace('/dashboard/cgi/', '', $_SERVER['REQUEST_URI']);
         $cgi = (strpos($cgi, '?') !== false)? substr($cgi, 0, strpos($cgi, '?')) : $cgi;
         #Switch requests handling base on page URIs
         switch($cgi) {

            #Handles new posts creation or updates
            case 'post':

               if($_SERVER['REQUEST_METHOD'] == 'POST') {

                  if(isset($_POST['status']) && $_POST['status'] == 'update') {
                     $GLOBALS['posts']->updatePost($_POST['postID'], $_POST['title'], $_POST['status'], $_POST['labels'], $_POST['body']);
                  } else {
                     if(isset($_POST['sendNewsletters']) && $_POST['sendNewsletters'] == 'true' || $_POST['sendNewsletters'] === true) {
                        $sendNewsLetters = true;
                     } else {
                        $sendNewsLetters = false;
                     }
                     $GLOBALS['posts']->addPost($_POST['title'], $_POST['status'], $_POST['labels'], $_POST['body'], $sendNewsLetters);
                     $sitemap->update_posts();
                  }

               }

            break;
            #Handles new custom pages creation or updates
            case 'page':

               if($_SERVER['REQUEST_METHOD'] == 'POST') {

                  if(isset($_POST['status']) && $_POST['status'] == 'update') {
                     $GLOBALS['pages']->update_page($_POST['pageID'], $_POST['title'], $_POST['status'], $_POST['body'], $_POST['addToMenu']);
                  } else {
                     $GLOBALS['pages']->add_page($_POST['title'], $_POST['status'], $_POST['body'], $_POST['addToMenu']);
                     $sitemap->update_pages();
                  }

               }

            break;
            #Fetch old post information and return for edit
            case 'get-edit-post':

               if(isset($_GET['postID'])) {
                  $result = $GLOBALS['posts']->getAPost($_GET['postID']);
                  if($result !== false) {
                     $parse_post = json_encode($result);
                     if($parse_post) {

                        echo $parse_post;
                        exit;

                     } else {
                        http_response_code(500);
                        echo 'There was an error parsing this post';
                     }
                  } else {
                     http_response_code(500);
                     echo 'There was an error loading this post';
                  }
               }

            break;
            #Fetch old page information and return for edit
            case 'get-edit-page':

               if(isset($_GET['pageURI'])) {
                  $result = $GLOBALS['pages']->get_page($_GET['pageURI']);
                  if($result !== false) {
                     $parse_page = json_encode($result);
                     if($parse_page) {

                        echo $parse_page;
                        exit;

                     } else {
                        http_response_code(500);
                        echo 'There was an error parsing this page';
                     }
                  } else {
                     http_response_code(500);
                     echo 'There was an error loading this page';
                  }
               }

            break;
            #Delete a post
            case 'delete-post':

               if($_SERVER['REQUEST_METHOD'] == 'POST') {
                  if(isset($_POST['post_id'])) {
                     if(empty($_POST['post_id'])) {
                        http_response_code(400);
                        echo 'Invalid post id';
                        exit;
                     }
                     $result = $GLOBALS['posts']->delete_post(trim($_POST['post_id']));
                     if($result) {
                        http_response_code(200);
                        $sitemap->update_posts();
                        echo 'This post was deleted successfully';
                        exit;
                     } else {
                        http_response_code(500);
                        echo 'Oops! Something went wrong while deleting your post';
                        exit;
                     }
                  }
               }

            break;
            #Delete a page
            case 'delete-page':

               if($_SERVER['REQUEST_METHOD'] == 'POST') {
                  if(isset($_POST['page_id'])) {
                     if(empty($_POST['page_id'])) {
                        http_response_code(400);
                        echo 'Invalid page id';
                        exit;
                     }
                     $result = $GLOBALS['pages']->delete_page(trim($_POST['page_id']));
                     if($result) {
                        http_response_code(200);
                        $sitemap->update_pages();
                        echo 'This page was deleted successfully';
                        exit;
                     } else {
                        http_response_code(500);
                        echo 'Oops! Something went wrong while deleting your page, or you may be trying to deleting a default page';
                        exit;
                     }
                  }
               }

            break;
            #Upload media files
            case 'upload-media':

               $GLOBALS['medias']->upload_media($_FILES['media']);

            break;
            #Load media images
            case 'load-media-images':

               $get_images = $GLOBALS['medias']->load_medias('image', $_GET['offset']);
               if(empty($get_images)) {
                  http_response_code(204);
                  exit;
               }
               $template = new henen_template\Loader('media-images'); //Load media-images.tpl template
               $template->forEach('medias.editor.images', $get_images);
               $template->render(false);

            break;
            #Load media images for delete section
            case 'load-delete-media-images':

               $get_images = $GLOBALS['medias']->load_medias('image', $_GET['offset']);
               if(empty($get_images)) {
                  http_response_code(204);
                  exit;
               }
               $template = new henen_template\Loader('media-images-for-delete'); //Load media-images-for-delete.tpl template
               $template->forEach('medias.delete.images', $get_images);
               $template->render(false);

            break;
            #Loading media videos
            case 'load-media-videos':

               $get_videos = $GLOBALS['medias']->load_medias('video', $_GET['offset']);
               if(empty($get_videos)) {
                  http_response_code(204);
                  exit;
               }
               $template = new henen_template\Loader('media-videos'); //Load media-videos.tpl template
               $template->forEach('medias.editor.videos', $get_videos);
               $template->render(false);

            break;
            #Load media videos for delete section
            case 'load-delete-media-videos':

               $get_videos = $GLOBALS['medias']->load_medias('video', $_GET['offset']);
               if(empty($get_videos)) {
                  http_response_code(204);
                  exit;
               }
               $template = new henen_template\Loader('media-videos-for-delete'); //Load media-videos-for-delete.tpl template
               $template->forEach('medias.delete.videos', $get_videos);
               $template->render(false);

            break;
            #Delete a media
            case 'delete-a-media':

               if($_SERVER['REQUEST_METHOD'] == 'POST') {
                  if(isset($_POST['mediaID'])) {
                     if(preg_match('/[^0-9]/', $_POST['mediaID'])) {
                        http_response_code(400);
                        exit;
                     }
                     if($GLOBALS['medias']->delete_media($_POST['mediaID'])) {
                        http_response_code(200);
                     } else {
                        http_response_code(500);
                        echo 'Something went wrong while deleting media file';
                     }
                  }
               }

            break;
            #Set a featured post
            case 'add-feature-post':

               if($_SERVER['REQUEST_METHOD'] == 'POST') {
                  
                  if(isset($_POST['postID']) && !empty($_POST['postID'])) {
                     $post_id = (int) $_POST['postID'];
                     $status = $GLOBALS['posts']->add_feature_post($post_id);
                     if($status == 1){
                        http_response_code(200);
                        echo 'This post was removed from featured posts';
                     } elseif($status == 2) {
                        http_response_code(500);
                        echo 'There was an error removing this post from featured posts';
                     } elseif($status == 3) {
                        http_response_code(200);
                        echo 'This post was added to featured posts';
                     } else {
                        http_response_code(500);
                        echo 'There was an error adding this post to featured posts';
                     }
                  }

               }

            break;
            #Change login email
            case 'change-email':

               if($_SERVER['REQUEST_METHOD'] == 'POST') {

                  if(isset($_SESSION['settings-change-email-otp']) && empty($_SESSION['settings-change-email-otp'])) {
                     unset($_SESSION['settings-change-email']);
                     unset($_SESSION['settings-change-email-password']);
                     unset($_SESSION['settings-change-email-otp']);
                  }

                  if(
                     isset($_SESSION['settings-change-email'])
                     && isset($_SESSION['settings-change-email-password'])
                     && isset($_SESSION['settings-change-email-otp'])
                  ) {

                     if(
                        $_SESSION['settings-change-email'] == $_POST['email']
                        && $_SESSION['settings-change-email-password'] == $_POST['password']
                     ) {

                        if($_SESSION['settings-change-email-otp'] == $_POST['otp']) {

                           $v1 = $v2 = null;
                           $sql = 'UPDATE users SET Email=? WHERE ID=?;';
                           $stmt = $GLOBALS['connection']->prepare($sql);
                           $stmt->bind_param('si', $v1, $v2);
                           $v1 = $_SESSION['settings-change-email'];
                           $v2 = USER['ID'];
                           if($stmt->execute()) {
                              echo 'Your email was changed successfully';
                              unset($_SESSION['settings-change-email']);
                              unset($_SESSION['settings-change-email-password']);
                              unset($_SESSION['settings-change-email-otp']);
                              $_SESSION['login-user']['Email'] = $_SESSION['settings-change-email'];
                           } else {
                              http_response_code(500);
                              echo 'Oops! Something went wrong, please try again';
                           }
                           $stmt->close();

                        } else {
                           http_response_code(201);
                           echo 'OTP mismatch';
                        }

                     } else {
                        unset($_SESSION['settings-change-email']);
                        unset($_SESSION['settings-change-email-password']);
                        unset($_SESSION['settings-change-email-otp']);
                     }

                  }elseif(isset($_POST['email']) && isset($_POST['password'])) {
                     $password = new Password($_POST['password']);
                     if(empty($_POST['email'])) {
                        http_response_code(400);
                        echo 'Provide a valid email address';
                     } elseif(!filter_Var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
                        http_response_code(400);
                        echo 'Invalid email address';
                     } elseif($_POST['email'] == USER['Email']) {
                        http_response_code(400);
                        echo 'You must provide a different email address';
                     } elseif(empty($_POST['password'])) {
                        http_response_code(400);
                        echo 'Confirm your login password';
                     } elseif(!$password->match(USER['Password'])) {
                        http_response_code(400);
                        echo 'Wrong password';
                     } else {
                        
                        $send_otp = $password->send_otp($_POST['email']);
                        if($send_otp !== false) {

                           http_response_code(201);
                           $_SESSION['settings-change-email'] = $_POST['email'];
                           $_SESSION['settings-change-email-password'] = $_POST['password'];
                           $_SESSION['settings-change-email-otp'] = $send_otp;

                        } else {
                           http_response_code(400);
                           echo 'There was an error sending OTP, please try again';
                        }

                     }
                  }

               }

            break;
            #Change login password
            case 'change-password':

               if($_SERVER['REQUEST_METHOD'] == 'POST') {

                  if(isset($_POST['oldPassword']) && isset($_POST['newPassword'])) {

                     if(empty($_POST['oldPassword'])) {
                        http_response_code(400);
                        echo 'Confirm old password';
                     } elseif(empty($_POST['newPassword'])) {
                        http_response_code(400);
                        echo 'Provide new password';
                     } elseif(strlen($_POST['newPassword']) < 6 || strlen($_POST['newPassword']) > 100) {
                        http_response_code(400);
                        echo 'Provide a strong new password';
                     } elseif($_POST['oldPassword'] == $_POST['newPassword']) {
                        http_response_code(400);
                        echo 'New password must be different from old password';
                     } else {

                        $old_password = new Password($_POST['oldPassword']);
                        $new_password = new Password($_POST['newPassword']);
                        if($old_password->match(USER['Password'])) {

                           $v1 = $v2 = null;
                           $sql = 'UPDATE `users` SET `Password`=? WHERE `ID`=?;';
                           $stmt = $GLOBALS['connection']->prepare($sql);
                           $stmt->bind_param('si', $v1, $v2);
                           $v1 = $new_password->hash();
                           $v2 = USER['ID'];
                           if($stmt->execute()) {

                              $_SESSION['login-user']['Password'] = $v1;
                              echo 'Password changed successfully';

                           } else {
                              http_response_code(400);
                              echo 'Oops! Something went wrong, please try again.';
                           }

                        } else {
                           http_response_code(400);
                           echo 'Old password mismatch';
                        }

                     }

                  }

               }

            break;
            #Logout loged in devices 
            case 'log-out-devices':

               if($_SERVER['REQUEST_METHOD'] == 'POST') {

                  if(isset($_POST['device_id'])) {

                     if(!User::logout_devices($_POST['device_id'])) {
                        http_response_code(400);
                        echo 'Could not logout device';
                     } else {
                        echo 'Device was loged out successfully';
                     }
                     
                  } elseif(isset($_POST['is_all'])) {
                     
                     if(!User::logout_devices(0, true)){
                        http_response_code(400);
                        echo 'Could not logout all devices';
                     } else {
                        echo 'All devices was loged out successfully';
                     }

                  }

                  exit;

               }

            break;
            #Load more posts
            case 'load-more-posts':

               $offset = isset($_GET['offset'])? $_GET['offset'] : 30;
               settype($offset, 'integer');

               $get_posts = $GLOBALS['posts']->getPosts(30, $offset);
               if(empty($get_posts)) {
                  http_response_code(204);
                  exit;
               }
               $template = new henen_template\Loader('dashboard-posts-root-li'); //Load dashboard-posts-root-li.tpl template
               $template->forEach('posts', $get_posts);
               $template->render(false);

            break;
            #Load more pages
            case 'load-more-pages':

               $offset = isset($_GET['offset'])? $_GET['offset'] : 30;
               settype($offset, 'integer');

               $get_pages = $GLOBALS['pages']->list_pages(30, $offset);
               if(empty($get_pages)) {
                  http_response_code(204);
                  exit;
               }
               $template = new henen_template\Loader('dashboard-pages-root-li'); //Load dashboard-pages-root-li.tpl template
               $template->forEach('pages', $get_pages);
               $template->render(false);

            break;
            #Load more featured posts
            case 'load-more-feature-posts':

               $offset = isset($_GET['offset'])? $_GET['offset'] : 30;
               settype($offset, 'integer');

               $get_featured_posts = $GLOBALS['posts']->getFeaturePost(30, $offset);
               if(empty($get_featured_posts)) {
                  http_response_code(204);
                  exit;
               }
               $template = new henen_template\Loader('dashboard-featured-posts-root-li'); //Load dashboard-featured-posts-root-li.tpl template
               $template->forEach('posts', $get_featured_posts);
               $template->render(false);

            break;
            #Update contact social handles
            case 'update-social-handles':

               if($_SERVER['REQUEST_METHOD'] == 'POST') {

                  if(isset($_POST['handles'])) {
                     $handles = $_POST['handles'];
                     if(@json_decode($handles)) {
                        if(file_put_contents('social_links.json', $handles)) {
                           echo 'Social handles updated';
                           exit;
                        }
                     }
                     echo 'There was an error updating social handles';
                     
                  }

               }

            break;
            default:
            http_response_code(400);
         }


      } else {

         $template = new henen_template\Loader('dashboard'); //Load dashboard.tpl template
         $template->set('user.profile.name', USER['FullName']);
         $template->set('user.profile.cover', USER['Cover']);
         $template->forEach('posts', $GLOBALS['posts']->getPosts());
         $template->forEach('medias.editor.images', $GLOBALS['medias']->load_medias('image'));
         $template->forEach('medias.delete.images', $GLOBALS['medias']->load_medias('image'));
         $template->render(false);

      }


   });
   


   #Route for 404 pages
   $Route->for('/404', function(){

      $template = new henen_template\Loader('404');
      $template->set('page.title', '404 - Page Not Found');
      $template->set('application.name', strtoupper(htmlentities($GLOBALS['application']['application_name'])));
      $template->set('application.copyright', date('Y'));
      $template->forEach('header_social_links', $GLOBALS['social_links']);
      $template->forEach('footer_social_links', $GLOBALS['social_links']);
      $template->render(false);
      
   });
   

   #Route errors
   $Route->error_page(function() {

      $template = new henen_template\Loader('error');
      $template->set('page.title', 'Oops! That\' an error');
      $template->set('application.name', strtoupper(htmlentities($GLOBALS['application']['application_name'])));
      $template->set('application.copyright', date('Y'));
      $template->forEach('header_social_links', $GLOBALS['social_links']);
      $template->forEach('footer_social_links', $GLOBALS['social_links']);
      $template->render(false);

   });

   