var loadPostOldOffset = 30;
var loadPostsOnlyOnOldRequestIsFinish = true;

function loadMorePosts(offset, clearExistingPosts) {
    
    document.getElementById('is-loading-more-posts').style.display = 'block';
    loadPostsOnlyOnOldRequestIsFinish = false;
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {
        
        if(this.status == 200) {
            let postsRoot = document.getElementById('view-more-posts-root');
            if(clearExistingPosts === true) {
                postsRoot.innerHTML = this.responseText;
                loadPostOldOffset = 30;
            } else {
                postsRoot.innerHTML += this.responseText;
                loadPostOldOffset += 30;
            }
            
            loadPostsOnlyOnOldRequestIsFinish = true;
            
        }
        document.getElementById('is-loading-more-posts').style.display = 'none';
        
    }
    xmlHttpRequest.open('GET', '/view-more-posts?offset=' + offset);
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


document.body.onscroll = function() {
    try {
        if(document.getElementById('view-more-posts-root')) {
            loadMorePostsOnScroll();
        }
    } catch(e) {
        console.log(e);
    }

}