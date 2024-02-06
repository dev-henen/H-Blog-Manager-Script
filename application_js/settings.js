
function settingsChangeEmail() {
    let email = document.getElementById('settings-change-email-address-input');
    let password = document.getElementById('settings-change-email-password-input');
    let otp = document.getElementById('settings-change-email-otp-input');
    let otpField = document.getElementById('settings-change-email-otp-field');
    if(email.value.trim() == '') {
        Alert('You must provide a valid new email address');
        return;
    }
    if(password.value == '') {
        Alert('Confirm your password');
        return;
    }

    loading(true);
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {
        try {
            otp.value = '';
        } catch(e){ console.log(e); }
        if(this.status == 200) {
            Alert(this.responseText);
            otpField.style.display = 'none';
            password.value = '';
            email.value = '';

        } else if(this.status == 201) {

            otpField.style.display = 'initial';

        } else {
            otpField.style.display = 'none';
            Alert(this.responseText);
            password.value = '';
        }
        loading(false);
    }
    xmlHttpRequest.open('POST', '/dashboard/cgi/change-email');
    xmlHttpRequest.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpRequest.send('email=' + encodeURIComponent(email.value) + '&password=' + encodeURIComponent(password.value)  + '&otp=' + encodeURIComponent(otp.value));
}




function settingsChangePassword() {
    let oldPassword = document.getElementById('settings-change-old-password-input');
    let newPassword = document.getElementById('settings-change-new-password-input');
    if(oldPassword.value.trim() == '') {
        Alert('Please confirm your old password');
        return;
    }
    if(newPassword.value == '') {
        Alert('Enter your new password');
        return;
    }

    loading(true);
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {
        if(this.status == 200) {
            oldPassword.value = '';
            newPassword.value = '';
        }
        Alert(this.responseText);
        loading(false);
    }
    xmlHttpRequest.open('POST', '/dashboard/cgi/change-password');
    xmlHttpRequest.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpRequest.send('oldPassword=' + encodeURIComponent(oldPassword.value) + '&newPassword=' + encodeURIComponent(newPassword.value));
}


function logoutDevices(id, is_all = false) {
    loading(true);
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {
        Alert(this.responseText);
        main();
        loading(false);
    }
    xmlHttpRequest.open('POST', '/dashboard/cgi/log-out-devices');
    xmlHttpRequest.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    if(is_all === true) {
        xmlHttpRequest.send('is_all=yes');
    } else {
        xmlHttpRequest.send('device_id=' + id);
    }
}

function updateSocialHandles() {
    let area = document.getElementById('social-handles-window');
    let inputs = area.getElementsByTagName('input');
    let socialHandlesArray = [];
    for(let i = 0; i < inputs.length; i++) {
        let input = inputs[i];
        if(input.getAttribute('type') == 'text') {

            let inputObject = {
                name: input.name.toLowerCase(),
                URL: input.value,
            };
            socialHandlesArray.push(inputObject);

        }
    }
    loading(true);
    const xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onload = function() {
        Alert(this.responseText);
        loading(false);
    }
    xmlHttpRequest.open('POST', '/dashboard/cgi/update-social-handles');
    xmlHttpRequest.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpRequest.send('handles=' + encodeURIComponent(JSON.stringify(socialHandlesArray)));
}