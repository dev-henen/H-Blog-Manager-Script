var iniEditor = () => {

    var editor = new MediumEditor('#editable', {
      buttonLabels: 'fontawesome',
      extensions: {
        table: new MediumEditorTable()
      },
      toolbar: {
        buttons: [
          'h1', 'h2', 'h3', 'h4',
          'bold', 'italic', 'underline', 'strikethrough',
          'quote', 'anchor',
          'justifyLeft', 'justifyCenter', 'justifyRight', 'justifyFull', 'superscript', 'subscript',
          'unorderedlist', 'orderedlist', 'table',
          'pre', 'removeFormat', 'outdent', 'indent'
        ],
        relativeContainer: document.getElementById('show-text-editor'),
        align: 'center',
        static: true,
        sticky: true,
        updateOnEmptySelection: true
      }
    });

    
};







function pasteHtmlAtCaret(html) {
    var sel, range;
    if (window.getSelection) {
        // IE9 and non-IE
        sel = window.getSelection();
        if (sel.getRangeAt && sel.rangeCount) {
            range = sel.getRangeAt(0);
            range.deleteContents();

            // Range.createContextualFragment() would be useful here but is
            // only relatively recently standardized and is not supported in
            // some browsers (IE9, for one)
            var el = document.createElement("div");
            el.innerHTML = html;
            var frag = document.createDocumentFragment(), node, lastNode;
            while ( (node = el.firstChild) ) {
                lastNode = frag.appendChild(node);
            }
            range.insertNode(frag);

            // Preserve the selection
            if (lastNode) {
                range = range.cloneRange();
                range.setStartAfter(lastNode);
                range.collapse(true);
                sel.removeAllRanges();
                sel.addRange(range);
            }
        }
    } else if (document.selection && document.selection.type != "Control") {
        // IE < 9
        document.selection.createRange().pasteHTML(html);
    }
}





function addImageMediaInEditor(media) {

    let uri = media.getAttribute('src');
    let editor = document.getElementById('editable');
    let img = `<span class="dynamic-image" style="display: inline-block; overflow: hidden; width: 200px; min-width: 50px; max-width: 100%;" contenteditable="false" draggable="false"><img src="${uri}" alt="image" width="100%" draggable="false"/></span>`;
    pasteHtmlAtCaret(img);
    mediasForEditor();

}

function addVideoMediaInEditor(media) {

    let uri = media.querySelector('source').getAttribute('src');
    let editor = document.getElementById('editable');
    let video = `
    <div class="video" id="videoContainer" contenteditable="false" draggable="false" style="user-select:none;">
    <div class="screen"  contenteditable="false" draggable="false">
        <video width="100%" id="video">
            <source src="${uri}" id="videoSource"/>
            <strong>Sorry your browser can't play this video</strong>
        </video>
        <div class="play-overlay">
            <div class="inner">
                <button onclick="play();" id="playerCircle"><i class="fa fa-play-circle-o"></i></button>
            </div>
        </div>
        <div class="error-overlay" id="videoPlayError" style="display:none;">
            <div class="inner">
                <div><i class="fa fa-exclamation-circle"></i></div>
            </div>
        </div>
        <div class="progress-area">
            <div class="loader">
                <div class="track" id="track"></div>
                <input type="range" width="100%" min="0" max="60" value="0" id="range"/>
            </div>
        </div>
        <div id="playingDuration">00:00:00</div>
        <div id="showDuration">00:00:00</div>
        <div class="spin" id="spin"><div><div></div></div></div>
    </div>
    <div class="controls">
        <div>
            <div>
                <input type="range" width="100%" min="0" max="100" value="100" class="volumn" id="volume" title="Volumn"/>
                <span id="volumePercent">100%</span>
            </div>
        </div>
        <div>
            <button class="previous" onclick="previous();" title="Previous"><i class="fa fa-fast-backward"></i></button>
            <button id="playerInControls" class="playerInControls" onclick="play();" title="Play/Pause"><i class="fa fa-play"></i></button>
            <button class="next" onclick="next();" title="next"><i class="fa fa-fast-forward"></i></button>
        </div>
        <div>
            <button class="mute" onclick="muteVolume();" title="Mute" id="mute"><i class="fa fa-volume-up"></i></button>
            <button class="fullscreen" onclick="fullscreen();" title="Fullscreen"><i class="fa fa-arrows-alt"></i></button>
        </div>
    </div>
    </div>`;
    pasteHtmlAtCaret(video);
    mediasForEditor();

}