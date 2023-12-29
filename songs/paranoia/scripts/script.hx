camHUD.visible = false;
window.resizable = false;

function onCountdown(event:CountdownEvent) event.cancelled = true;

function onSongStart() camHUD.visible = true;

function beatHit(){
    if (curBeat >= 48 && curBeat <= 112) camGame.zoom += 0.005;
    if (curBeat >= 112 && curBeat <= 141) camGame.zoom += 0.015;
}