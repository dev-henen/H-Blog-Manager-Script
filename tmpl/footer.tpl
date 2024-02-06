<br/>
<br/>
<br/>

<div class="cookies" id="cookies">
    <h6>Cookies</h6>
    <button class="cancel" onclick="cookiesNotification(true)">&times;</button>
    <p>
        We use cookies and similar technologies to help personalize
        content, tailor and measure ads, and provide a better experience.
        While using this site, you agree to this, as outlined in our
        <a href="/p/privacy-policy">Cookie Policy</a>.
    </p>
</div>

<footer>
    <div class="logo">
        <img src="/assets/images/logo.png" alt="Logo" width="50"/>
    </div>
    <nav>
        <ul>
            <li> <a href="/p/about">About</a> </li>
            <li> <a href="/p/privacy-policy">Privacy/Policy</a> </li>
            <li> <a href="/p/contact">Contact</a> </li>
        </ul>
    </nav>
    <div class="newsletters">
        <div>
            <strong>
                <small>Subscribe to our newsletters</small>
            </strong>
        </div><br/>
        <form method="post" action="/subscribe">
            <input type="email" name="email" placeholder="Email address" autocomplete="off"/>
            <input type="submit" name="submit" value="Subscribe"/>
        </form>
    </div>
    <div class="rest">
        <div class="left">
            <a href="/rss.xml" class="language" title="Feed" target="_blank"> <img src="/assets/images/rss.png" width="30" alt="RSS"> </a>
        </div>
        <div class="center">
            <ul class="social-links">
                <!--forEach[footer_social_links]-->
                <li> <a href="<!--{URL}-->" title="<!--{name}-->" target="_blank"> <i class="fa fa-<!--{name}-->"></i> </a> </li>
                <!--end[footer_social_links]-->
            </ul>
        </div>
        <div class="right">
            <div class="copyright">&copy; <!--[application.copyright]--> <!--[application.name]--></div>
        </div>
    </div>
</footer>
    
<script type="text/javascript" src="/assets/js/main.js"></script>
<script type="text/javascript" src="/application_js/player.js"></script>
<script type="text/javascript" src="/application_js/cookies.js"></script>
</body>
</html>