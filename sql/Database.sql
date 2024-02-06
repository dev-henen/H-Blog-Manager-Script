-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 07, 2024 at 09:21 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dynamic_blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `feature_post`
--

CREATE TABLE `feature_post` (
  `ID` int(11) NOT NULL,
  `PostID` int(11) NOT NULL,
  `FeaturedTime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feature_post`
--

INSERT INTO `feature_post` (`ID`, `PostID`, `FeaturedTime`) VALUES
(19, 44, '2024-02-05 20:42:29'),
(20, 46, '2024-02-05 20:42:39'),
(21, 42, '2024-02-05 20:42:52');

-- --------------------------------------------------------

--
-- Table structure for table `login_devices`
--

CREATE TABLE `login_devices` (
  `ID` int(11) NOT NULL,
  `Token` varchar(255) NOT NULL,
  `DeviceName` varchar(255) NOT NULL,
  `IPAddress` varchar(255) DEFAULT NULL,
  `State` enum('loged_out','loged_in','','') NOT NULL DEFAULT 'loged_out',
  `LogedDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `LastLogedIn` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `medias`
--

CREATE TABLE `medias` (
  `ID` int(11) NOT NULL,
  `MediaType` enum('video','image','','') NOT NULL,
  `URI` varchar(255) NOT NULL,
  `UploadDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medias`
--

INSERT INTO `medias` (`ID`, `MediaType`, `URI`, `UploadDate`) VALUES
(3, 'image', '57831531-73819d8ce8f5413cac42cf1c907bc37a.jpg', '2024-01-27 10:07:47'),
(4, 'image', 'Good_Food_Display_-_NCI_Visuals_Online.jpg', '2024-01-27 10:07:47'),
(5, 'image', 'KxmnPjzL5sJA717HCLKs4uSCyjjX4JHVdi41LIUxfCrp6R4pv7JgbWhcgDGqH2_1704586077_0998256001704586077.jpg', '2024-01-27 10:07:47'),
(6, 'image', 'SAnrnQCyjxD2wpb2lz6XpqTwePnU7IuCWDWWLfjYUtf8tV6UolJTRTMoO_Z92e_1704583787_0066609001704583787.jpg', '2024-01-27 10:07:47'),
(7, 'image', 'Ultraprocessed-food-58d54c3.jpg', '2024-01-27 10:07:47'),
(8, 'image', 'Waste-management-in-beauty-can-be-improved-if-brands-add-value-and-step-up-communication-says-Certified-Sustainable.jpg', '2024-01-27 10:07:48'),
(12, 'image', 'green-chef-tilapia-tout-2000-540eb59a89ac4d00b1278bf6b033656b.jpg', '2024-01-27 10:07:48'),
(13, 'image', 'home-slider-1-1200x800.jpg', '2024-01-27 10:07:48'),
(16, 'image', 'shutterstock_518732392-632x444.jpg', '2024-01-27 10:07:48'),
(17, 'image', 'trendbeautyban.jpg', '2024-01-27 10:07:48'),
(19, 'image', 'TLF1gzOq7dxsgmC3HkhBP8ZWYAw00FKAPFmFZmLg9wVesPkidLhulK7_7NQXBm_1706353274_0206851001706353274.jpg', '2024-01-27 11:01:14'),
(20, 'image', '_65EG0XsJkfAodiva5nkEhU9j7nJ5M_IcbICuPR9POlJ2ssa_aM3mx8w_ZVQFF_1706353364_0138096001706353364.jpg', '2024-01-27 11:02:44'),
(21, 'image', 'py5VsaBnEm4kHLT_KSlIUz1GB1PEsfdNpgvf7lJQ4drKRmzLqfhFrkwfGYl3Hq_1706353462_0486675001706353462.jpg', '2024-01-27 11:04:22'),
(23, 'image', 'PyG5M1IyBmmDu74zQvEUEOx4VY568v9oeJ5EllyDRnaheGMlhVFIGd4BFD0fVt_1706353908_0528119001706353908.jpg', '2024-01-27 11:11:48'),
(24, 'image', 'PMY7tW7G3xbJSfvYJCjJaqQS7aVxWx26W2Wkc_9j3spnBz41QOZC_RbnSMl4Na_1706353914_0622313001706353914.jpg', '2024-01-27 11:11:54'),
(25, 'image', 'HZGAEB7HI0FrFeeuStJoZijOZ12ztQbBKNpyHA5kg8UZo2DdbR4Mnb2r7O0P6u_1706353921_0212623001706353921.jpg', '2024-01-27 11:12:01'),
(27, 'image', 'J7VDx0Pdg3bIofYmAJ8aZ12oP0i5VGQisaPFwj2tSGbbtO8wdEAfho2qLwkVfX_1706353941_0460551001706353941.jpg', '2024-01-27 11:12:21'),
(28, 'image', 'OfITkp3zvygepblqXZteQdcGx6PfE3ssWSJDSMlSwqZ4cbRdF3ORLT9KkB7YhU_1706353966_0548082001706353966.jpg', '2024-01-27 11:12:46'),
(29, 'image', 'R4GgrCb0iZVwXzoB4isCqdQAfaKZngqgxvw3PZU_bwKhJSjT04NGc2twaHXET4_1706353972_0221223001706353972.jpg', '2024-01-27 11:12:52'),
(30, 'image', 'x_Rs7kWiTyEhVqDasPtHdubYyQPSDvgS0Ag7kCNmsTayYQfXUIP4nVzfsov8JV_1706353978_0151547001706353978.jpg', '2024-01-27 11:12:58'),
(31, 'image', 'OPQjasTLoA7_kXuyWtnUFmhcwRLni5vS49fnxmRBNHjuL2FU2s2MS4fPvlQv2S_1706353984_0919052001706353984.jpg', '2024-01-27 11:13:04'),
(33, 'image', 'ijql9mpZ_g7Sv1fOuEBpVb_8BkyIDy8FZSCP9N3VwfUHCqaPoFUOFCvLXHIqri_1706354016_0414046001706354016.jpg', '2024-01-27 11:13:36'),
(34, 'image', '6pa4fQBrjNlZEiLsEoPdxzSEKlxE4V7ZOyfpGGxELpOI7UvgAe7WtFfkWCIbld_1706354035_0522811001706354035.jpg', '2024-01-27 11:13:55'),
(35, 'image', '8JBueLFDoInWxTJfikFZFCqNAilWtw67fQwBTryWmLkoZxzALc3iDIK_y6EYyH_1706354055_0443510001706354055.jpg', '2024-01-27 11:14:15'),
(36, 'image', 'iXmMPA9x2txSW6J7BU0n9k6wjxNWlXfBqvQTSYVoGiPliEFXV0OzmeUzcm4NSV_1706354061_0655025001706354061.jpg', '2024-01-27 11:14:21'),
(37, 'image', 'eZn5qu6dacdE83liviQ128c0oCuFGHDY8Anr9VCgAv2E0eMw6zhu6kS5LWu0Ii_1706354068_0127552001706354068.jpg', '2024-01-27 11:14:28'),
(38, 'image', '3H3Gb_JpYW3isxK3xfgE6pYyvBUXpkw86vV745jtR5OwTevEV_3ywOe7mPnZlS_1706354074_0326396001706354074.jpg', '2024-01-27 11:14:34'),
(39, 'image', 'yH29sSgLdR5C94lONrnUziJkSATXo_1N0IaKYVQrZRIi8uvFp56JfYk8_ghbNS_1706354080_0717243001706354080.jpg', '2024-01-27 11:14:40'),
(40, 'image', 'odNSiVABmELpSLny5sqSksiRfjqW7mjrUiwjrCVXiI1XyPjVrJGA0jAJBLYalL_1706354086_0291000001706354086.jpg', '2024-01-27 11:14:46'),
(42, 'image', 'm6mdvNqw13NBLywcaTvtyey9Z_fSEzBEHREer_2hSfYGayimA4nSOOHm6S_Ptr_1706354099_0495060001706354099.jpg', '2024-01-27 11:14:59'),
(43, 'image', 'QfD3GmpKwDabVTVMD7fuXH1xVszfXHhJmdtK0vjb6kSJOUb62L5eQGnBoo4bRZ_1706354108_0675697001706354108.jpg', '2024-01-27 11:15:08'),
(44, 'image', 'vflpXxipXSJJdA0onU9gWtPNcTM4QHFImADptsDsvhruuCcy6B_isOvZNePd9O_1706354116_0094682001706354116.jpg', '2024-01-27 11:15:16'),
(45, 'image', 'UcrRT8J_dz20AnI4jg5zNvshg1_jLRSUqqFICXjmjT7VxpzFmVw3Vm1Qamrn7I_1706354124_0439259001706354124.jpg', '2024-01-27 11:15:24'),
(46, 'image', 'Emci_6eQwf4RaFo5gyV9yVWXsZrjAEhMQTwr7CQ7UMoO6REnSxmcy_RffnIR6s_1706354134_0594380001706354134.jpg', '2024-01-27 11:15:34'),
(47, 'image', '5AKM7DY3XknfNDYeDHfmZfQbUmFSRKS8s5vIrA0MOu0PziM1jI7CXyIsGxK_RR_1706354144_0705550001706354144.jpg', '2024-01-27 11:15:44'),
(48, 'image', 'hm_ziXkLsfDZncERIpzRssBS9xkoNGNQgmbgHST6mUT5RoiRofUieitflJSeFo_1706354171_0051836001706354171.jpg', '2024-01-27 11:16:11'),
(50, 'image', 'Pstm7qBb2I7oRXz0HBo6wPWbo3N9XNh52VxFtGSTNXn5nkF2wwyH2GJSlH2hwr_1706354188_0951667001706354188.jpg', '2024-01-27 11:16:28'),
(51, 'image', 'isW3sTh9W16wrjMS3_2MA85PPAU8iHoz5OKLlgYRtT157uRz1sGL2nZ5PLuQ2H_1706354208_0957639001706354208.jpg', '2024-01-27 11:16:48'),
(52, 'image', 'E3_FRlGFfYFDvlghukgq44LcIkEpLRS5GwfRexCRKF39YLb7ycmb7qSKRRVfcP_1706354220_0871479001706354220.jpg', '2024-01-27 11:17:00'),
(55, 'image', '4rlB2trbaQGNPv3ajB3kYvnni0kBPv6FiTgnB7JG9dgRFyuLojKLmJgoejxpDy_1706354255_0205418001706354255.jpg', '2024-01-27 11:17:35'),
(56, 'image', 'PSn0SbREs8sGSDgp8OohYCHOGs5pY1pS3UCRR1UvcCur_kXgKO9Ba3XnEFYvS1_1706354272_0825056001706354272.jpg', '2024-01-27 11:17:52'),
(58, 'image', 'wC4jSPDNq8SeDR08ZKcmrTTnazia9WHZEYDpmUBqQhWcUBR7lyzszzj8NMrrzc_1706354293_0057737001706354293.jpg', '2024-01-27 11:18:13'),
(59, 'image', 'hS8mrute5wn7aUx9HhPkZ0a3dMf0r1jrRC7D3zD7KdqOg9k1V6avWaFRxUNmyq_1706354303_0357044001706354303.jpg', '2024-01-27 11:18:23'),
(60, 'image', '4gCLFB8l1k3VPMTdomRYIv0YVwJer2OSpDt0Ar4xmzWIflcrmqVaTGXN7xuxd7_1706354314_0321997001706354314.jpg', '2024-01-27 11:18:34'),
(61, 'image', '9jB1c40nZqcY95ZzRfE4MvrbFRfayrdy6MpYfndKGtocKqpkDkxA1j8qRXjjwI_1706354323_0293929001706354323.jpg', '2024-01-27 11:18:43'),
(62, 'image', 'Yx5detmUL1scQNeYEgd0wMkoQY6Lv5Sx1c_UPnbrSpueZM3tAoP6q7jdONRKTB_1706354333_0625251001706354333.jpg', '2024-01-27 11:18:53'),
(63, 'image', '4QXq0WlDePVMuA9P3iZk5akzsGeSThiRWP7x1POuDFBnnDvVRwgN6PE1GRd69n_1706354344_0440834001706354344.jpg', '2024-01-27 11:19:04'),
(64, 'image', 'QQHNMW1nUWi1jkQup0lQ00OZ2EtzKycbxjNlNkCuPINfyzJzt5GnQXItEwFUJt_1706354353_0339395001706354353.jpg', '2024-01-27 11:19:13'),
(65, 'image', 'AyRVmgsfU8cmZhcVldADE5B7t2qED98uqPqqoFPkicF2ZlwZQgfakMqRLNmhZt_1706354366_0232139001706354366.jpg', '2024-01-27 11:19:26'),
(66, 'image', 'NPratIIYy3Uu2Tt31aiVAGO_ObTUmIVFKxw57570jLwGNDlGVis7M4P50YYqh__1706354374_0573902001706354374.jpg', '2024-01-27 11:19:34'),
(67, 'image', '4cyXx5ME_uM9Pq18qsCEuBpCEoOGh7NXi_dnIVdlEfFLjxSQv77HKHIozouZoz_1706354384_0438331001706354384.jpg', '2024-01-27 11:19:44'),
(68, 'image', 'GpvFsZ5l7Isw7hvwPgmdxVHaBfpczgdOjhw9Vn9jNsBrevve1SSFK3lL2vd8ua_1706354392_0109119001706354392.jpg', '2024-01-27 11:19:52'),
(69, 'image', '1aWuIHUeCd4Zn_nkUOStXywZlg_EVmt280Gj2rOIDDf4kLPL5kyVZQGCEkN_k__1706354400_0264982001706354400.jpg', '2024-01-27 11:20:00'),
(70, 'video', 'jS1VmEjfRCeeVow000arQVXKCVZOiadbZjl8_GZwKeoJAZs0eDSnOOub4oWYXU_1706519227_0054702001706519227.mp4', '2024-01-29 09:07:07');

-- --------------------------------------------------------

--
-- Table structure for table `newsletters`
--

CREATE TABLE `newsletters` (
  `ID` int(11) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `SubscriptionDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `ID` int(11) NOT NULL,
  `Title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `URI` varchar(255) NOT NULL,
  `Privilege` enum('default','custom','') NOT NULL DEFAULT 'custom',
  `ShowInMenu` enum('true','false') NOT NULL DEFAULT 'true',
  `Content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `PageTime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`ID`, `Title`, `URI`, `Privilege`, `ShowInMenu`, `Content`, `PageTime`) VALUES
(1, 'About', 'about', 'default', 'true', '<h1>About HenenTheProgrammer</h1><p>Welcome to the world of HenenTheProgrammer, where passion meets programming! Henen is a dedicated and innovative software developer who is deeply passionate about creating elegant solutions to complex problems. With a keen interest in technology and a knack for coding, Henen brings a unique blend of creativity and technical expertise to every project.</p><h2>What Sets Henen Apart?</h2><p><b>Expertise:</b> With a strong foundation in various programming languages and technologies, Henen is well-versed in the ever-evolving landscape of software development.</p><p><b>Passion for Learning:</b> Henen is not just a developer; he is a lifelong learner. Constantly staying up-to-date with the latest industry trends and advancements, Henen embraces challenges with a thirst for knowledge.</p><p><b>Creative Solutions:</b> Whether it\'s crafting efficient algorithms, designing user-friendly interfaces, or optimizing code for peak performance, HenenTheProgrammer takes pride in delivering solutions that go beyond expectations.</p><p><b>Collaborative Spirit:</b> Recognizing the power of teamwork, Henen thrives in collaborative environments. Communication and cooperation are at the core of HenenTheProgrammer\'s approach to building successful projects.</p><h3>Connect with HenenTheProgrammer:</h3><p><b>Facebook:</b><a href=\"https://web.facebook.com/HenenTheProgrammer\"> HenenTheProgrammer on Facebook</a></p><p><b>Instagram:</b> <a href=\"https://www.instagram.com/henentheprogrammer/\">HenenTheProgrammer on Instagram</a></p><p><b>TikTok:</b> <a href=\"https://www.tiktok.com/@henentheprogrammer\">HenenTheProgrammer on TikTok</a></p><p><b>GitHub:</b> <a href=\"https://github.com/HenenTheProgrammer\">HenenTheProgrammer on GitHub</a></p><p>Follow HenenTheProgrammer on social media to stay updated on the latest coding adventures, projects, and insights into the world of software development.</p><p>If you have any inquiries, collaboration proposals, or just want to connect, feel free to reach out on any of the platforms mentioned above. HenenTheProgrammer looks forward to engaging with fellow enthusiasts, developers, and anyone passionate about the world of coding!</p>', '2024-02-03 21:07:40'),
(2, 'Contact', 'contact', 'default', 'true', '<h1>Contact Henen The Programmer</h1><p>Thank you for reaching out to Henen The Programmer! Feel free to connect with me on various social media platforms for updates, inquiries, or just to say hello.</p><h2>Social media links:</h2><p>Facebook: <a href=\"https://facebook.com/HenenTheProgrammer\">HenenTheProgrammer on Facebook</a></p><p>Instagram: <a href=\"https://www.instagram.com/henentheprogrammer/\">HenenTheProgrammer on Instagram</a></p><p>TikTok: <a href=\"https://www.tiktok.com/@henentheprogrammer\">HenenTheProgrammer on TikTok</a></p><p>GitHub: <a href=\"https://github.com/HenenTheProgrammer\">HenenTheProgrammer on GitHub</a></p><h2>Stay Connected:</h2><p>Feel free to follow, like, and subscribe to stay updated on the latest projects, coding adventures, and more! For specific inquiries or collaboration opportunities, you can also reach out via direct messages on these platforms.</p><p>I appreciate your interest and look forward to connecting with you!</p><p>Best,</p><p>HenenTheProgrammer</p><p><br></p>', '2024-02-03 21:00:11'),
(3, 'Privacy Policy', 'privacy-policy', 'default', 'true', 'This is a blog privacy policy page', '2024-01-03 07:38:30'),
(28, 'Test Page', 'test-page', 'custom', 'true', '<h1>This is a test page</h1><p>This page was added to menu</p><h2>Here is a test video in the page</h2><p>\r\n    </p><div class=\"video\" id=\"videoContainer\" contenteditable=\"false\" draggable=\"false\" style=\"user-select:none;\">\r\n    <div class=\"screen\" contenteditable=\"false\" draggable=\"false\">\r\n        <video width=\"100%\" id=\"video\">\r\n            <source src=\"/uploads/jS1VmEjfRCeeVow000arQVXKCVZOiadbZjl8_GZwKeoJAZs0eDSnOOub4oWYXU_1706519227_0054702001706519227.mp4\" id=\"videoSource\">\r\n            <strong>Sorry your browser can\'t play this video</strong>\r\n        </video>\r\n        <div class=\"play-overlay\">\r\n            <div class=\"inner\">\r\n                <button onclick=\"play();\" id=\"playerCircle\"><i class=\"fa fa-play-circle-o\"></i></button>\r\n            </div>\r\n        </div>\r\n        <div class=\"error-overlay\" id=\"videoPlayError\" style=\"display:none;\">\r\n            <div class=\"inner\">\r\n                <div><i class=\"fa fa-exclamation-circle\"></i></div>\r\n            </div>\r\n        </div>\r\n        <div class=\"progress-area\">\r\n            <div class=\"loader\">\r\n                <div class=\"track\" id=\"track\" style=\"width: 0%;\"></div>\r\n                <input type=\"range\" width=\"100%\" min=\"0\" max=\"60\" value=\"0\" id=\"range\">\r\n            </div>\r\n        </div>\r\n        <div id=\"playingDuration\">0:0:0</div>\r\n        <div id=\"showDuration\">00:00:00</div>\r\n        <div class=\"spin\" id=\"spin\"><div><div></div></div></div>\r\n    </div>\r\n    <div class=\"controls\">\r\n        <div>\r\n            <div>\r\n                <input type=\"range\" width=\"100%\" min=\"0\" max=\"100\" value=\"100\" class=\"volumn\" id=\"volume\" title=\"Volumn\">\r\n                <span id=\"volumePercent\">100%</span>\r\n            </div>\r\n        </div>\r\n        <div>\r\n            <button class=\"previous\" onclick=\"previous();\" title=\"Previous\"><i class=\"fa fa-fast-backward\"></i></button>\r\n            <button id=\"playerInControls\" class=\"playerInControls\" onclick=\"play();\" title=\"Play/Pause\"><i class=\"fa fa-play\"></i></button>\r\n            <button class=\"next\" onclick=\"next();\" title=\"next\"><i class=\"fa fa-fast-forward\"></i></button>\r\n        </div>\r\n        <div>\r\n            <button class=\"mute\" onclick=\"muteVolume();\" title=\"Mute\" id=\"mute\"><i class=\"fa fa-volume-up\"></i></button>\r\n            <button class=\"fullscreen\" onclick=\"fullscreen();\" title=\"Fullscreen\"><i class=\"fa fa-arrows-alt\"></i></button>\r\n        </div>\r\n    </div>\r\n    </div><br><p></p><p><br></p><h3>Here I write a quote to preview how quotes look in the editor:</h3><blockquote>Learn to code and you will never complain about bug in a software or videogames ever again. - <b>Jack Forge</b></blockquote><p><b><br></b></p><p>And here is an image demonstration of the quote above:</p><p><span class=\"dynamic-image\" style=\"display: inline-block; overflow: hidden; width: 513px; min-width: 50px; max-width: 100%;\" contenteditable=\"false\" draggable=\"false\"><img src=\"/uploads/hS8mrute5wn7aUx9HhPkZ0a3dMf0r1jrRC7D3zD7KdqOg9k1V6avWaFRxUNmyq_1706354303_0357044001706354303.jpg\" alt=\"image\" width=\"100%\" draggable=\"false\"></span><br></p><p><b>Do you know? </b>Images are resize able in the editor.</p><p><br></p><p>Thanks!</p><p>About me <a href=\"/p/about\">Moses Henen&nbsp;</a><br></p>', '2024-02-05 22:40:10');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `ID` int(11) NOT NULL,
  `Title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `URI` varchar(255) NOT NULL,
  `Labels` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Status` enum('draft','publish','','') NOT NULL DEFAULT 'publish',
  `FeatureImage` varchar(255) DEFAULT NULL,
  `Content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `PostTime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`ID`, `Title`, `URI`, `Labels`, `Status`, `FeatureImage`, `Content`, `PostTime`) VALUES
(41, 'The Enchanting World of Sushi: A Culinary Symphony of Flavors', 'the-enchanting-world-of-sushi-a-culinary-symphony-of-flavors', '[\"Sushi\",\"Symphony\",\"Flavors\"]', 'publish', '/uploads/57831531-73819d8ce8f5413cac42cf1c907bc37a.jpg', '<h2>The Enchanting World of Sushi: A Culinary Symphony of Flavors</h2><p><span class=\"dynamic-image\" style=\"display: inline-block; overflow: hidden; width: 354px; min-width: 50px; max-width: 100%;\" contenteditable=\"false\" draggable=\"false\"><img src=\"/uploads/57831531-73819d8ce8f5413cac42cf1c907bc37a.jpg\" alt=\"image\" width=\"100%\" draggable=\"false\"></span><br></p><p><b>Introduction:</b></p><p>Sushi, a Japanese culinary masterpiece, has transcended its cultural origins to become a global sensation. This delectable dish, characterized by the perfect marriage of vinegared rice, fresh seafood, and a myriad of other ingredients, offers a culinary experience that is both visually stunning and gastronomically delightful. Let\'s embark on a journey to explore the enchanting world of sushi and unravel the secrets behind its popularity.</p><h3>History and Evolution:</h3><p>Sushi\'s origins can be traced back to ancient Japan, where it was initially a preservation method for fermented rice and fish. Over time, this preservation technique evolved into what we now recognize as sushi. In the Edo period (1603-1868), street vendors began selling sushi, and it gradually transformed into a popular fast food in Tokyo. In the 20th century, sushi experienced a global renaissance, with chefs outside Japan incorporating local ingredients and techniques, giving rise to diverse sushi styles.</p><h3>The Art of Making Sushi:</h3><p>Crafting the perfect sushi requires skill, precision, and an eye for aesthetics. Sushi chefs, or Itamae, undergo rigorous training to master the art of rice preparation, knife skills, and flavor balancing. The choice of ingredients is crucial, with an emphasis on the freshest seafood, high-quality rice, and the right combination of sauces and condiments.</p><h3>Types of Sushi:</h3><p>Sushi comes in various forms, each with its unique preparation and presentation. Nigiri, perhaps the most iconic style, consists of a small mound of vinegared rice topped with fresh seafood or other ingredients. Sashimi is thinly sliced raw fish served without rice, highlighting the purity of flavors. Maki involves rolling rice, fish, and vegetables in seaweed, while Temaki takes the form of a hand-rolled cone. These variations showcase the versatility of sushi, catering to diverse preferences.</p><h3>Flavor Symphony:</h3><p>The magic of sushi lies in its ability to create a symphony of flavors in each bite. The vinegared rice provides a subtle tanginess, complemented by the richness of fresh fish, the crunch of vegetables, and the umami notes of soy sauce and wasabi. The combination of textures and tastes creates a harmonious experience that tantalizes the taste buds.</p><h3>Health Benefits:</h3><p>Beyond its exquisite taste, sushi offers several health benefits. Rich in omega-3 fatty acids from fish like salmon and tuna, sushi promotes heart health and supports brain function. Additionally, the inclusion of seaweed provides essential minerals like iodine and iron. The emphasis on fresh, raw ingredients ensures a nutrient-rich dining experience.</p><h3>Global Influence:</h3><p>Sushi\'s global popularity has led to innovative adaptations and fusions, giving rise to unconventional rolls and combinations. From California rolls with avocado to tempura shrimp rolls, chefs around the world continue to push the boundaries of traditional sushi, creating a culinary melting pot that caters to diverse palates.</p><h3>Conclusion:</h3><p>In the realm of culinary delights, sushi stands out as a true masterpiece, blending tradition with innovation. Its rich history, meticulous preparation, and diverse variations contribute to its allure, making it a beloved food worldwide. Whether you are a sushi connoisseur or a novice eager to explore new flavors, the enchanting world of sushi invites everyone to savor the magic of this iconic dish.</p>', '2024-01-29 10:29:52'),
(42, 'A Divine Journey through the World&#039;s Favorite Indulgence', 'the-allure-of-chocolate-a-divine-journey-through-the-worlds-favorite-indulgence', '[\"Allure\",\"Chocolate\",\"Indulgence\"]', 'publish', '/uploads/Good_Food_Display_-_NCI_Visuals_Online.jpg', '<h2>The Allure of Chocolate: A Divine Journey through the World\'s Favorite Indulgence</h2><p><span class=\"dynamic-image\" style=\"display: inline-block; overflow: hidden; width: 374px; min-width: 50px; max-width: 100%;\" contenteditable=\"false\" draggable=\"false\"><img src=\"/uploads/Good_Food_Display_-_NCI_Visuals_Online.jpg\" alt=\"image\" width=\"100%\" draggable=\"false\"></span><br></p><p><b>Introduction:</b></p><p>Chocolate, with its irresistible aroma, velvety texture, and heavenly taste, has captured the hearts of people around the globe for centuries. This delectable treat, derived from the cacao bean, transcends cultural boundaries and holds a special place in our hearts. Join us on a delightful journey through the fascinating world of chocolate, exploring its history, production, and the myriad ways it has become an integral part of our lives.</p><p><span class=\"dynamic-image\" style=\"display: inline-block; overflow: hidden; width: 387px; min-width: 50px; max-width: 100%;\" contenteditable=\"false\" draggable=\"false\"><img src=\"/uploads/SAnrnQCyjxD2wpb2lz6XpqTwePnU7IuCWDWWLfjYUtf8tV6UolJTRTMoO_Z92e_1704583787_0066609001704583787.jpg\" alt=\"image\" width=\"100%\" draggable=\"false\"></span><br></p><h3>History and Origin:</h3><p>The story of chocolate begins in the ancient civilizations of Mesoamerica, where the Mayans and Aztecs cultivated and consumed cacao as a bitter beverage. With the arrival of chocolate in Europe in the 16th century, it underwent a transformation as sugar and milk were added to create the sweet and creamy confection we know today. Over the centuries, chocolate evolved from a luxury reserved for royalty to a beloved treat accessible to people worldwide.</p><h3>Cacao Bean to Chocolate Bar:</h3><p>The journey from cacao bean to chocolate bar is a meticulous process that involves harvesting, fermentation, drying, roasting, grinding, and conching. Cacao trees bear large pods containing beans, which are extracted, fermented to develop flavor, dried, and then roasted to bring out their distinctive taste. The roasted beans are ground into a paste, and through the conching process, the chocolate gains its smooth texture. Finally, sugar, milk, and other ingredients are added to create the various forms of chocolate we adore.</p><h3>Types of Chocolate:</h3><p>The world of chocolate offers a delightful array of options, from the intense bitterness of dark chocolate to the silky sweetness of milk chocolate and the rich creaminess of white chocolate. Dark chocolate, with its high cocoa content, is celebrated for its potential health benefits, including antioxidants and mood-enhancing properties. Milk chocolate, with added milk solids and sugar, is a beloved classic, while white chocolate, made from cocoa butter, sugar, and milk solids, offers a sweet and creamy alternative.</p><h3>Chocolate in Culture and Celebrations:</h3><p>Chocolate has become intertwined with cultural traditions and celebrations around the world. Whether exchanged as gifts on Valentine\'s Day, molded into Easter eggs, or enjoyed during festive holidays, chocolate plays a central role in expressing love and joy. Its versatility extends beyond confectionery, finding its way into beverages, desserts, and even savory dishes, showcasing its adaptability in the culinary world.</p><h3>Health Benefits and Indulgence:</h3><p>While chocolate is often considered an indulgence, it also boasts potential health benefits. Dark chocolate, in particular, is recognized for its antioxidants, which may contribute to heart health and cognitive function. Additionally, chocolate has been linked to the release of endorphins, earning its reputation as a mood enhancer.</p><p><b>Conclusion:</b></p><p>From its ancient origins to its modern-day allure, chocolate has evolved into a universal symbol of indulgence and pleasure. Whether savored in its purest form, incorporated into decadent desserts, or enjoyed as a comforting beverage, chocolate continues to captivate our senses and bring joy to people of all ages. As we delve into the diverse world of chocolate, we can appreciate the craftsmanship, cultural significance, and sheer delight that this beloved treat has to offer.</p>', '2024-01-29 10:33:12'),
(43, 'The Wholesome Charm of Avocado: Nature&#039;s Green Gold', 'the-wholesome-charm-of-avocado-natures-green-gold', '[\"Avocado\",\"Green Gold\"]', 'publish', '/uploads/KxmnPjzL5sJA717HCLKs4uSCyjjX4JHVdi41LIUxfCrp6R4pv7JgbWhcgDGqH2_1704586077_0998256001704586077.jpg', '<h2>The Wholesome Charm of Avocado: Nature\'s Green Gold</h2><p><span class=\"dynamic-image\" style=\"display: inline-block; overflow: hidden; width: 372px; min-width: 50px; max-width: 100%;\" contenteditable=\"false\" draggable=\"false\"><img src=\"/uploads/KxmnPjzL5sJA717HCLKs4uSCyjjX4JHVdi41LIUxfCrp6R4pv7JgbWhcgDGqH2_1704586077_0998256001704586077.jpg\" alt=\"image\" width=\"100%\" draggable=\"false\"></span><br></p><p><b>Introduction:</b></p><p>Avocado, hailed as nature\'s green gold, has risen to culinary stardom for its creamy texture, versatility, and numerous health benefits. Originating from Central America, this nutrient-packed fruit has transcended its tropical roots to become a global sensation. Join us on a journey through the wholesome charm of avocados, exploring their rich history, culinary applications, and the myriad ways they contribute to a healthy and delicious lifestyle.</p><h3>History and Origin:</h3><p>The avocado, scientifically known as Persea americana, traces its roots back to ancient Mesoamerican civilizations, including the Aztecs and the Maya. Revered for both its nutritional value and cultural significance, avocados were often referred to as \"ahuacatl,\" meaning testicle, a nod to the fruit\'s shape. Introduced to the Western world by Spanish explorers, avocados gradually spread to different continents, becoming a cherished ingredient in diverse cuisines.</p><h3>Nutritional Powerhouse:</h3><p>Beyond its delectable taste and smooth texture, avocados are a nutritional powerhouse. Packed with heart-healthy monounsaturated fats, avocados also provide a rich source of vitamins, including potassium, vitamin K, vitamin E, and vitamin C. Additionally, avocados are a good source of dietary fiber, aiding digestion and promoting a feeling of fullness.</p><h3>Culinary Versatility:</h3><p>Avocados have become a culinary darling for their incredible versatility. Whether sliced and added to salads, mashed into guacamole, spread on toast, or blended into smoothies, avocados seamlessly integrate into a wide range of dishes. The fruit\'s creamy consistency can even be used as a substitute for butter or mayonnaise, offering a healthier alternative without compromising taste.</p><h3>From Savory to Sweet:</h3><p>While avocados are typically associated with savory dishes, their adaptability extends to sweet treats as well. In desserts, avocados can be transformed into creamy puddings, ice creams, or incorporated into chocolate mousse, adding a unique and velvety texture. The subtle flavor of avocados pairs well with sweet ingredients, showcasing their ability to elevate both sides of the culinary spectrum.</p><h3>A Global Superfood:</h3><p>Avocados\' popularity has soared in recent years, earning them the status of a global superfood. Beyond their culinary applications, avocados have become a symbol of wellness, featuring prominently in health-conscious diets. The avocado toast trend, for instance, has become a cultural phenomenon, celebrated for its simplicity, taste, and nutritional benefits.</p><h3>Environmental Impact:</h3><p>The cultivation of avocados, however, has raised environmental concerns due to water usage and deforestation in some regions. Responsible farming practices and sustainable sourcing are becoming increasingly important to address these issues and ensure the long-term viability of avocado production.</p><p><b>Conclusion:</b></p><p>Avocado\'s journey from ancient Mesoamerican civilizations to modern-day kitchens reflects its enduring appeal and nutritional significance. As a versatile ingredient that caters to a range of tastes and dietary preferences, avocados continue to be celebrated for their creamy texture, rich flavor, and numerous health benefits. Whether enjoyed on a piece of toast, in a salad, or as part of a decadent dessert, avocados stand as a testament to the harmonious fusion of culinary delight and well-being.</p>', '2024-01-29 10:36:30'),
(44, 'Olive Oil: Liquid Gold of the Mediterranean Diet', 'olive-oil-liquid-gold-of-the-mediterranean-diet', '[\"Mediterranean Diet\"]', 'publish', '/uploads/SAnrnQCyjxD2wpb2lz6XpqTwePnU7IuCWDWWLfjYUtf8tV6UolJTRTMoO_Z92e_1704583787_0066609001704583787.jpg', '<h2>Olive Oil: Liquid Gold of the Mediterranean Diet</h2><p><span class=\"dynamic-image\" style=\"display: inline-block; overflow: hidden; width: 370px; min-width: 50px; max-width: 100%;\" contenteditable=\"false\" draggable=\"false\"><img src=\"/uploads/SAnrnQCyjxD2wpb2lz6XpqTwePnU7IuCWDWWLfjYUtf8tV6UolJTRTMoO_Z92e_1704583787_0066609001704583787.jpg\" alt=\"image\" width=\"100%\" draggable=\"false\"></span><br></p><p><b>Introduction:</b></p><p>Olive oil, often referred to as the liquid gold of the Mediterranean, has been a staple in culinary traditions for centuries. Renowned for its rich flavor, versatility, and numerous health benefits, olive oil is more than just a cooking ingredient; it\'s a cultural icon that embodies the essence of Mediterranean cuisine. Join us on a journey to explore the golden elixir that has graced tables and kitchens worldwide.</p><p><br></p><h3>Cultivation and Heritage:</h3><p><span class=\"dynamic-image\" style=\"display: inline-block; overflow: hidden; width: 348px; min-width: 50px; max-width: 100%;\" contenteditable=\"false\" draggable=\"false\"><img src=\"/uploads/green-chef-tilapia-tout-2000-540eb59a89ac4d00b1278bf6b033656b.jpg\" alt=\"image\" width=\"100%\" draggable=\"false\"></span><br></p><p>Olive oil has deep roots in the Mediterranean region, where olive trees have been cultivated for thousands of years. The ancient Greeks and Romans not only appreciated the oil for its culinary uses but also valued it in religious ceremonies and as a symbol of prosperity. Today, the cultivation of olive trees extends beyond the Mediterranean, with countries like Spain, Italy, and Greece leading the production of this precious liquid.</p><h3>Varieties and Production:</h3><p><span class=\"dynamic-image\" style=\"display: inline-block; overflow: hidden; width: 346px; min-width: 50px; max-width: 100%;\" contenteditable=\"false\" draggable=\"false\"><img src=\"/uploads/Ultraprocessed-food-58d54c3.jpg\" alt=\"image\" width=\"100%\" draggable=\"false\"></span><br></p><p>Olive oil comes in various grades and types, each distinguished by its production process, acidity levels, and flavor profiles. Extra virgin olive oil, considered the highest quality, is cold-pressed without the use of heat or chemicals, preserving the natural flavors and aromas of the olives. Virgin olive oil, pure olive oil, and refined olive oil represent different grades, each offering a unique set of characteristics suitable for various culinary applications.</p><h3>Health Benefits:</h3><p><span class=\"dynamic-image\" style=\"display: inline-block; overflow: hidden; width: 336px; min-width: 50px; max-width: 100%;\" contenteditable=\"false\" draggable=\"false\"><img src=\"/uploads/cWof0dopxCkRvBPbRA9g6AVXZfzH3yo8gQt5rJ25upArVEwA66E7w4bM2y2ivW_1704584818_0229144001704584818.jpg\" alt=\"image\" width=\"100%\" draggable=\"false\"></span><br></p><p>Beyond its delightful taste, olive oil is celebrated for its health-promoting properties. Rich in monounsaturated fats and antioxidants, particularly vitamin E and polyphenols, olive oil is associated with heart health, inflammation reduction, and improved cholesterol levels. The Mediterranean diet, which emphasizes olive oil as a primary fat source, has been linked to numerous health benefits, including longevity and reduced risk of chronic diseases.</p><h3>Culinary Versatility:</h3><p><span class=\"dynamic-image\" style=\"display: inline-block; overflow: hidden; width: 359px; min-width: 50px; max-width: 100%;\" contenteditable=\"false\" draggable=\"false\"><img src=\"/uploads/Ultraprocessed-food-58d54c3.jpg\" alt=\"image\" width=\"100%\" draggable=\"false\"></span><br></p><p>Olive oil\'s versatility in the kitchen knows no bounds. From drizzling over salads to sautÃ©ing vegetables, marinating meats, and creating flavorful dressings, olive oil enhances the taste and nutritional value of a wide array of dishes. Its ability to complement both savory and sweet flavors makes it a prized ingredient in Mediterranean and international cuisines alike.</p><h3>Elevating the Dining Experience:</h3><p><span class=\"dynamic-image\" style=\"display: inline-block; overflow: hidden; width: 396px; min-width: 50px; max-width: 100%;\" contenteditable=\"false\" draggable=\"false\"><img src=\"/uploads/ays3v_TkuWX6yvgs90i6PL2NQ6kjDZB6MzKlIEqNHhb0cWTRCXUXzzorGR8NYk_1704586219_0296361001704586219.jpg\" alt=\"image\" width=\"100%\" draggable=\"false\"></span><br></p><p>The use of olive oil extends beyond the kitchen; it contributes to the overall dining experience. Dipping fresh bread into a pool of extra virgin olive oil, often seasoned with herbs and spices, has become a cherished ritual in many cultures. The nuanced flavors and textures of different olive oils can add depth and sophistication to dishes, making them not only delicious but also memorable.</p><h3>Sustainability and Quality:</h3><p><span class=\"dynamic-image\" style=\"display: inline-block; overflow: hidden; width: 401px; min-width: 50px; max-width: 100%;\" contenteditable=\"false\" draggable=\"false\"><img src=\"/uploads/SAnrnQCyjxD2wpb2lz6XpqTwePnU7IuCWDWWLfjYUtf8tV6UolJTRTMoO_Z92e_1704583787_0066609001704583787.jpg\" alt=\"image\" width=\"100%\" draggable=\"false\"></span><br></p><p>As the demand for olive oil continues to grow, ensuring sustainability and maintaining quality standards are paramount. Responsible farming practices, ethical harvesting, and adherence to certification systems play a crucial role in preserving the integrity of olive oil production and safeguarding the environment.</p><p><b>Conclusion:</b></p><p>Olive oil\'s journey from ancient rituals to modern kitchens is a testament to its enduring appeal and cultural significance. As a key ingredient in the Mediterranean diet and a symbol of health and vitality, olive oil continues to enrich our culinary experiences and contribute to a lifestyle that values both flavor and well-being. With its golden hue and complex flavors, olive oil remains a true treasure in the world of gastronomy.</p>', '2024-01-29 10:39:55'),
(45, 'Earth&#039;s Hidden Culinary Gems', 'the-enigmatic-elegance-of-truffles-earths-hidden-culinary-gems', '[\"Enigmatic\",\"Truffles\",\"Culinary\"]', 'publish', '/uploads/Ultraprocessed-food-58d54c3.jpg', '<h2>The Enigmatic Elegance of Truffles: Earth\'s Hidden Culinary Gems</h2><p><span class=\"dynamic-image\" style=\"display: inline-block; overflow: hidden; width: 406px; min-width: 50px; max-width: 100%;\" contenteditable=\"false\" draggable=\"false\"><img src=\"/uploads/Ultraprocessed-food-58d54c3.jpg\" alt=\"image\" width=\"100%\" draggable=\"false\"></span><br></p><p><b>Introduction:</b></p><p>Truffles, the elusive and aromatic fungi that grow beneath the surface of certain trees, have captivated the culinary world with their unparalleled flavor and distinctive fragrance. Revered as Earth\'s hidden culinary gems, truffles hold a mystique that extends from ancient civilizations to modern haute cuisine. Join us on an exploration of the enigmatic elegance of truffles, unearthing the secrets behind their cultivation, culinary applications, and the gastronomic allure that makes them a symbol of luxury and indulgence.</p><h3>Mysterious Origins:</h3><p>Truffles have a long and storied history, dating back to ancient times when they were prized by the Greeks and Romans for their mythical origins. Legends associated truffles with the gods, believing that they were formed when lightning struck the earth. Today, truffles are found in various regions around the world, with notable varieties including the black PÃ©rigord truffle from France and the white Alba truffle from Italy.</p><h3>Cultivation and Harvesting:</h3><p>The cultivation of truffles, known as trufficulture, involves a delicate and complex process. These fungi form symbiotic relationships with the roots of certain trees, such as oak and hazelnut. Truffle orchards are meticulously managed to replicate the natural conditions required for truffle growth. The harvesting process is equally intricate, as trained dogs or pigs are used to sniff out the hidden treasures beneath the soil, ensuring minimal damage to the delicate truffle.</p><h3>A Symphony of Aromas:</h3><p>The allure of truffles lies in their distinct and captivating aroma. The compounds responsible for their fragrance are volatile and released when the truffle is sliced or shaved. Described as earthy, musky, and with hints of garlic or nutmeg, the scent of truffles elevates dishes to a level of sophistication that is unparalleled in the culinary world.</p><h3>Culinary Delights:</h3><p>Truffles are a culinary delicacy that can transform ordinary dishes into extraordinary masterpieces. Whether shaved over pasta, infused into oils, incorporated into sauces, or used in truffle-infused products like salts and butters, their intense flavor imparts a decadent and luxurious touch to a wide range of dishes. Truffle hunting and dining experiences have become sought-after activities, allowing enthusiasts to savor the magic of these elusive fungi firsthand.</p><h3>Seasonal Rarity and Culinary Events:</h3><p>Truffles are a seasonal delicacy, and their limited availability contributes to their exclusivity and high market value. The truffle season varies depending on the type and region, with late autumn to winter being the prime months for many varieties. Culinary events, such as truffle festivals, celebrate the harvest and showcase the culinary creativity inspired by these precious fungi.</p><h3>Luxury and Symbolism:</h3><p>Truffles are synonymous with luxury, elegance, and refined taste. Often referred to as \"diamonds of the kitchen,\" they command high prices in the market due to their scarcity and labor-intensive cultivation. Beyond their culinary significance, truffles have become a status symbol, gracing the tables of Michelin-starred restaurants and fine dining establishments around the world.</p><p><b>Conclusion:</b></p><p>Truffles, with their mysterious origins and unparalleled fragrance, continue to captivate the senses and elevate the world of gastronomy. From ancient legends to modern culinary indulgence, these hidden gems have retained their mystique and allure. As we savor the enigmatic elegance of truffles, we partake in a culinary journey that celebrates the artistry, luxury, and unparalleled flavors that make truffles a timeless symbol of gastronomic excellence.</p>', '2024-01-29 10:43:26'),
(46, 'Vietnam&#039;s Soulful Noodle Elixir', 'the-art-of-pho-vietnams-soulful-noodle-elixir', '[\"Soulful Noodle Elixir\"]', 'publish', '/uploads/green-chef-tilapia-tout-2000-540eb59a89ac4d00b1278bf6b033656b.jpg', '<h2>The Art of Pho: Vietnam\'s Soulful Noodle Elixir</h2><p><span class=\"dynamic-image\" style=\"display: inline-block; overflow: hidden; width: 420px; min-width: 50px; max-width: 100%;\" contenteditable=\"false\" draggable=\"false\"><img src=\"/uploads/green-chef-tilapia-tout-2000-540eb59a89ac4d00b1278bf6b033656b.jpg\" alt=\"image\" width=\"100%\" draggable=\"false\"></span><br></p><p><b>Introduction:</b></p><p>Pho, a steaming bowl of aromatic broth, rice noodles, and flavorful toppings, stands as a symbol of Vietnamese culinary prowess and hospitality. Hailing from the bustling streets of Hanoi, this soulful noodle soup has taken the world by storm, captivating taste buds with its harmonious blend of savory broth, fresh herbs, and tender meats. Join us on a culinary expedition through the artistry of Pho, uncovering its origins, the meticulous preparation behind it, and the cultural significance that makes it a cherished dish around the globe.</p><h3>Historical Roots:</h3><p>Pho\'s origins trace back to early 20th-century Northern Vietnam, where it emerged as a fusion of local culinary traditions and French influences. Initially sold by street vendors, Pho quickly gained popularity, evolving into a beloved comfort food enjoyed by people from all walks of life. Today, it is considered a national dish and an ambassador of Vietnamese cuisine.</p><h3>The Art of Broth:</h3><p>At the heart of any exceptional bowl of Pho is the broth, simmered to perfection with a delicate balance of spices, charred onions, ginger, and beef or chicken bones. The slow-cooking process extracts the essence of the ingredients, resulting in a clear, aromatic broth that forms the foundation of this soul-warming dish. Each family and restaurant has its secret blend of spices, creating a distinctive flavor profile that makes their Pho unique.</p><h3>Rice Noodles and Toppings:</h3><p>The thin, flat rice noodles, or \"bÃ¡nh phá»Ÿ,\" are a crucial element of Pho, providing a chewy texture that complements the rich broth. The noodles are cooked separately and added to the bowl just before serving, ensuring they maintain their distinct consistency. Toppings vary but typically include thinly sliced beef or chicken, fresh herbs like cilantro and basil, bean sprouts, lime wedges, and chili for those who crave a bit of heat.</p><h3>Regional Variations:</h3><p>While Pho has become a global sensation, it still reflects regional variations within Vietnam. Northern-style Pho tends to have a simpler broth, with a focus on the purity of flavors. Southern-style Pho, on the other hand, is often sweeter, incorporating additional herbs and condiments. Regional nuances contribute to the diversity of Pho, offering a spectrum of tastes to suit different palates.</p><h3>Cultural Significance:</h3><p>Beyond its exquisite taste, Pho holds cultural significance in Vietnamese society. It is a dish that brings people together, whether in a bustling street-side eatery or a family dinner at home. The ritual of preparing, serving, and enjoying Pho is a reflection of Vietnamese hospitality and the importance of communal dining in the country\'s culture.</p><h3>Pho on the Global Stage:</h3><p>Pho\'s popularity has transcended borders, becoming a beloved dish worldwide. Vietnamese immigrants introduced Pho to various countries, where it has been embraced and adapted to local tastes. Today, Pho restaurants can be found in cosmopolitan cities, introducing the world to the artistry and soulful flavors of this Vietnamese culinary masterpiece.</p><p><b>Conclusion:</b></p><p>Pho, with its artful combination of fragrant broth, delicate noodles, and vibrant toppings, stands as a testament to the rich tapestry of Vietnamese cuisine. More than just a dish, Pho embodies the spirit of a nation, reflecting a culinary journey that has captivated the world. As we savor each spoonful, we not only experience the art of Pho but also celebrate the cultural heritage and traditions that make this noodle elixir a cherished and timeless culinary delight.</p>', '2024-01-29 10:45:59');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `FullName` varchar(30) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Cover` varchar(255) DEFAULT NULL,
  `Password` varchar(200) NOT NULL,
  `Status` enum('active','disabled','','') NOT NULL DEFAULT 'disabled',
  `RegDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `FullName`, `Email`, `Cover`, `Password`, `Status`, `RegDate`) VALUES
(1, 'Admin', 'admin@webmaster.com', 'uploads/img-QOQs2ZaMUoGBcRPQRAw7C.png', '$2y$10$dx65zkChkikFBV9LQcsaNe9JFfC1ghBiuZk/kpjR6SYI4JrdCaRbu', 'active', '2024-01-05 06:33:29');

-- --------------------------------------------------------

--
-- Table structure for table `views`
--

CREATE TABLE `views` (
  `ID` int(11) NOT NULL,
  `PostID` int(11) NOT NULL,
  `NumberOfViews` bigint(20) NOT NULL DEFAULT 0,
  `ViewTime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `views`
--

INSERT INTO `views` (`ID`, `PostID`, `NumberOfViews`, `ViewTime`) VALUES
(1, 42, 1, '2024-02-07 08:21:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `feature_post`
--
ALTER TABLE `feature_post`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `PostID` (`PostID`);

--
-- Indexes for table `login_devices`
--
ALTER TABLE `login_devices`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Token` (`Token`);

--
-- Indexes for table `medias`
--
ALTER TABLE `medias`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `newsletters`
--
ALTER TABLE `newsletters`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `URI` (`URI`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `URI` (`URI`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `views`
--
ALTER TABLE `views`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `PostID` (`PostID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `feature_post`
--
ALTER TABLE `feature_post`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `login_devices`
--
ALTER TABLE `login_devices`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `medias`
--
ALTER TABLE `medias`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `newsletters`
--
ALTER TABLE `newsletters`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `views`
--
ALTER TABLE `views`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `feature_post`
--
ALTER TABLE `feature_post`
  ADD CONSTRAINT `feature_post_ibfk_1` FOREIGN KEY (`PostID`) REFERENCES `posts` (`ID`);

--
-- Constraints for table `views`
--
ALTER TABLE `views`
  ADD CONSTRAINT `views_ibfk_1` FOREIGN KEY (`PostID`) REFERENCES `posts` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
