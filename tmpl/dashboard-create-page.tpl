<form class="left" style="width: 100%;overflow: hidden;" onsubmit="return false;">

    <h1 class="create-post-heading"> Create a custom page</h1>
    <br/>

    <div class="create-post-header">
        <div class="left">
            <input type="text" name="title" placeholder="Page title" id="create-page-title"/>
        </div>
        <div class="right">
            <button onclick="publishPage()" id="publish-page-button">Publish <i class="fa fa-send"></i> </button>
        </div>
    </div>

    <div class="create-post-featureImage-photo">
        <span class="input">
            <button class="button black" onclick="mediasForEditor();">Add media</button>
        </span>
        <span></span>
        <div class="label">
            <b>Add to menu: <input id="create-page-add-to-menu" type="checkbox" name="add-to-menu" value="menu" style="transform: scale(1.5);" checked/> </b>
        </div>
    </div>
    
    <p style="color: rgb(255, 196, 0);;">Highlight any text for formatting options.</p>
 
    <div id="show-text-editor" style="position: relative;"></div>
    <div class="editor">
        <div id="editable" onfocus="
        this.removeAttribute('onfocus');
        iniEditor();
    " contenteditable="true"></div>
    </div>
    <br/>
    <br/>

</form>
