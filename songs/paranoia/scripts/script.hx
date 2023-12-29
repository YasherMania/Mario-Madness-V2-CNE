camHUD.visible = false;
window.resizable = false;

function onCountdown(event:CountdownEvent) event.cancelled = true;

function onSongStart() camHUD.visible = true;