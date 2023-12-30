function beatHit(){
    if (curBeat >= 48 && curBeat <= 112) camGame.zoom += 0.005;
    if (curBeat >= 112 && curBeat <= 141) camGame.zoom += 0.015;
    if (curBeat >= 144 && curBeat <= 176) camGame.zoom += 0.015;
    if (curBeat >= 258 && curBeat <= 324) camGame.zoom += .00625;
    if (curBeat >= 372 && curBeat <= 434) camGame.zoom += 0.005;
    if (curBeat >= 436 && curBeat <= 500) camGame.zoom += 0.005;

    if (curBeat >= 112 && curBeat <= 175) if (curBeat % 8 == 0) for (i in [camGame, camHUD]) i.shake(0.35, 0.002);
}