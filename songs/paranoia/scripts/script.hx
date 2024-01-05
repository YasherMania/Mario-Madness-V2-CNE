// most of these vars and events are in the virtual stage hx file btw, im a pretty messy programmer tbh - apurples

var tweenWindow1X, tweenWindow1Y, tweenWindow2X, tweenWindow2Y:FlxTween;
var timerTween:NumTween;

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
    switch(curBeat){
        case 241: FlxTween.tween(camHUD, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
        case 242: vocals.volume = 1; // for those who missed the note during virtual's speech
        case 323, 435, 503: bgBeatMore = false;
        case 371, 439: bgBeatMore = true;
    }
}

function stepHit(){
    if (FlxG.save.data.virtualWindow){
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
            case 448:
                for (i in [tweenWindow1X, tweenWindow1Y]) i.active = false;
                tweenWindow2Y.active = true;
                FlxTween.tween(window, {x: winX, y: winY}, 0.5, {ease: FlxEase.expoOut});
            case 576: tweenWindow2X.active = true;
            case 935:
                for (i in [tweenWindow2X, tweenWindow2Y]) i.active = false;
                FlxTween.tween(window, {x: winX, y: winY}, .5, {ease: FlxEase.cubeInOut});
            case 1168: 
                timer = .75;
                timerTween = FlxTween.num(.75, .075, 1, {ease: FlxEase.quartIn, onUpdate: (_) -> {
                    timer = .075;
                }});
            case 1232:
                gfCamX = 1350;
                FlxG.camera.followLerp = .005;
                FlxTween.tween(camGame, {zoom: .775}, 4, {ease: FlxEase.quadInOut}).onComplete = function(){
                    bfZoom = .775;
                }
            case 1288: FlxTween.tween(camGame, {zoom: .825}, .25, {ease: FlxEase.quintOut}).onComplete = function(){bfZoom = .825;}
            case 1292: FlxTween.tween(camGame, {zoom: .875}, .1, {ease: FlxEase.quintOut}).onComplete = function(){bfZoom = .875;}
            case 1294: FlxTween.tween(camGame, {zoom: .925}, .1, {ease: FlxEase.quintOut}).onComplete = function(){bfZoom = .925;}
            case 1296: if (FlxG.save.data.flashingLights) camGame.flash(FlxColor.BLACK, 1);
            case 1348:
                FlxTween.tween(camGame, {zoom: .5}, .775, {ease: FlxEase.quadOut}).onComplete = function(){
                    dadZoom = .5;
                    bfZoom = .85;
                }
        }
    }
}