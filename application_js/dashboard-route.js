let home = "";
let posts = "";
let createPost = "";
let pages = "";
let settings = "";
let featuredPosts = "";

const loadDocument = async (page) => {
    const response = await fetch(page);
    const resHTML = await response.text();
    return resHTML;
};

const loadAllDocuments = async () => {
    home = await loadDocument("/dashboard/t");
    posts = await loadDocument("/dashboard/t/posts");
    createPost = await loadDocument("/dashboard/t/create-post");
    createPage = await loadDocument("/dashboard/t/create-page");
    pages = await loadDocument("/dashboard/t/pages");
    settings = await loadDocument("/dashboard/t/settings");
    featuredPosts = await loadDocument("/dashboard/t/feature-posts");
};

const root = document.getElementById("root");

const main = async () => {
    await loadAllDocuments();
    root.innerHTML = home;
    routes = {
        '/dashboard' : home,
        '/dashboard/posts' : posts,
        '/dashboard/create-post' : createPost,
        '/dashboard/create-page' : createPage,
        '/dashboard/pages' : pages,
        '/dashboard/settings' : settings,
        '/dashboard/featured-posts' : featuredPosts,
    };
    try { 
        root.innerHTML = routes[window.location.pathname];
        if(!routes[window.location.pathname]) { root.innerHTML = home; } 
    } catch(e) {
        console.log("Use Home page");
    }
    initializeActiveNavLink();

    loadPostOldOffset = 30;
    loadPageOldOffset = 30;
    loadFeaturePostOldOffset = 30;
    loadPostsOnlyOnOldRequestIsFinish = true;
    loadPagesOnlyOnOldRequestIsFinish = true;
    loadFeaturePostsOnlyOnOldRequestIsFinish = true;
};

main();

const onNavClick = (pathname) => {
    window.history.pushState({}, pathname, window.location.origin + pathname);
    root.innerHTML = routes[pathname];
    initializeActiveNavLink();
};

window.onpopstate = () => {
    root.innerHTML = routes[window.location.pathname];
    initializeActiveNavLink();
};
