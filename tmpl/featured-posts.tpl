<!--include[header]-->


<div class="main-section">

    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    

    <main class="main-content">

        <div class="left">
            
            <div class="popular-post-section">
                <span class="title underline">Featured posts</span>
                <br/>
                <br/>
                
                <!--forEach[trending_posts]-->
                <a href="/read/<!--{URI}-->" class="side-recent-post">
                   <div class="left">
                       <span class="image"> <img src="<!--{FeatureImage}-->" alt="<!--{Title}-->" width="50"/> </span>
                   </div>
                   <div class="right">
                       <h5 class="title"><!--{Title}--></h5>
                       <time><!--{PostTime}--></time>
                   </div>
               </a>
               <!--end[trending_posts]-->

            </div>

            <br/>
            <br/>


            
        </div>
        <div class="right">
            
            <br/>
            <br/>
            <!--include[search_form]-->

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


</div>


<!--include[footer]-->