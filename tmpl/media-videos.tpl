<!--forEach[medias.editor.videos]-->
<div class="file">
    <video width="100%" onclick="addVideoMediaInEditor(this);" onmouseleave='stopVideoPreview(this)' onmouseenter='videoPreview(this)'>
        <source src="/uploads/<!--{URI}-->" id="videoSource"/>
        <strong>Unsupported browser</strong>
    </video>
    <span class="overlay"> <i class='fa fa-play-circle-o'></i> </span>
</div>
<!--end[medias.editor.videos]-->