<!--forEach[medias.delete.images]-->
<div class="file"> 
    <img src="/uploads/<!--{URI}-->" alt="image" width="50" onclick="Confirm('Confirm deletion?', ()=>{ deleteMedia('<!--{ID}-->', 'image')})"> 
    <span class="overlay">
        <i>Delete</i>
    </span>
</div>
<!--end[medias.delete.images]-->