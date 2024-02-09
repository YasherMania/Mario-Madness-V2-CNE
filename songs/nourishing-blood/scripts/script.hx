var followchars = false;

function onCameraMove(e) {
    if (!followchars) e.cancel();
}

function onCountdown(e) e.cancel();

function postCreate() {
    camHUD.alpha = 0;
    camGame.fade(FlxColor.BLACK, Conductor.crochet / 8000, true, function() {
        trace("fade done");
        camHUD.alpha = 1;
        followchars = true;
    });

}

function postUpdate() {
    if (!followchars) camFollow.setPosition(800, -1000);
}

function beatHit() {
    if (curBeat >= 4 && curBeat <= 228) {
        camZoomingInterval = 1;
    }
    if (curBeat >= 244 && curBeat <= 359) {
        camZoomingInterval = 1;
    }
    if (curBeat >= 392 && curBeat <= 404) {
        camZoomingInterval = 1;
    }
}