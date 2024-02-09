var followchars = true;

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