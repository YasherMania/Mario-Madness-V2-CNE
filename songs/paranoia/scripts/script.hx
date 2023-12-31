var tweenWindow1X, tweenWindow1Y, tweenWindow2X, tweenWindow2Y:FlxTween;

function create(){
    // i'll try to make this an array later, i aint too proud of this code
    tweenWindow1Y = FlxTween.tween(window, {y: changey + changex / 4}, 3, {ease: FlxEase.quadInOut, type: 4});
    tweenWindow1Y.active = false;

    tweenWindow1X = FlxTween.tween(window, {x: changex + changex / 2}, 5, {ease: FlxEase.quadInOut, type: 4});
    tweenWindow1X.active = false;

    tweenWindow2Y = FlxTween.tween(window, {y: changey + 50}, 5, {startDelay: 0.5, ease: FlxEase.cubeInOut, type: 4});
    tweenWindow2Y.active = false;

    tweenWindow2X = FlxTween.tween(window, {x: changex + 50}, 3, {ease: FlxEase.cubeInOut, type: 4});
    tweenWindow2X.active = false;
}

function beatHit(){
    if (curBeat == 241) FlxTween.tween(camHUD, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
    if (curBeat == 242) vocals.volume = 1; // for those who missed the note during virtual's speech
}

function stepHit(){
    switch (curStep){
		case 320:
			window.x = changex - 20;
			window.y = changey + 50;
		case 324:
			window.x = changex + 20;
			window.y = changey - 50;
		case 328:
			window.x = changex + 100;
			window.y = changey + 100;
		case 332:
			window.x = changex + 100;
			window.y = changey - 100;
			FlxTween.tween(window, {x: changex / 4, y: Std.int(changey / 4)}, 0.2, {startDelay: 0.2, ease: FlxEase.backIn});
        case 336:
            tweenWindow1X.active = true;
            tweenWindow1Y.active = true;
        case 384:
            for (i in [tweenWindow1X, tweenWindow1Y]){
                i.percent += 0.20;
                new FlxTimer().start(0.1, function(tmr:FlxTimer){
                    i.active = false;
                });
            }
        case 392:
            for (i in [tweenWindow1X, tweenWindow1Y]){
                i.active = true;
                i.percent += 0.20;
                new FlxTimer().start(0.1, function(tmr:FlxTimer){
                    i.active = false;
                });
            }
        case 400:
            for (i in [tweenWindow1X, tweenWindow1Y]){
                i.percent += 0.20;
                i.active = true;
            }
        case 488:
            for (i in [tweenWindow1X, tweenWindow1Y]) i.active = false;
            tweenWindow2Y.active = true;
            FlxTween.tween(window, {x: 325, y: 175}, 0.5, {ease: FlxEase.expoOut});
        case 576: tweenWindow2X.active = true;
        case 935:
            for (i in [tweenWindow2X, tweenWindow2Y]) i.active = false;
            FlxTween.tween(window, {x: 325, y: 175}, .5, {ease: FlxEase.cubeInOut});
    }
}