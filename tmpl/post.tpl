<!--include[post_header]-->


<div class="main-section">

    <br/>
    <br/>
    <br/>
    <br/>
    <br/>

    <main class="main-content">

        <div class="left">
            
            <div class="popular-post-section">
                <span class="title underline">Article</span>
                <br/>
                <br/>
                
                <!--forEach[post]-->
                <article class="popular-post section readable">
                    <div class="content">
                        <h1 class="title" style="font-size:2em;"><!--{Title}--></h1>
                        <h2 class="date" style="font-size: 1.1em;"><time>Posted on <!--{PostTime}--></time></h2>
                        <hr/>
                        <p class="text"style="line-height:30px;"><!--{Content}--></p>
                        <br/>
                        <br/>
                        <ul class="keywords">
                            <!--{Labels}-->
                        </ul><br/><br/>
                        <a href="#" target="_blank" class="button bordered" title="Share to Facebook"><i class="fa fa-facebook"></i></a>
                        <a href="#" class="button bordered" title="Share to Pinterest"><i class="fa fa-pinterest"></i></a>
                        <a href="#" class="button bordered" title="Share to Instagram"><i class="fa fa-instagram"></i></a>
                        <a href="#" class="button bordered" title="Share to Reddit"><i class="fa fa-reddit"></i></a>
                        <a href="#" class="button bordered" title="Share to Quora"><i class="fa fa-quora"></i></a>
                        <button class="button" Share><i class="fa fa-share"></i></button>
                    </div>
                </article>
                <!--end[post]-->

            </div>

            <br/>
            <br/>


            
        </div>
        <div class="right">
            <!--include[side_content]-->

            <br/>
            <br/>

            <div class="section">
                <span class="title">Recent posts</span>
                <br/>
                <br/>
                <!--forEach[recent_posts]-->
                <a href="/read/<!--{URI}-->" class="side-recent-post">
                    <div class="left">
                        <span class="image"> <img src="<!--{FeatureImage}-->" alt="<!--{Title}-->" width="50"/> </span>
                    </div>
                    <div class="right">
                        <h5 class="title"><!--{Title}--></h5>
                        <time><!--{PostTime}--></time>
                    </div>
                </a>
                <!--end[recent_posts]-->
            </div>
            <br/>
            <br/>
        </div>

    </main>


    <div <!--[feature.post.status]-->>

        <h6 class="title underline">Feature posts</h6>
        <br/>
        <br/>
        <section class="section">
    
            <div class="featured-posts no-shift">
                <!--forEach[feature_post]-->
                <article class="container">
                    
                    <a href="/read/<!--{URI}-->" class="home-featured-post">
                        <img src="<!--{FeatureImage}-->" alt="<!--{Title}-->" width="100"/>
                        <span class="content">
                            <time><!--{PostTime}--></time>
                            <p><!--{Title}--></p>
                        </span>
                    </a>
                    
                </article>
                <!--end[feature_post]-->
            </div>
    
        </section>
    </div>


</div>


<!--include[footer]-->