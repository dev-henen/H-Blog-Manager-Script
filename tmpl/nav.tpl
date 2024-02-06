<nav class="top-navigation">

    <div class="content">
        <ul class="left">
            <li> <a href="#search"> <i class="fa fa-search"></i> </a> </li>
            <li> <a href="/view-more-posts"> Feed? </a> </li>
        </ul>
       
        <ul class="center">
            <li class="mobile"> <a href="/" title="Home"> <img src="/assets/images/logo.png" alt="Logo" width="40"/> </a> </li>
            <li> <a href="/" class="active"> HOME </a> </li>
            <li> <a href="/p/about"> ABOUT </a> </li>
            <li> <a href="/trends"> FEATURED </a> </li>
            <li> <a href="/p/contact"> CONTACT </a> </li>
            <li> <a href="/login"> <i class="fa fa-user"></i> LOGIN </a> </li>
            <li onclick="leftNavigation();"> <a href="javascript:void(0)" role="button" title="Menu"> <i class="fa fa-navicon"></i> </a> </li>
        </ul>

        <ul class="right">
            <!--forEach[header_social_links]-->
            <li> <a href="<!--{URL}-->" title="<!--{name}-->" target="_blank"> <i class="fa fa-<!--{name}-->"></i> </a> </li>
            <!--end[header_social_links]-->
        </ul>
    </div>

</nav>

<aside class="left-navigation" id="left-navigation">
    <ul>
        <li> <a href="/"> Home </a> </li>
        <li> <a href="/login"> <i class="fa fa-user"></i> Login </a> </li>
        <li> <a href="/trends"> Featured posts </a> </li>
        <!--forEach[list_pages]-->
        <li> <a href="/p/<!--{URI}-->"> <!--{Title}--> </a> </li>
        <!--end[list_pages]-->
    </ul>
</aside>