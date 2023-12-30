import flixel.addons.display.FlxBackdrop;

var intro:FlxSound;
var turtlesTime, tweenCam, startresize:Bool = false;

// WINDOW MOVE VAR
var winx:Int;
var winy:Int;

// i dont remember why im using this but ok
var changex:Int;
var changey:Int;

// WINDOW SIZE CHANGE VAR
var resizex:Int = 1280;
var resizey:Int = 720;

// MONITOR RESOLUTION
var fsX:Int = 1920;
var fsY:Int = 1080;

window.x = 325;
window.y = 175;
window.width = resizex;
window.height = resizey;
window.fullscreen = false;
window.resizable = false;

camHUD.visible = false;

function create(){
    intro = FlxG.sound.load(Paths.sound('game/virtualintro'));

    yourhead = new FlxBackdrop(Paths.image('stages/virtual/headbg'), -400, -200, 1, 1);
    yourhead.setGraphicSize(Std.int(yourhead.width * 2));
    yourhead.alpha = 0.2;
    yourhead.visible = false;
    yourhead.scrollFactor.set();
    insert(0, yourhead);

    gfwasTaken = new FlxSprite();
    gfwasTaken.x = 900;
    gfwasTaken.scrollFactor.set(.75, .75);
    gfwasTaken.frames = Paths.getFrames('stages/virtual/Mr_Virtual_Girlfriend_Assets_jaj');
    gfwasTaken.animation.addByPrefix('dies', 'GF Dies lol', 24, false);
    gfwasTaken.alpha = 0;
    insert(1, gfwasTaken);
}

function postUpdate(){
    if (tweenCam){
        camFollow.x = 1200;
        camFollow.y = 60;
    }

    if (startresize){
		window.resize(resizex, resizey);
		window.move(winx, winy);
	}
}

function onCountdown(event:CountdownEvent) event.cancelled = true;

function onStartCountdown(){
    intro.play();
    FlxTween.tween(camGame, {zoom: 0.5}, 1.3, {ease: FlxEase.expoOut});
}

function onSongStart(){
    camHUD.visible = true;
    defaultCamZoom = .6;
}

function turtles(){
    turtle.offset.x = 130;
    turtle2.offset.x = 40;
    for (i in [turtle, turtle2]){
        i.visible = true;
        i.animation.play('glitch');
        new FlxTimer().start(0.8, function(tmr:FlxTimer){
            turtlesTime = true;
            i.offset.x = 0;
        });
    }
}

function hideCam() for (i in [camGame, camHUD]) i.visible = false;

function beatHit() if (turtlesTime) for (i in [turtle, turtle2]) i.animation.play('idle');

function gf(){
    for (i in [camGame, camHUD, yourhead, crazyFloor]) i.visible = true;
    for (e in [vwall, backPipes, backFloor, turtle, turtle2, frontPipes, frontFloor, cornerPipes, gfwasTaken]) e.visible = false;
    tweenCam = false;
}

function measureHit(){
    yourhead.alpha = 0.8;
	yourhead.y = -200;
	FlxTween.tween(yourhead, {y: -122, alpha: 0.2}, 0.4, {ease: FlxEase.quadOut});
}

function whatsTheMatterBoy(){
    tweenCam = true;
    for (i in [turtle, turtle2]){
        i.animation.play('glitch');
        new FlxTimer().start(0.41, function(tmr:FlxTimer){
            i.visible = false;
        });
    }
    FlxTween.tween(vwall, {alpha: 0}, 0.5, {startDelay: 0.2, ease: FlxEase.sineIn});
    FlxTween.tween(camGame, {zoom: 1.4}, 4.4, {ease: FlxEase.quadIn});
    new FlxTimer().start(1, function(tmr:FlxTimer){
        gfwasTaken.alpha = 1;
        gfwasTaken.animation.play('dies');
    });
}

function preGfWindow(){
    FlxTween.tween(window, {x: 0, y: 0, width: 1980, height: 1080}, 1.6, {
        ease: FlxEase.expoIn,
        onComplete: function(twn:FlxTween){
            // CppAPI.setTransparency(window.title, 0x001957);
            startresize = false;
            window.borderless = false;
            window.fullscreen = true;
        }
    });
}