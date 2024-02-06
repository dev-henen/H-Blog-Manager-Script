<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="/lib/font-awesome-4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" type="text/css" href="/assets/css/player.layout.css"/>
    <link rel="stylesheet" type="text/css" href="/assets/css/dashboard.css"/>
    <script> var called = false; </script>

    <link rel="stylesheet" href="/lib/medium-editor/dist/css/medium-editor.css">
    <link rel="stylesheet" href="/lib/medium-editor/dist/css/themes/mani.min.css">
    <link rel="stylesheet" href="/lib/medium-editor-tables-master/dist/css/medium-editor-tables.css">
    <link rel="icon" type="image/ico" href="/favicon.ico"/>

    <script src="/lib/medium-editor/dist/js/medium-editor.js"></script>
    <script src="/lib/medium-editor-tables-master/dist/js/medium-editor-tables.js"></script>

</head>
<body>

    <nav class="top-navigation">
        <div class="content">

            <form class="search" method="get" action="/search">
                <i class="fa fa-search"></i>
                <input type="search" name="q" placeholder="Search" autocomplete="off"/>
            </form>

        </div>
        <div class="content">

            <span class="space"></span>


            <div class="profile">
                <span class="user-name"><!--[user.profile.name]--> <i class="fa fa-chevron-down"></i> </span>
            </div>

        </div>
    </nav>

    
    <aside class="left-navigation">
        
        <div class="logo">
            <a href="/">
                <img src="/assets/images/logo.png" width="50" alt="LOGO"/>
            </a>
        </div>
        
        <br/>
        <br/>
        <br/>
        
        <ul id="dashboard-left-nav-links">
            <li> <a href="javascript:void(0)" onclick="onNavClick('/dashboard');" route="/dashboard"> <i class="fa fa-th-large"></i> Dashboard </a> </li>
            <li> <a href="javascript:void(0)" onclick="onNavClick('/dashboard/posts');" route="/dashboard/posts"> <i class="fa fa-book"></i> My posts </a> </li>
            <li> <a href="javascript:void(0)" onclick="onNavClick('/dashboard/featured-posts');" route="/dashboard/featured-posts"> <i class="fa fa-clone"></i> Featured posts </a> </li>
            <li> <a href="javascript:void(0)" onclick="onNavClick('/dashboard/pages');" route="/dashboard/pages"> <i class="fa fa-internet-explorer"></i> My pages </a> </li>
            <li> <a href="javascript:void(0)" onclick="onNavClick('/dashboard/create-post');" route="/dashboard/create-post"> <i class="fa fa-edit"></i> Create post </a> </li>
            <li> <a href="javascript:void(0)" onclick="onNavClick('/dashboard/create-page');" route="/dashboard/create-page"> <i class="fa fa-edit"></i> Create page </a> </li>
            <li> <a href="javascript:void(0)" onclick="onNavClick('/dashboard/settings');" route="/dashboard/settings"> <i class="fa fa-gear"></i> Settings </a> </li>
        </ul>

    </aside>
    

    <main class="main-section">
        
        <div class="content"  id="root"></div>

    </main>

    <div class="main-alert" id="main-alert">
        <div class="content">
            <p id="main-alert-message"></p>
            <button onclick="Alert()">OK</button>
        </div>
    </div>
    
    <div class="main-alert confirm" id="main-confirm">
        <div class="content">
            <p id="main-confirm-message"></p>
            <button id="main-confirm-ok-button" class="ok-button">OK</button>
            <button onclick="Confirm()">Cancel</button>
        </div>
    </div>

    <div id="loading"><div></div></div>


    <div class="medias" id="medias-for-editor">
        <div class="content">
            <div class="header">
                <div class="left">
                    <h4 style="padding-right: 10px;">Medias</h4>
                    <button class="button" onclick="loadMediaImages(0, true);">Images</button>
                    <button class="button" onclick="loadMediaVideos(0, true);">Videos</button>
                </div>
                <div class="right">
                    <button onclick="uploadMedias();">Upload media</button>
                    <button onclick="openDeleteMediaDialog();" class="danger">Delete medias</button>
                    <button onclick="mediasForEditor()">&times; Cancel</button>
                </div>
            </div>
            <div class="main" id="mediaImagesMainElement" onscroll="loadMoreMediaImagesOnScroll(this);">
                <div class="images" id="mediasRootElement">
                    <!--include[media-images]-->
                </div>
            </div>
            <div class="main" id="mediaVideosMainElement" onscroll="loadMoreMediaVideosOnScroll(this);" style="display: none;">
                <div class="videos" id="mediaVideosRootElement"></div>
            </div>
        </div>
    </div>

    <div class="medias" id="delete-medias-dialog">
        <div class="content">
            <div class="header">
                <div class="left">
                    <h4 style="padding-right: 10px;">Medias</h4>
                    <button class="button" onclick="loadDeleteMediaImages(0, true);">Images</button>
                    <button class="button" onclick="loadDeleteMediaVideos(0, true);">Videos</button>
                </div>
                <div class="right">
                    <button onclick="openDeleteMediaDialog()">&times; Cancel</button>
                </div>
            </div>
            <div class="main" id="deleteMediaImagesMainElement" onscroll="loadMoreDeleteMediaImagesOnScroll(this);">
                <div class="images" id="deleteMediasRootElement">
                    <!--include[media-images-for-delete]-->
                </div>
            </div>
            <div class="main" id="deleteMediaVideosMainElement" onscroll="loadMoreDeleteMediaVideosOnScroll(this);" style="display: none;">
                <div class="videos" id="deleteMediaVideosRootElement"></div>
            </div>
        </div>
    </div>



    <script type="text/javascript" src="/application_js/dashboard-route.js"></script>
    <script type="text/javascript" src="/application_js/post.js"></script>
    <script type="text/javascript" src="/application_js/page.js"></script>
    <script type="text/javascript" src="/application_js/dashboard.js"></script>
    <script type="text/javascript" src="/application_js/dashboard-editor.js" charset="utf-8" ></script>
    <script type="text/javascript" src="/application_js/upload-media.js"></script>
    <script type="text/javascript" src="/application_js/delete_medias.js"></script>
    <script type="text/javascript" src="/application_js/player.js"></script>
    <script type="text/javascript" src="/application_js/settings.js"></script>
        
</body>
</html>