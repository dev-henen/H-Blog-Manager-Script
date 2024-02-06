<!--forEach[pages]-->
<li>
    <div style="width: 100%;">
        <h3><i class="fa fa-internet-explorer"></i> <!--{Title}--></h3>
        <span class="views"> 
            <i class="fa fa-edit"></i>
        </span>
        <div class="options">
            <button onclick="editPage('<!--{URI}-->')">Edit page</button>
            <button onclick="window.open('/p/<!--{URI}-->', '_blank');">View page</button>
            <button onclick="Confirm('Are you sure you want to delete this page?', ()=>{ deletePage('<!--{ID}-->') });">Delete page</button>
        </div>
    </div>
</li>
<!--end[pages]-->
