<?php

    class Format {

        //public static function number_count(int | float $n): string {
        public static function number_count($n): string {
            $s = array('K', 'M', 'G', 'T');
            $out = '';
            while($n >= 1000 && count($s) > 0) {
                $n = $n / 1000.0;
                $out = array_shift($s);
            }
            return round($n, max(0, 3 - strlen((int)$n))) . "$out";
        }

        public static function size(int $bytes, $precision = 2): string {

            $kilobyte = 1024;
            $megabyte = $kilobyte * 1024;
            $gigabyte = $megabyte * 1024;
            $terabyte = $gigabyte * 1024;

            if($bytes < $kilobyte) {
                return $bytes . 'B';
            } elseif($bytes < $megabyte) {
                return round($bytes / $kilobyte, $precision) . 'KB';
            } elseif($bytes < $gigabyte) {
                return round($bytes / $megabyte, $precision) . 'MB';
            } elseif($bytes < $terabyte) {
                return round($bytes / $gigabyte, $precision) . 'GB';
            } else {
                return round($bytes / $terabyte, $precision) . 'TB';
            }

        }

        public static function percent($number, $of): string {
            return round(($number / $of) * 100, 2) . '%';
        }

        public static function get_client_ip_address(): string {
            $ip = " ";
            if(!empty($_SERVER["HTTP_CLIENT_IP"])) {
                $ip = ' '.$_SERVER["HTTP_CLIENT_IP"];
            } 
            if(!empty($_SERVER["HTTP_X_FORWARDED_FOR"])) {
                $ip = ' '.$_SERVER["HTTP_X_FORWARDED_FOR"];
            }
            if(!empty($_SERVER["REMOTE_ADDR"])) {
                $ip = ' '.$_SERVER["REMOTE_ADDR"];
            }
            return trim(preg_replace("/[^0-9\.\:]/", "", $ip));
        }

        public static function encrypt_string(String $string, String $encryption_key, $options = 0): string {
            $ciphering = "AES-128-CTR";
            $encryption_iv = '1234567891011121';
            $iv_length = openssl_cipher_iv_length($ciphering);
            //$encryption_iv  = ($iv_length !== false)? $iv_length : $encryption_iv;
            $encryption = openssl_encrypt($string, $ciphering, $encryption_key, $options, $encryption_iv);
            return $encryption;
        }
       
        public static function decrypt_string(String $string, String $encryption_key, $options = 0): string {
            $ciphering = "AES-128-CTR";
            $encryption_iv = '1234567891011121';
            $iv_length = openssl_cipher_iv_length($ciphering);
            //$encryption_iv  = ($iv_length !== false)? $iv_length : $encryption_iv;
            $decryption = openssl_decrypt($string, $ciphering, $encryption_key, $options, $encryption_iv);
            return $decryption;
        }

    }