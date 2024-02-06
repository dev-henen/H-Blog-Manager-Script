var labels = [];
var loadPostOldOffset = 30;
var loadPostsOnlyOnOldRequestIsFinish = true;
var loadFeaturePostOldOffset = 30;
var loadFeaturePostsOnlyOnOldRequestIsFinish = true;

function createPostMain(status, postID = null) {

    const body = document.getElementById("editable");
    const title = document.getElementById("create-post-title");
    const getLabels = labels;
    const sendNewsLetters = document.getElementById('create-post-send-newsletter');

    const labelsPreview = document.getElementById("add-labels-preview");

    if(title.value.trim() == "") {
        Alert("You must provide a valid post title.");
        return;
    } else if(body.innerHTML.trim() == "") {
        Alert("What is your post talking about?");
        return;
    }

    
    loading(true);
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {

        if(this.status == 200) {

            let result = this.responseText;

            console.log(this.responseText);
            if(status == 'publish') {
                Alert(this.responseText);
                main();
                title.value = "";
                body.innerHTML = "";
                labels = [];
                labelsPreview.innerHTML = "";
            } else {
                Alert(this.responseText);
            }
            loading(false);
            
        } else {
            Alert(this.responseText);
            console.log(this.responseText);
            loading(false);
        }

    }
    xmlHttpRequest.open('POST', '/dashboard/cgi/post');
    xmlHttpRequest.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpRequest.send(
    "title=" + encodeURIComponent(title.value) +
    "&body=" + encodeURIComponent(body.innerHTML) +
    "&labels=" + encodeURIComponent(JSON.stringify(getLabels)) +
    "&status=" + encodeURIComponent(status) +
    ((postID != null)? "&postID=" + encodeURIComponent(postID) : "") +
    ("&sendNewsletters=" + ((sendNewsLetters.checked == true)? 'true' : 'false'))
    );

}

function publishPost() { createPostMain('publish'); }
function updatePost(postID) { createPostMain('update', postID); }

function createPostAddLabels() {

    let input = document.getElementById("add-labels-input");
    let preview = document.getElementById("add-labels-preview");

    if(input.value.trim() != "") {

        if(labels.indexOf(input.value.trim()) !== -1) {
            Alert('Label already exist');
            return;
        }

        if(/[^a-zA-Z0-9 ]/.test(input.value)) {
            Alert('Labels can only contain letters, numbers and spaces.');
        } else if(input.value.length > 30) {
            Alert("Labels should be less than 30 characters in length.");
        } else if(labels.length > 8) {
            Alert("You can not have more than 8 labels per post.");
        } else {
            labels.push(input.value.trim());
            preview.innerHTML = "";
            labels.map((value) => preview.innerHTML += `<span>${value}  <i onclick="createPostRemoveLabels('${value}');">&times;</i> </span>` );
            input.value = "";
        }
        
    }

}


function createPostRemoveLabels(element) {

    let preview = document.getElementById("add-labels-preview");
    
    if(labels.length > 0) {

        labels.splice(labels.indexOf(element), 1);
        preview.innerHTML = '';
        labels.map((value) => preview.innerHTML += `<span>${value}  <i onclick="createPostRemoveLabels('${value}');">&times;</i> </span>` );
        
    }

}


function editPost(postID) {

    loading(true);
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {

        if(this.status == 200) {

            try {

                let post = JSON.parse(this.responseText);
                onNavClick('/dashboard/create-post');

                const body = document.getElementById("editable");
                const title = document.getElementById("create-post-title");
                const getLabels = JSON.parse(post.Labels);
                const publishButton = document.getElementById("publish-post-button");
                labels = getLabels;
                document.getElementById('create-post-send-newsletter-element').style.display = 'none';

                let preview = document.getElementById("add-labels-preview");

                let tmpElement = document.createElement('span');
                tmpElement.innerHTML = post.Title;
                let getParseEntities = tmpElement.innerHTML;
                title.value = getParseEntities;
                body.innerHTML = post.Content;
                getLabels.map((value) => preview.innerHTML += `<span>${value}  <i onclick="createPostRemoveLabels('${value}');">&times;</i> </span>` );
                publishButton.innerHTML = "Update <i class='fa fa-send'></i>";
                publishButton.setAttribute('onclick', `
                Confirm('Are you sure you want to save changes?', ()=>{ updatePost(${post.ID}) });`);


            } catch(e) {
                Alert(e);
            }

        } else {
            Alert(this.responseText);
        }
        loading(false);

    }
    xmlHttpRequest.open('GET', '/dashboard/cgi/get-edit-post?postID=' + postID);
    xmlHttpRequest.send();

}



