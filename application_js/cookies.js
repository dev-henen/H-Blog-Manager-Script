window.onload = cookiesNotification();
function cookiesNotification(set = false) {
    if(set === true) {
        localStorage.setItem('cookies-set', 1);
        document.getElementById('cookies').style.display = 'none';
    }
    if(!localStorage.getItem('cookies-set')) {
        document.getElementById('cookies').style.display = 'block';
    }
}