 <!--forEach[posts]-->
 <li>
    <div>
        <div class="image"> <img src="<!--{FeatureImage}-->" alt="image" width="50"/> </div>
    </div>
    <div>
        <h3><!--{Title}--></h3>
        <time><!--{PostTime}--></time>
        <span class="views"> 
            <!--{Views}--> <i class="fa fa-eye"></i> 
            <i class="fa fa-edit"></i>
        </span>
        <div class="options">
            <button onclick="editPost('<!--{ID}-->')">Edit post</button>
            <button onclick="window.open('/read/<!--{URI}-->', '_blank');">View post</button>
            <button onclick="Confirm('Are you sure you want to add/remove this post from featured?', ()=>{ addFeaturePostOrRemove('<!--{ID}-->'); });"><!--{FeaturedPostAddableMessage}--></button>
            <button onclick="Confirm('Are you sure you want to delete this post?', ()=>{ deletePost('<!--{ID}-->') });">Delete post</button>
        </div>
    </div>
</li>
<!--end[posts]-->