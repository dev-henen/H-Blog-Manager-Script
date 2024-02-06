<!--include[header]-->


<div class="main-section">

    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>

    <main class="main-content">

        <div class="left">
            
            <div>
                <h1 class="title"><b class="title underline">Search result for:</b> <!--[search.query.string]--></h1>
                <br/>
                <br/>
                <div class="section">
                    <div<!--[empty.search.result]-->>
                        <span style="font-size: 1.2em;"><!--[empty.search.result.message]--></span>
                    </div>
                    <!--forEach[search_result]-->
                    <a href="/read/<!--{URI}-->" class="side-recent-post">
                        <div class="left">
                            <span class="image"> <img src="<!--{FeatureImage}-->" alt="<!--{Title}-->" width="50"/> </span>
                        </div>
                        <div class="right">
                            <h5 class="title"><!--{Title}--></h5>
                        </div>
                    </a>
                    <!--end[search_result]-->

                </div>
                

            </div>

            <br/>
            <br/>


            
        </div>
        <div class="right">
            <!--include[side_content]-->

            <br/>
            <br/>

   
        </div>

    </main>


</div>


<!--include[footer]-->