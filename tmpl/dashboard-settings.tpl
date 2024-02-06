
<div style="width: 100%;">
    <h1>Settings</h1>
    <br/>
    <br/>
    <div>

        <div class="settings-options">
            <span class="option">
                <button onclick="showSettingWindow(document.getElementById('login-devices-window'))"> <i class="fa fa-desktop"></i> Login devices</button>
            </span>
            <span class="option">
                <button onclick="showSettingWindow(document.getElementById('change-email-window'))"> <i class="fa fa-user-circle-o"></i> Change login Email</button>
            </span>
            <span class="option">
                <button onclick="showSettingWindow(document.getElementById('change-password-window'))"> <i class="fa fa-key"></i> Change login password</button>
            </span>
            <span class="option">
                <button onclick="Confirm('Are you sure you want to logout and reset your password?', ()=> window.location.replace('/logout?reset=password'));"> <i class="fa fa-lock"></i> Forgot password?</button>
            </span>
            <span class="option">
                <button onclick="onNavClick('/dashboard/posts');"> <i class="fa fa-book"></i> My posts</button>
            </span>
            <span class="option">
                <button onclick="onNavClick('/dashboard/pages');"> <i class="fa fa-internet-explorer"></i> My pages</button>
            </span>
            <span class="option">
                <button onclick="showSettingWindow(document.getElementById('social-handles-window'))"> <i class="fa fa-wifi"></i> Social handles</button>
            </span>
        </div>
        <br/>
        <br/>
        <br/>
        <button class="button danger block" onclick="Confirm('Are you sure you want to logout?', ()=>{ window.location.replace('/logout'); })">Log out</button>

    </div>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
</div>



<div class="setting-window" id="change-email-window">
    <div class="content">
        <button onclick="showSettingWindow(document.getElementById('change-email-window'))" class="button block">&times; Cancel</button>
        <br/>
        <br/>
        <h3>Change your login email address</h3>
        <br/>
        <br/>
        <form onsubmit="return false">
            <label for="settings-change-email-address-input">New email address:</label><br/>
            <input type="email" placeholder="Email address" name="changeEmail" id="settings-change-email-address-input" autocomplete="off"/>
            <br/>
            <label for="settings-change-email-password-input">Confirm password:</label><br/>
            <input type="password" placeholder="Password" name="changePassword" id="settings-change-email-password-input"/>
            <div id="settings-change-email-otp-field" style="display: none;">
                <br/>
                <label for="settings-change-email-otp-input">OTP:</label><br/>
                <input type="text" placeholder="Enter OTP from new email address" name="otp" id="settings-change-email-otp-input" autocomplete="off"/>                
            </div>
            <br/>
            <br/>
            <input type="submit" onclick="settingsChangeEmail()" name="submit" value="Change my email" class="button"/>
        </form>
    </div>
</div>



<div class="setting-window" id="change-password-window">
    <div class="content">
        <button onclick="showSettingWindow(document.getElementById('change-password-window'))" class="button block">&times; Cancel</button>
        <br/>
        <br/>
        <h3>Change your login password</h3>
        <br/>
        <br/>
        <form onsubmit="return false">
            <label for="settings-change-old-password-input">Old password:</label><br/>
            <input type="text" placeholder="Old password" name="oldPassword" id="settings-change-old-password-input" autocomplete="off"/>
            <br/>
            <label for="settings-change-new-password-input">New password:</label><br/>
            <input type="text" placeholder="New password" name="newPassword" id="settings-change-new-password-input" autocomplete="off"/>
            <br/>
            <a href="javascript:void(0)" onclick="Confirm('Are you sure you want to logout and reset your password?', ()=> window.location.replace('/logout?reset=password'));">Forgot your old password?</a>
            <br/>
            <br/>
            <input type="submit" onclick="Confirm('Are you sure yuo want to change your password?', ()=> settingsChangePassword())" name="submit" value="Change my password" class="button"/>
        </form>
    </div>
</div>


<div class="setting-window" id="login-devices-window">
    <div class="content">
        <button onclick="showSettingWindow(document.getElementById('login-devices-window'))" class="button block">&times; Cancel</button>
        <br/>
        <br/>
        <h3>Devices that loged in</h3>
        <br/>
        <button 
            onclick="Confirm('Are you sure you want to logout of all devices', ()=> logoutDevices(0, true));" 
            class="button danger">Logout all device</button>
        <br/>

        <div class="settings-login-devices">
            <!--forEach[login.devices]-->
            <div class="item">
                <div class="device <!--{CurrentDevice}-->">
                    <div class="image">
                        <img src="/assets/images/write-post.png" width="100" alt="Image"/>
                    </div>
                    <div style="font-size: 1.5em;color: #0f0;"><!--{IsCurrentDevice}--></div>
                    <h4><!--{DeviceName}--></h4>
                    <p>You loged in from "<!--{DeviceName}-->" on <!--{LogedDate}--></p>
                    <p><b>Device IP Address:</b> <!--{IPAddress}--></p>
                    <p><b>Last login:</b> <!--{LastLogedIn}--></p>
                    <p><b>Status:</b> <!--{State}--></p>

                    <div>
                        <button
                        onclick="Confirm('Are you sure you want to logout of this <!--{DeviceName}--> device', ()=> logoutDevices('<!--{ID}-->'));" 
                        class="button danger block">Logout this device</button>
                    </div>

                </div>
            </div>
            <!--end[login.devices]-->
        </div>

        <br/>
        <br/>
        <h4>Recently loged out devices:</h4>
        <br/>
        <br/>

        <div class="settings-login-devices">
            <!--forEach[logout.devices]-->
            <div class="item">
                <div class="device">
                    <div class="image">
                        <img src="/assets/images/write-post.png" width="100" alt="Image"/>
                    </div>
                    <h4><!--{DeviceName}--></h4>
                    <p>You loged in from "<!--{DeviceName}-->" on <!--{LogedDate}--></p>
                    <p><b>Device IP Address:</b> <!--{IPAddress}--></p>
                    <p><b>Last login:</b> <!--{LastLogedIn}--></p>
                    <p><b>Status:</b> <!--{State}--></p>

                </div>
            </div>
            <!--end[logout.devices]-->
        </div>

    </div>
</div>


<div class="setting-window" id="social-handles-window">
    <div class="content">
        <button onclick="showSettingWindow(document.getElementById('social-handles-window'))" class="button block">&times; Cancel</button>
        <br/>
        <br/>
        <h3>Social handles</h3>
        <br/>
        <br/>
        <form onsubmit="return false">
            <!--forEach[settings.social-handles]-->
            <label for="settings-update-social-handles-<!--{name}-->"><!--{name}-->:</label><br/>
            <input type="text" placeholder="<!--{name}-->" name="<!--{name}-->" value="<!--{URL}-->" id="settings-update-social-handles-<!--{name}-->" autocomplete="off"/>
            <br/>
            <!--end[settings.social-handles]-->

            <br/>
            <br/>
            <input type="submit" onclick="Confirm('Are you sure yuo want to update your social handles?', ()=> updateSocialHandles())" name="submit" value="Update" class="button"/>
        </form>
    </div>
</div>
