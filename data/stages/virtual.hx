import flixel.addons.display.FlxBackdrop;
import sys.FileSystem;

var realPath = StringTools.replace(FileSystem.absolutePath(Assets.getPath("assets/images/stages/virtual/toolate.bmp")), "/", "\\");

static var turtlesTime, shake, cancelCameraMove, gfCamTime:Bool = false;

public var bgBeatMore:Bool = true;

var pixelTween:NumTween;

public var timer:Float = .75;
public var gfCamX:Float = 750;

public var dadZoom:Float = .5;
public var bfZoom:Float = .8;

// i dont remember why im using this but ok
public var changex:Int;
public var changey:Int;

// shader shit
var pixel:CustomShader = null;

var dupe:CustomShader = null;
var dupeTimer:Int = 0;
var dupeMax:Int = 4;
var inc:Bool = true;

var angel:CustomShader = null;

if (FlxG.save.data.virtualWindow){
    window.x = winX;
    window.y = winY;
    window.width = resizex;
    window.height = resizey;
    changex = window.x;
    changey = window.y;
    window.fullscreen = false;
    window.resizable = false;
}

camGame.visible = camHUD.visible = false;

function create(){
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

    pixel = new CustomShader("mosaicShader");
    pixel.data.uBlocksize.value = [40, 40];
    camGame.addShader(pixel);

    pixelTween = FlxTween.num(40, 0, 0.7, {onUpdate: (_) -> {
        pixel.data.uBlocksize.value = [pixelTween.value, pixelTween.value];
    }});
    pixelTween.onComplete = function(){
        camGame.removeShader(pixel);
    }

    dupe = new CustomShader("camDupe");
    dupe.multi = 1;
    dupe.mirrorS = false;
    if (FlxG.save.data.virtualShaders) camGame.addShader(dupe);

    angel = new CustomShader("angel");
    angel.data.pixel.value = [1, 1];
    angel.data.stronk.value = [1, 1];
}

function postCreate(){
    timeTxt.color = FlxColor.RED;
    timeBar.createFilledBar(0xFF000000, FlxColor.RED);
}

function update(elapsed:Float){
    if (health <= 0 && window.width != fsX && window.height != fsY) setWallpaper(prevWallpaper);

    switch (curCameraTarget){
        case 0: defaultCamZoom = dadZoom;
        case 1: defaultCamZoom = bfZoom;
    }

    if(angel != null){
        angel.data.stronk.value[0] = FlxMath.lerp(angel.data.stronk.value[0], 0, FlxMath.bound(elapsed * 8, 0, 1));

        angel.data.pixel.value[0] = FlxMath.lerp(angel.data.pixel.value[0], 1, FlxMath.bound(elapsed * 4, 0, 1));
        angel.data.iTime.value = [Conductor.songPosition / 1000];
    }

    if (gfCamTime){
        timer += elapsed;
        camFollow.x = (gfCamX + (100 * Math.sin(timer)));
        camFollow.y = (500 + (100 * Math.cos(timer)));
        camGame.shake(.00225, 99999999999);
        camHUD.shake(.00175, 99999999999);
    }

    if (FlxG.keys.justPressed.TWO){
        FlxG.switchState(new FreeplayState());
        onSongEnd();
    }
}

var noteSize:Float = 3.5;
function onNoteCreation(event) {
	event.cancel();

	var note = event.note;
	if (event.note.isSustainNote) {
		note.loadGraphic(Paths.image('game/notes/Virtual_NOTE_assetsENDS'), true, 60, 6);
		note.animation.add("hold", [event.strumID]);
		note.animation.add("holdend", [4 + event.strumID]);
	}else{
		note.loadGraphic(Paths.image('game/notes/Virtual_NOTE_assets'), true, 32, 33);
		note.animation.add("scroll", [4 + event.strumID]);
	}
	note.scale.set(noteSize, noteSize);
	note.updateHitbox();
}

function onStrumCreation(event) {
	event.cancel();

	var strum = event.strum;
	strum.loadGraphic(Paths.image('game/notes/Virtual_NOTE_assets'), true, 32, 33);
	strum.animation.add("static", [event.strumID]);
	strum.animation.add("pressed", [4 + event.strumID, 8 + event.strumID], 12, false);
	strum.animation.add("confirm", [12 + event.strumID, 16 + event.strumID], 24, false);

	strum.updateHitbox();

    strum.scale.set(noteSize, noteSize);
}

function onPostNoteCreation(event) {  
    var note = event.note;
    if (FlxG.save.data.Splashes) note.splash = "redDiamond";
    else if (FlxG.save.data.Splashes == 0) note.splash = "redVanilla";
    else return;

    // fixes sustain note's x offset
    if (note.isSustainNote)  note.frameOffset.x -= note.frameWidth / 4; 
}

function onPlayerHit(event:NoteHitEvent) event.ratingPrefix = "game/score/paranoia/"; // this sucks but coloring the rating stuff with coding didnt work sooo

function onCountdown(event:CountdownEvent) event.cancelled = true;

function onStartCountdown(){
    FlxG.sound.play(Paths.sound('game/virtual/virtualintro'));
    camGame.zoom = 1;
    camGame.visible = true;
    FlxTween.tween(camGame, {zoom: 0.5}, 1.3, {ease: FlxEase.expoOut});
}

