<!--forEach[medias.delete.videos]-->
<div class="file">
    <video width="100%" onclick="Confirm('Confirm deletion?', ()=>{ deleteMedia('<!--{ID}-->', 'video')})" onmouseleave='stopVideoPreview(this)' onmouseenter='videoPreview(this)'>
        <source src="/uploads/<!--{URI}-->" id="videoSource"/>
        <strong>Unsupported browser</strong>
    </video>
    <span class="overlay"> <i>Delete Video</i> </span>
</div>
<!--end[medias.delete.videos]-->