function leftNavigation() {
    let nav = document.getElementById('left-navigation');
    if(nav.style.display == 'block') {
        nav.style.display = 'none';
        document.body.style.overflowY = 'auto';
    } else {
        nav.style.display = 'block';
        document.body.style.overflowY = 'hidden';
    }
}