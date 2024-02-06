var loadMediaImagesOnlyOnOldRequestIsFinish = true;
var loadMediaVideosOnlyOnOldRequestIsFinish = true;
var loadMediaImagesOldOffset = 50;
var loadMediaVideosOldOffset = 50;

function submitMediaFileForUpload() {
    let uploadMediasInput = document.getElementById('uploadMediasInput');
    loading(true);

    const formData = new FormData();
    formData.append("media", uploadMediasInput.files[0]);

    fetch("/dashboard/cgi/upload-media", {
        method: "POST",
        body: formData
    }).then((response) => response.text()).then((result) => {
        Alert(result);
        loading(false);
        loadMediaImages(0, true);
    }).catch((error) => {
        console.log(error);
        Alert(error);
        loading(false);
    });
    
    uploadMediasInput.outerHTML = "";
}

function uploadMedias() {
    let input = document.createElement('input');
    input.setAttribute('id', 'uploadMediasInput');
    input.setAttribute('type', 'file');
    input.setAttribute('style', 'display:none;');
    input.setAttribute('onchange', 'submitMediaFileForUpload();');
    document.body.appendChild(input);
    let uploadMediasInput = document.getElementById('uploadMediasInput');
    uploadMediasInput.click();
}


function loadMediaImages(offset, clearExistingFiles) {
    loading(true);
    document.getElementById('mediaImagesMainElement').style.display = 'block';
    document.getElementById('mediaVideosMainElement').style.display = 'none';
    loadMediaImagesOnlyOnOldRequestIsFinish = false;
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {

        if(this.status == 200) {
            let mediasRoot = document.getElementById('mediasRootElement');
            if(clearExistingFiles === true) {
                mediasRoot.innerHTML = this.responseText;
                loadMediaImagesOldOffset = 50;
            } else {
                mediasRoot.innerHTML += this.responseText;
                loadMediaImagesOldOffset += 50;
            }

            loadMediaImagesOnlyOnOldRequestIsFinish = true;

        }
        loading(false);

    }
    xmlHttpRequest.open('GET', '/dashboard/cgi/load-media-images?offset=' + offset);
    xmlHttpRequest.send();
}

function loadMoreMediaImagesOnScroll(element) {
    if(Math.ceil(element.scrollHeight - element.scrollTop) === element.clientHeight && loadMediaImagesOnlyOnOldRequestIsFinish === true) {
        loadMediaImages(loadMediaImagesOldOffset, false);
    }
}



function loadMediaVideos(offset, clearExistingFiles) {
    loading(true);
    document.getElementById('mediaVideosMainElement').style.display = 'block';
    document.getElementById('mediaImagesMainElement').style.display = 'none';
    loadMediaVideosOnlyOnOldRequestIsFinish = false;
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {

        if(this.status == 200) {
            let mediasRoot = document.getElementById('mediaVideosRootElement');
            if(clearExistingFiles === true) {
                mediasRoot.innerHTML = this.responseText;
                loadMediaVideosOldOffset = 50;
            } else {
                mediasRoot.innerHTML += this.responseText;
                loadMediaVideosOldOffset += 50;
            }

            loadMediaVideosOnlyOnOldRequestIsFinish = true;

        }
        loading(false);

    }
    xmlHttpRequest.open('GET', '/dashboard/cgi/load-media-videos?offset=' + offset);
    xmlHttpRequest.send();

}

function loadMoreMediaVideosOnScroll(element) {
    if(Math.ceil(element.scrollHeight - element.scrollTop) === element.clientHeight && loadMediaImagesOnlyOnOldRequestIsFinish === true) {
        loadMediaVideos(loadMediaImagesOldOffset, false);
    }
}