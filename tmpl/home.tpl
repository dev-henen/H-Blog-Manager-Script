<!--include[header]-->


<header>
    
    <div class="hero-section">
        <br/>
        <br/>
        <br/>

        <div class="content">
            <h1><!--[application.name]--></h1>
            <p id="hero-description"><!--[application.description]--></p>
        </div>

    </div>

</header>

<div class="main-section">

    <div class="featured-posts"<!--[feature.post.status]-->>
        <!--forEach[feature_post]-->
        <div class="container">
            
            <a href="read/<!--{URI}-->" class="home-featured-post">
                <img src="<!--{FeatureImage}-->" alt="<!--{Title}-->" width="100"/>
                <span class="content">
                    <time><!--{PostTime}--></time>
                    <p><!--{Title}--></p>
                </span>
            </a>
            
        </div>
        <!--end[feature_post]-->
    </div>

    <br/>
    <br/>

    <main class="main-content">

        <div class="left">
            
            <div class="popular-post-section"<!--[popular.post.status]-->>
                <h2 class="title underline">Popular post</h2>
                <br/>
                <br/>
                
                <!--forEach[popular_post]-->
                <article class="popular-post">
                    <div class="image">
                        <img src="<!--{FeatureImage}-->" alt="<!--{Title}-->" width="200"/> 
                    </div>
                    <div class="content">
                        <h3 class="title"><!--{Title}--></h3>
                        <ul class="keywords">
                            <!--{Labels}-->
                        </ul>
                        <time class="date"><!--{PostTime}--></time>
                        <p class="text"><!--{Content}--></p>
                        <a href="read/<!--{URI}-->" class="button">Read this</a> 
                    </div>
                </article>
                <!--end[popular_post]-->

            </div>

            <br/>
            <br/>

            <h3 class="title underline">Recent posts</h3><br/><br/>
            <div class="newest-posts">

                <!--include[home-recent-posts-container]-->

            </div>

            <div class="load-more-section">
                <a href="/view-more-posts" class="button"> Load more <i class="fa fa-search"></i> </a>
            </div>


            
        </div>
        <div class="right">
           <!--include[side_content]-->
        </div>

    </main>


</div>

<!--include[footer]-->