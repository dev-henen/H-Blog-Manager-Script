if(document.querySelector('#videoContainer')) {

    const video = document.getElementById("video");
    const videoContainer = document.getElementById("videoContainer");
    const track = document.getElementById("track");
    const showDuration = document.getElementById("showDuration");
    const playingDuration = document.getElementById("playingDuration");
    const playerCircle = document.getElementById("playerCircle");
    const spin = document.getElementById("spin");
    const playerInControls = document.getElementById("playerInControls");
    const range = document.getElementById("range");
    const volumePercent = document.getElementById("volumePercent");
    const volume = document.getElementById("volume");
    const mute = document.getElementById("mute");
    const videoSource = document.getElementById("videoSource");
    const videoPlayError = document.getElementById("videoPlayError");
    var tmpDuration = 0;
    var tmpVolume = 0;
    
    window.onload = function() {
        let totalVolumeFix = Math.round(video.volume * 100);
        video.controls = false;
        volume.value = totalVolumeFix;
        if(video.volume == 0) {
            mute.innerHTML = "<i class='fa fa-volume-off'></i>";
        } else {
            mute.innerHTML = "<i class='fa fa-volume-up'></i>";
        }
        setVolume(); 
        if(window.localStorage) {
            if(window.localStorage.getItem("volume") != null) {
                let userLastVolume = window.localStorage.getItem("volume");
                userLastVolume = Number(userLastVolume);
                video.volume = userLastVolume;
            }
            if(window.localStorage.getItem(videoSource.src) != null) {
                video.currentTime = window.localStorage.getItem(videoSource.src);
                range.value = (video.currentTime / video.duration * 60);
                track.style.width = (video.currentTime / video.duration * 100) + "%";
            }
        }
    };
    var startSpining
    try {
        var tmpI = 0;
        startSpining = setInterval(()=> {
            if(video.readyState < 4) {
                spin.style.display = "flex";
                playerCircle.style.display = "none";
                tmpI += 1;
                if(tmpI == ((1 * 2) * 60)) {
                    spin.style.display = "none";
                    videoPlayError.style.display = "initial";
                    range.outerHTML = "";
                    playerInControls.outerHTML = "<span style='display:inline-block;width:44px;height:30px;'></span>";
                    clearInterval(startSpining);
                }
            } else {
                spin.style.display = "none";
                playerCircle.style.display = "initial";
                clearInterval(startSpining);
            }
        }, 500);
    
    } catch(e) {
        clearInterval(startSpining);
    }
    var i;
    try {
        
        i = setInterval(()=>{
            if(video.readyState > 0) {
                const videoDuration = video.duration;
                const hours = parseInt(videoDuration / 3600, 10);
                const minutes = parseInt(videoDuration / 60 % 60 , 10);
                const seconds = videoDuration % 60;
                showDuration.innerHTML = hours.toFixed(0) + ":" + minutes.toFixed() + ":" + seconds.toFixed(0);
                clearInterval(i);
            }
        }, 500);
    
    } catch(e) {
        clearInterval(i);
    }
    
    
    range.oninput = ()=> {
        let rvalue = range.value;
        range.value = rvalue;
        track.style.width = ((video.currentTime / video.duration) * 100) + "%";
        video.currentTime = ((video.duration / 60) * rvalue);
    };
    
    volume.oninput = ()=> { setVolume(); };
    video.addEventListener("volumechange", ()=> {
        let totalVolumeFix = Math.round(video.volume * 100);
        volume.value = totalVolumeFix;
        if(video.volume == 0) {
            mute.innerHTML = "<i class='fa fa-volume-off'></i>";
        } else {
            mute.innerHTML = "<i class='fa fa-volume-up'></i>";
        }
        setVolume(); 
        if(video.volume != localStorage.getItem("volume")) {
            setLastVolume();
        }
    });
    
}


function play() {
    if(video.paused) {
        playerCircle.innerHTML = "<i class='fa fa-pause-circle-o'></i>";
        playerInControls.innerHTML = "<i class='fa fa-pause'></i>";
        video.play();
        var currentDuration = setInterval(()=> {
            const videoDuration = video.currentTime;
            const hours = parseInt(videoDuration / 3600, 10);
            const minutes = parseInt(videoDuration / 60 % 60, 10);
            const seconds = videoDuration % 60;
            playingDuration.innerHTML = hours.toFixed(0) + ":" + minutes.toFixed(0) + ":" + seconds.toFixed(0);
            track.style.width = (videoDuration / video.duration * 100) + "%";
            range.value = (videoDuration / video.duration * 60);
            if(videoDuration == video.duration) {
                playerCircle.innerHTML = "<i class='fa fa-play-circle-o'></i>";
                playerInControls.innerHTML = "<i class='fa fa-play'></i>";
            }
            setLastWatchTime();
        }, 1000);
        

        var startSpiningInPlay = setInterval(()=> {
            if(video.playing) {
                if(tmpDuration == video.currentTime) {
                    spin.style.display = "flex";
                    playerCircle.style.display = "none";
                } else {
                    spin.style.display = "none";
                    playerCircle.style.display = "initial";
                    tmpDuration = video.currentTime;
                }
            } else {
                clearInterval(startSpiningInPlay);
            }
            if(video.duration == video.currentTime) {
                spin.style.display = "none";
                playerCircle.style.display = "initial";
                clearInterval(startSpiningInPlay);
            }
        }, 500);
    

    } else {
        video.pause();
        playerCircle.innerHTML = "<i class='fa fa-play-circle-o'></i>";
        playerInControls.innerHTML = "<i class='fa fa-play'></i>";
        clearInterval(currentDuration);
    }
}

function fullscreen() {
    if(video.requestFullscreen) {
        video.requestFullscreen();
    }
}

function setVolume() {
    volumePercent.innerText = volume.value + "%";
    let totalVolume = volume.value / 100;
    switch(totalVolume) {
        case 0:
            totalVolume = totalVolume.toFixed(0);
        break;
        case 1:
            totalVolume = totalVolume.toFixed(0);
        break;
        default:
            totalVolume = totalVolume.toFixed(3);
    }
    video.volume = totalVolume;
}
function muteVolume() {
    if(video.volume == 0) {
        video.volume = tmpVolume;
        mute.innerHTML = "<i class='fa fa-volume-up'></i>";
    } else {
        if(video.volume != 0) {
            tmpVolume = video.volume; 
        }
        video.volume = 0;
        mute.innerHTML = "<i class='fa fa-volume-off'></i>";
    }
    setLastVolume();
}

function next() { video.currentTime += 5; }
function previous() { video.currentTime -= 5; }

function setLastVolume() {
    if(window.localStorage) {
        window.localStorage.setItem("volume", video.volume);
    }
}

function setLastWatchTime() {
    if(window.localStorage) {
        window.localStorage.setItem(videoSource.src, video.currentTime);
    }
}

function videoPreview(video) {
    video.volume = 0;
    video.play();
}
function stopVideoPreview(video) {
    video.pause();
    video.currentTime = 0;
}