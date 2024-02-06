var loadPageOldOffset = 30;
var loadPagesOnlyOnOldRequestIsFinish = true;


function createPageMain(status, pageID = null) {
    const body = document.getElementById("editable");
    const title = document.getElementById("create-page-title");
    const addToMenu = document.getElementById("create-page-add-to-menu");

    if(title.value.trim() == "") {
        Alert("You must provide a valid page title.");
        return;
    } else if(body.innerHTML.trim() == "") {
        Alert("Provide the page body");
        return;
    }

    loading(true);
    const formData = new FormData();

    formData.append("title", title.value);
    formData.append("body", body.innerHTML);
    formData.append("status", status);
    formData.append("addToMenu", ((addToMenu.checked == true)? true : false));
    if(pageID != null) formData.append("pageID", pageID);

    fetch("/dashboard/cgi/page", {
        method: "POST",
        body: formData
    }).then((response) => response.text()).then((result) => {
        if(status == 'publish' && result.trim() == '') {
            Alert('Your page was published successfully');
            main();
            title.value = "";
            body.innerHTML = "";
            loading(false);
            return;
        }
        Alert(result);
        loading(false);
    }).catch((error) => {
        console.log(error);
        Alert(error);
        loading(false);
    });

}

function publishPage() { createPageMain('publish'); }
function updatePage(pageID) { createPageMain('update', pageID); }


function editPage(pageURI) {

    loading(true);
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {
        if(this.status == 200) {

            try {

                let page = JSON.parse(this.responseText);
                onNavClick('/dashboard/create-page');
                const title = document.getElementById("create-page-title");
                const body = document.getElementById("editable");
                const publishButton = document.getElementById("publish-page-button");
                const addToMenu = document.getElementById("create-page-add-to-menu");
                publishButton.innerHTML = "Update <i class='fa fa-send'></i>";
                publishButton.setAttribute('onclick', `
                Confirm('Are you sure you want to save changes?', ()=>{ updatePage(${page.ID}) });`);

                let tmpElement = document.createElement('span');
                tmpElement.innerHTML = page.Title;
                let getParseEntities = tmpElement.innerHTML;
                title.value = getParseEntities;
                body.innerHTML = page.Content;
                if(page.ShowInMenu == true || page.ShowInMenu == 'true') {
                    addToMenu.checked = true;
                } else {
                    addToMenu.checked = false;
                }

            } catch(e) {
                Alert(e);
            }

        } else {
            Alert(this.responseText);
        }
        loading(false);
    }
    xmlHttpRequest.open('GET', '/dashboard/cgi/get-edit-page?pageURI=' + encodeURIComponent(pageURI));
    xmlHttpRequest.send();

}

function deletePage(pageID) {

    loading(true);
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {
        main();
        Alert(this.responseText);
        loading(false);
    }
    xmlHttpRequest.open('POST', '/dashboard/cgi/delete-page');
    xmlHttpRequest.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpRequest.send('page_id=' + pageID);

}




function loadMorePages(offset, clearExistingPages) {
    loading(true);
    loadPagesOnlyOnOldRequestIsFinish = false;
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {

        if(this.status == 200) {
            let pagesRoot = document.getElementById('dashboard-pages-root');
            if(clearExistingPages === true) {
                pagesRoot.innerHTML = this.responseText;
                loadPageOldOffset = 30;
            } else {
                pagesRoot.innerHTML += this.responseText;
                loadPageOldOffset += 30;
            }

            loadPagesOnlyOnOldRequestIsFinish = true;

        }
        loading(false);

    }
    xmlHttpRequest.open('GET', '/dashboard/cgi/load-more-pages?offset=' + offset);
    xmlHttpRequest.send();
}

function loadMorePagesOnScroll() {
    if(window.scrollY) {
        if((window.innerHeight + window.scrollY) >= document.body.scrollHeight && loadPagesOnlyOnOldRequestIsFinish === true) {
            loadMorePages(loadPageOldOffset, false);
        }
    } else {
        if((window.innerHeight + Math.ceil(window.pageYOffset + 1)) >= document.body.offsetHeight && loadPagesOnlyOnOldRequestIsFinish === true) {
            loadMorePages(loadPageOldOffset, false);
        }
    }
}