function onSongStart(){
    camHUD.visible = true;
    FlxG.camera.followLerp = 0.04;
}

function onCameraMove(e) if(cancelCameraMove) e.cancel();

function turtles(){
    for (i in [turtle, turtle2]){
        i.visible = true;
        i.animation.play('glitch');
        new FlxTimer().start(0.8, function(tmr:FlxTimer){
            turtlesTime = true;
        });
    }
}

function startShake() shake = true;

function stopShake() shake = false;

function hideCam() camGame.visible = false;

function beatHit(){
    if (turtlesTime) for (i in [turtle, turtle2]) i.animation.play('idle');

    if (bgBeatMore && curBeat % 2 == 0){
        yourhead.alpha = 0.8;
        yourhead.y = -200;
        FlxTween.tween(yourhead, {y: -122, alpha: 0.2}, 0.4, {ease: FlxEase.quadOut});
    }

    if (shake && curBeat % 8 == 0){
        camGame.shake(0.0035, 0.2);
        camHUD.shake(0.0035, 0.2);
    }

    if(dupeTimer != 0){
        if(curBeat % dupeTimer == 0){
            if(inc){
                angel.data.pixel.value[0] = [2, 2];
                dupe.mirrorS = false;
                dupe.data.multi.value[0] += 1;
                if(dupe.data.multi.value[0] == dupeMax) inc = false;
            }else{
                angel.data.pixel.value[0] = [.5, .5];
                dupe.mirrorS = true;
                dupe.data.multi.value[0] -= 1;
                if(dupe.data.multi.value[0] == 1) inc = true;
            }
            angel.data.stronk.value[0] = ((0.25 / 4))  * dupe.data.multi.value[0];
        }	
    }
}

function measureHit() if (!bgBeatMore && curStep < 2209){
    yourhead.alpha = 0.8;
	yourhead.y = -200;
	FlxTween.tween(yourhead, {y: -122, alpha: 0.2}, 0.4, {ease: FlxEase.quadOut});
}

function whatsTheMatterBoy(){
    cancelCameraMove = true;
    FlxTween.tween(camFollow, {x: 1200, y: 60}, .6, {ease: FlxEase.quartIn});
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

function noMoreFullscreen(){
    cancelCameraMove = false;
    gfCamTime = false;
    window.borderless = false;
    cameraMovementEnabled = true;
    canPause = true;
    for (i in [hudTxt, timeTxt, timeBar, timeBarBG]) i.visible = true;
    FlxTween.tween(window, {x: winX, y: winY, width: resizex, height: resizey}, 1, {ease: FlxEase.expoOut});
    crazyFloor.visible = false;
    yourhead.visible = true;
    dadZoom = bfZoom = .85;
    FlxG.camera.followLerp = 0.04;
    camGame.shake(.00225, .001);
    camHUD.shake(.00175, .001);
    if (FlxG.save.data.virtualTrans) removeTransparent();
    showTaskbar();
    if (FlxG.save.data.virtualApps) showWindows(prevHidden);
}

function preGfWindow(){
    if (FlxG.save.data.virtualWindow){
        FlxTween.tween(window, {x: 0, y: 0, width: fsX, height: fsY}, 1.6, {
            ease: FlxEase.expoIn,
            onComplete: function(twn:FlxTween){
                window.borderless = false;
                hideTaskbar();
                if (FlxG.save.data.virtualApps) prevHidden = hideWindows(window.title);
                if (FlxG.save.data.virtualWallpaper){
                    setWallpaper(realPath);
                    trace(realPath);
                }
            }
        });
    }
}

function dupingTime1(){
    dupeTimer = 4;
    dupeMax = 3;
    if (FlxG.save.data.virtualShaders) for (i in [camGame, camHUD]) i.addShader(angel);
}

function dupingTime2(){
    dupeTimer = 1;
    dupeMax = 6;
}

function stopDupe(){
    dupeTimer = 0;
    dupe.mirrorS = false;
    dupe.multi = 1;
    for (i in [camGame, camHUD]) i.removeShader(angel);
}

function gf(){
    for (i in [camGame, camHUD, crazyFloor]) i.visible = true;
    for (i in [hudTxt, timeTxt, timeBar, timeBarBG]) i.visible = false;
    for (e in [vwall, backPipes, backFloor, turtle, turtle2, frontPipes, frontFloor, cornerPipes, gfwasTaken]){
        remove(e, true);
        e.destroy();
    }
    turtlesTime = false;
    trace(prevHidden);
    if (!FlxG.save.data.virtualTrans) yourhead.visible = true;
    FlxG.camera.bgColor = 0xFF000101;
    camHUD.alpha = 1;
    dadZoom = bfZoom = .4;
    gfCamTime = true;
    cameraMovementEnabled = false;
    canPause = false;
    if (FlxG.save.data.virtualTrans) setTransparent(true, 0, 1, 1);
    if (FlxG.save.data.virtualWallpaper) setWallpaper(realPath); // being run again to prevent black background
}

function destroy(){
    removeTransparent();
    showTaskbar();
    setWallpaper(prevWallpaper);
    showWindows(prevHidden);
    window.resizable = true;
}