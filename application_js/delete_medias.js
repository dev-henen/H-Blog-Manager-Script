let loadDeleteMediaImagesOnlyOnOldRequestIsFinish = true;
let loadDeleteMediaVideosOnlyOnOldRequestIsFinish = true;
var loadDeleteMediaImagesOldOffset = 50;
var loadDeleteMediaVideosOldOffset = 50;

function loadDeleteMediaImages(offset, clearExistingFiles) {
    loading(true);
    document.getElementById('deleteMediaImagesMainElement').style.display = 'block';
    document.getElementById('deleteMediaVideosMainElement').style.display = 'none';
    loadDeleteMediaImagesOnlyOnOldRequestIsFinish = false;
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {

        if(this.status == 200) {
            let mediasRoot = document.getElementById('deleteMediasRootElement');
            if(clearExistingFiles === true) {
                mediasRoot.innerHTML = this.responseText;
                loadDeleteMediaImagesOldOffset = 50;
            } else {
                mediasRoot.innerHTML += this.responseText;
                loadDeleteMediaImagesOldOffset += 50;
            }

            loadDeleteMediaImagesOnlyOnOldRequestIsFinish = true;

        }
        loading(false);

    }
    xmlHttpRequest.open('GET', '/dashboard/cgi/load-delete-media-images?offset=' + offset);
    xmlHttpRequest.send();
}

function loadMoreDeleteMediaImagesOnScroll(element) {
    if(Math.ceil(element.scrollHeight - element.scrollTop) === element.clientHeight && loadDeleteMediaImagesOnlyOnOldRequestIsFinish === true) {
        loadDeleteMediaImages(loadDeleteMediaImagesOldOffset, false);
    }
}



function loadDeleteMediaVideos(offset, clearExistingFiles) {
    loading(true);
    document.getElementById('deleteMediaVideosMainElement').style.display = 'block';
    document.getElementById('deleteMediaImagesMainElement').style.display = 'none';
    loadDeleteMediaVideosOnlyOnOldRequestIsFinish = false;
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {

        if(this.status == 200) {
            let mediasRoot = document.getElementById('deleteMediaVideosRootElement');
            if(clearExistingFiles === true) {
                mediasRoot.innerHTML = this.responseText;
                loadDeleteMediaVideosOldOffset = 50;
            } else {
                mediasRoot.innerHTML += this.responseText;
                loadDeleteMediaVideosOldOffset += 50;
            }

            loadDeleteMediaVideosOnlyOnOldRequestIsFinish = true;

        }
        loading(false);

    }
    xmlHttpRequest.open('GET', '/dashboard/cgi/load-delete-media-videos?offset=' + offset);
    xmlHttpRequest.send();

}

function loadMoreDeleteMediaVideosOnScroll(element) {
    if(Math.ceil(element.scrollHeight - element.scrollTop) === element.clientHeight && loadDeleteMediaImagesOnlyOnOldRequestIsFinish === true) {
        loadDeleteMediaVideos(loadDeleteMediaImagesOldOffset, false);
    }
}

function openDeleteMediaDialog() {
    const dialog = document.getElementById('delete-medias-dialog');
    if(dialog.style.display == 'block') {
        dialog.style.display = 'none';
    } else {
        dialog.style.display = 'block';
    }
}
function deleteMedia(mediaID, mediaType) {
    loading(true);
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {
        if(mediaType == 'image') {
            loadDeleteMediaImages(0, true);
        } else if(mediaType == 'video') {
            loadDeleteMediaVideos(0, true);
        }
        if(this.status != 200) {
            Alert(this.responseText);
        }
        loading(false);
    }
    xmlHttpRequest.open('POST', '/dashboard/cgi/delete-a-media');
    xmlHttpRequest.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpRequest.send('mediaID=' + mediaID);
}