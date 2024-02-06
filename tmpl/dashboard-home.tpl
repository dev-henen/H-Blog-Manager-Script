<div class="left">


    <div class="write-article">
        <div>
            <h1>Hey,</h1>
            <p>What do you want to write today? Are you gonna get people inspired?</p>
            <a href="javascript:void(0)" class="button black" onclick="onNavClick('/dashboard/create-post');">Write new post</a>
            <br/>
            <br/>
        </div>
        <div>
            <img src="/assets/images/write-post.png" alt="image" width="150"/>
        </div>
    </div>
    
    <br/>
    <br/>
    
    <div class="recent-articles">
        <h2>Recent posts</h2>
        <br/>
        <ul>
            <!--forEach[posts]-->
            <li class="no-hover">
                <div>
                    <div class="image"> <img src="<!--{FeatureImage}-->" alt="image" width="50"/> </div>
                </div>
                <div>
                    <h3><!--{Title}--></h3>
                    <time><!--{PostTime}--></time>
                    <span class="views"> <!--{Views}--> <i class="fa fa-eye"></i> </span>
                </div>
            </li>
            <!--end[posts]-->
        </ul>
    </div>

</div>
<div class="right">

    <div class="storage-info">
        <b>Storage details:</b><br/><br/>
        <small><b>Total Space:</b> <!--[space.total]--></small><br/>
        <small><b>Free Space:</b> <!--[space.free]--></small><br/>
        <small><b>Used Space:</b> <!--[space.used]--></small><br/>

        <div class="storage-chart"><span <!--[space.used.set]-->></span><small><!--[space.used]--></small></div>

    </div>

    <br/>
    <br/>
   
    <div class="publication-info">
        <b>Publication details:</b><br/><br/>
        <small><b>Total posts:</b> <!--[website.posts.total]--></small><br/>
        <small><b>Total pages:</b> <!--[website.pages.total]--></small><br/>
        <small><b>Total post views:</b> <!--[website.posts.views]--></small><br/>

    </div>


</div>
