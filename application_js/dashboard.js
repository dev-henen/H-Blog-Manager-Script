

function Alert(message) {
    let alertButton = document.getElementById("main-alert");
    if(message == null) {
        alertButton.style.display = "none";
    } else {
        document.getElementById('main-alert-message').innerText = message;
        alertButton.style.display = "block";
    }
}

function Confirm(message = null, callback = ()=>{}) {
    let confirmButton = document.getElementById("main-confirm");
    if(message == null) {
        confirmButton.style.display = "none";
    } else {
        document.getElementById('main-confirm-message').innerText = message;
        confirmButton.style.display = "block";
        document.getElementById('main-confirm-ok-button').onclick = () => {
            callback();
            Confirm();
        };
    }
}

function loading(state = true) {
    let loader = document.getElementById('loading');
    if(state == true) {
        loader.style.display = 'block';
    } else {
        loader.style.display = 'none';
    }
}

// const postOptions = (postElement) => {
//     let x = postElement.parentElement.getElementsByClassName('options');
//     let options = postElement.querySelector('.options');
//     for(let i = 0; i < x.length; i++) x[i].style.display = 'none';
//     options.style.display = (options.style.display == 'inline-block')? 'none' : 'inline-block';
// }
// const pageOptions = (pageElement) => {
//     let x = pageElement.parentElement.getElementsByClassName('options');
//     let options = pageElement.querySelector('.options');
//     for(let i = 0; i < x.length; i++) x[i].style.display = 'none';
//     options.style.display = (options.style.display == 'inline-block')? 'none' : 'inline-block';
// }


function mediasForEditor() {
    const medias = document.getElementById('medias-for-editor');
    let callback;
    if(medias.style.display == 'block') {
        medias.style.display = 'none';
    } else {
        medias.style.display = 'block';
    }
    document.getElementById('editable').focus();
}

const initializeActiveNavLink = ()=> {

    let pathname = window.location.pathname;
    let currentRoute = pathname;
    let links = document.getElementById('dashboard-left-nav-links').getElementsByTagName('a');
    for(let i = 0; i < links.length; i++){
        links[i].classList.remove('active')
        if(links[i].getAttribute('route') == currentRoute){
            links[i].classList.add('active');
        }
    }
    

}


function showSettingWindow(element) {
    if(element.style.display == 'block') {
        element.style.display = 'none';
    } else {
        element.style.display = 'block';
    }
}



document.body.onscroll = function() {
    try {
        if(document.getElementById('dashboard-posts-root')) {
            loadMorePostsOnScroll();
        }
        if(document.getElementById('dashboard-pages-root')) {
            loadMorePagesOnScroll();
        }
        if(document.getElementById('dashboard-feature-posts-root')) {
            loadFeatureMorePostsOnScroll()
        }
    } catch(e) {
        console.log(e);
    }

}