// const previewUploadImage = () => {
//     const img = document.getElementById("create-post-featureImage");
//     const imgTag = document.getElementById("preview-upload-image-tag");
//     const viewArea = document.getElementById("preview-image");

//     if(img.files[0]) {
//         let file = img.files[0];
//         let blobURL = URL.createObjectURL(file);
//         imgTag.src = blobURL;
//         viewArea.style.display = "initial";
//     } else {
//         let uploadedImageSrc = img.getAttribute('uploaded-image-src-url');
//         if(uploadedImageSrc) {
//             imgTag.src = '/uploads/' + uploadedImageSrc;
//             viewArea.style.display = "initial";
//         }
//     }

// };


function deletePost(postID) {

    loading(true);
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {
        main();
        Alert(this.responseText);
        loading(false);
    }
    xmlHttpRequest.open('POST', '/dashboard/cgi/delete-post');
    xmlHttpRequest.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpRequest.send('post_id=' + postID);

}


function addFeaturePostOrRemove(postID) {
    loading(true);
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {
        Alert(this.responseText);
        main();
        loading(false);
    }
    xmlHttpRequest.open('POST', '/dashboard/cgi/add-feature-post');
    xmlHttpRequest.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpRequest.send('postID=' + postID);
}






function loadMorePosts(offset, clearExistingPosts) {
    loading(true);
    loadPostsOnlyOnOldRequestIsFinish = false;
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {

        if(this.status == 200) {
            let postsRoot = document.getElementById('dashboard-posts-root');
            if(clearExistingPosts === true) {
                postsRoot.innerHTML = this.responseText;
                loadPostOldOffset = 30;
            } else {
                postsRoot.innerHTML += this.responseText;
                loadPostOldOffset += 30;
            }

            loadPostsOnlyOnOldRequestIsFinish = true;

        }
        loading(false);

    }
    xmlHttpRequest.open('GET', '/dashboard/cgi/load-more-posts?offset=' + offset);
    xmlHttpRequest.send();
}

function loadMorePostsOnScroll() {
    if(window.scrollY) {
        if((window.innerHeight + window.scrollY) >= document.body.scrollHeight && loadPostsOnlyOnOldRequestIsFinish === true) {
            loadMorePosts(loadPostOldOffset, false);
        }
    } else {
        if((window.innerHeight + Math.ceil(window.pageYOffset + 1)) >= document.body.offsetHeight && loadPostsOnlyOnOldRequestIsFinish === true) {
            loadMorePosts(loadPostOldOffset, false);
        }
    }
}




function loadMoreFeaturePosts(offset, clearExistingPosts) {
    loading(true);
    loadFeaturePostsOnlyOnOldRequestIsFinish = false;
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {

        if(this.status == 200) {
            let postsRoot = document.getElementById('dashboard-feature-posts-root');
            if(clearExistingPosts === true) {
                postsRoot.innerHTML = this.responseText;
                loadFeaturePostOldOffset = 30;
            } else {
                postsRoot.innerHTML += this.responseText;
                loadFeaturePostOldOffset += 30;
            }

            loadFeaturePostsOnlyOnOldRequestIsFinish = true;

        }
        loading(false);

    }
    xmlHttpRequest.open('GET', '/dashboard/cgi/load-more-feature-posts?offset=' + offset);
    xmlHttpRequest.send();
}

function loadFeatureMorePostsOnScroll() {
    if(window.scrollY) {
        if((window.innerHeight + window.scrollY) >= document.body.scrollHeight && loadFeaturePostsOnlyOnOldRequestIsFinish === true) {
            loadMoreFeaturePosts(loadFeaturePostOldOffset, false);
        }
    } else {
        if((window.innerHeight + Math.ceil(window.pageYOffset + 1)) >= document.body.offsetHeight && loadFeaturePostsOnlyOnOldRequestIsFinish === true) {
            loadMoreFeaturePosts(loadFeaturePostOldOffset, false);
        }
    }
}

