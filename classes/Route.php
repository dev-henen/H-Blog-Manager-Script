<?php

    class Route {
        private string $request_url;
        private bool $is_any_page_rendered = false;
        function __construct() {
            if(strpos($_SERVER['REQUEST_URI'], '?') === false) {
                $this->request_url = $_SERVER['REQUEST_URI'];
            } else {
                $this->request_url = substr($_SERVER['REQUEST_URI'], 0, strpos($_SERVER['REQUEST_URI'], '?'));
            }
        }
        final public function for(string $request_url, callable $callback) {

            if($this->request_url == $request_url) {
                $callback();
                $this->is_any_page_rendered = true;
            }

        }
        final public function match(string $url_matching_pattern, callable $callback) {

            if(strpos($this->request_url, $url_matching_pattern) !== false) {
                $callback();
                $this->is_any_page_rendered = true;
            }

        }

        final public function error_page(callable $callback) {
            if($this->is_any_page_rendered === false) $callback();
        }
    }