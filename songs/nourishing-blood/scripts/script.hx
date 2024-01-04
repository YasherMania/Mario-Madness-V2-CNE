
var xx = 120;
var yy = 650;
var yyh = 350;
var xx2 = 1120;
var yy2 = 750;
var ofs = 30;
var ofs2 = 270;
var followchars = true;
var del = 0;
var del2 = 0;
var hide = false;

function postUpdate() {
    if (!followchars) camFollow.setPosition(800, -1000);
}

// function onUpdate()
//     if followchars == false then
//         triggerEvent('Camera Follow Pos','800','-1000')
//     end
// end

function beatHit() {
    if (curBeat >= 4 && curBeat <= 228) {
        camZoomingInterval = 1;
    }
    if (curBeat >= 244 && curBeat <= 359) {
        camZoomingInterval = 1;
    }
    if (curBeat >= 392 && curBeat <= 404) {
        ofs2 = 170;
        camZoomingInterval = 1;
    }
}

// function onBeatHit()     
//     if curBeat >= 4 and curBeat <= 228 then
//         triggerEvent('Add Camera Zoom','0.01','')
//     end

//     if curBeat >= 244 and curBeat <= 359 then
//         triggerEvent('Add Camera Zoom','0.01','')
//     end

//     if curBeat >= 392 and curBeat <= 404 then
//         ofs2 = 170
//         triggerEvent('Add Camera Zoom','0.01','')
//     end
// end