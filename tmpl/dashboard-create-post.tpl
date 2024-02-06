<form class="left" style="width: 100%;overflow: hidden;" onsubmit="return false;">

    <h1 class="create-post-heading"> Create post</h1>
    <br/>

    <div class="create-post-header">
        <div class="left">
            <input type="text" name="title" placeholder="Post title" id="create-post-title"/>
        </div>
        <div class="right">
            <button onclick="publishPost()" id="publish-post-button">Publish <i class="fa fa-send"></i> </button>
        </div>
    </div>

    <div class="labels-list">
        <b><small style="padding-right: 20px;">Labels:</small></b>
        <div id="add-labels-preview"></div>
    </div>

    <div class="create-post-featureImage-photo">
        <span class="input">
            <button class="button black" onclick="mediasForEditor();">Add media</button>
        </span>
        <span>
            <b id="create-post-send-newsletter-element">Send newsletters: <input id="create-post-send-newsletter" type="checkbox" name="send-newsletter" value="newsletter" style="transform: scale(2);"/> </b>
        </span>
        <div class="label">
            <input type="text" name="label" placeholder="Add Label" id="add-labels-input" autocomplete="off"/>
            <button onclick="createPostAddLabels()">Add</button>
        </div>
    </div>

    <p style="color: rgb(255, 196, 0);">Highlight any text for formatting options.</p>
    
    <div id="show-text-editor" style="position: relative;"></div>
    <div class="editor">
        <div id="editable" onfocus="
        this.removeAttribute('onclick');
        iniEditor();
    " contenteditable="true"></div>
    </div>
    <br/>
    <br/>

</form>

<div id="preview-image"> 
    <button class="button" onclick="this.parentElement.style.display = 'none';"> &times; Close </button>
    <img alt="" id="preview-upload-image-tag"/> 
</div>