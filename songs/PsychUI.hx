import openfl.geom.Rectangle;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.FlxG;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import flixel.math.FlxPoint;
import openfl.events.KeyboardEvent;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.ui.Keyboard;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.system.framerate.FramerateCounter;
import openfl.system.System;
import openfl.text.TextFormat;
import openfl.Lib;
import flixel.FlxG;
import funkin.options.Options;

if (FlxG.save.data.ShowPsychUI) {
// fps vars
public var finalFPS:Float = 0;
public var memories = Math.abs(FlxMath.roundDecimal(System.totalMemory / 1000000, 1));
public var camFPS = null;
public var fpsfunniCounter:FlxText;

public var sicks:Int = 0;
public var goods:Int = 0;
public var bads:Int = 0;
public var shits:Int = 0;
public var timeBarBG:FlxSprite;
public var timeBar:FlxBar;
public var timeTxt:FlxText;
public var hudTxt:FlxText;
public var hudTxtTween:FlxTween;
public var ratingFC:String = "FC";
public var botplaySine:Float = 0;
public var ratingStuff:Array<Dynamic> = [
    ['F', 0.2],
    ['E', 0.4],
    ['D', 0.5],
    ['C', 0.6],
    ['B', 0.69],
    ['A', 0.7],
    ['A+', 0.8],
    ['S', 0.9],
    ['S+', 1],
    ['SS+', 1]
];

function getRating(accuracy:Float):String {
    if (accuracy < 0) {
        return "?";
    }
    for (rating in ratingStuff) {
        if (accuracy < rating[1]) {
            return rating[0];
        }
    }
    return ratingStuff[ratingStuff.length - 1][0];
}

function new() {
    FlxG.cameras.add(camFPS = new HudCamera(), false);
    camFPS.bgColor = 0;
    fpsfunniCounter = new FlxText(10,10, 400, 18);
    fpsfunniCounter.setFormat("Mario2.ttf", 10,0xFFa11b1b /*0xFFe30000*/);
    fpsfunniCounter.antialiasing = true;
    fpsfunniCounter.scrollFactor.set();
    fpsfunniCounter.cameras = [camFPS];
    add(fpsfunniCounter);
    finalFPS = 0;
    Framerate.fpsCounter.visible = false;
    Framerate.memoryCounter.visible = false;
    Framerate.codenameBuildField.visible = false;
}

function create() {
    timeTxt = new FlxText(0, 19, 400, "X:XX", 22);
    timeTxt.setFormat(Paths.font("Mario2.ttf"), 22, 0xFFf42626, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    timeTxt.antialiasing = true;
    timeTxt.scrollFactor.set();
    timeTxt.alpha = 0.000001;
    timeTxt.borderColor = 0xFF000000;
    timeTxt.borderSize = 2;
    timeTxt.screenCenter(FlxAxes.X);
    timeTxt.color = FlxG.save.data.botplayOption ? 0xFF25cd49 : 0xFFf42626;

    hudTxt = new FlxText(0, 685, FlxG.width, "Score: 0      Misses: 0      Rating: ?");
    hudTxt.setFormat(Paths.font("Mario2.ttf"), 15, 0xFFf42626, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    hudTxt.borderSize = 1.25;
    hudTxt.antialiasing = true;
    hudTxt.scrollFactor.set();
    hudTxt.screenCenter(FlxAxes.X);
    hudTxt.color = FlxG.save.data.botplayOption ? 0xFF25cd49 : 0xFFf42626;

    timeBarBG = new FlxSprite();
    timeBarBG.x = timeTxt.x;
    timeBarBG.y = timeTxt.y + (timeTxt.height / 4);
    timeBarBG.alpha = 0;
    timeBarBG.scrollFactor.set();
    timeBarBG.color = FlxColor.BLACK;
    timeBarBG.loadGraphic(Paths.image("psychTimeBar"));

    timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBar.FILL_LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), Conductor, 'songPosition', 0, 1);
    timeBar.scrollFactor.set();
    timeBar.createFilledBar(0xFF000000, FlxG.save.data.botplayOption ? 0xFF25cd49 : 0xFFF42626);
    timeBar.numDivisions = 400;
    timeBar.alpha = 0.000001;
    timeBar.value = Conductor.songPosition / Conductor.songDuration;
    timeBar.unbounded = true;

    luigiLogo = new FlxSprite(400, timeBarBG.y + 55);
    luigiLogo.loadGraphic(Paths.image("game/luigi"));
    luigiLogo.scrollFactor.set();
    luigiLogo.scale.set(0.3, 0.3);
    luigiLogo.updateHitbox();
    luigiLogo.screenCenter(FlxAxes.X);
    luigiLogo.y = timeBarBG.y + ((!downscroll ? 40 : 40));
    luigiLogo.alpha = 0.000001;
    luigiLogo.visible = FlxG.save.data.botplayOption;
    add(luigiLogo);
    add(timeBarBG);
    add(timeBar);
    add(timeTxt);

    timeBarBG.x = timeBar.x - 4;
    timeBarBG.y = timeBar.y - 4;

    hudTxt.cameras = [camHUD];
    timeBar.cameras = [camHUD];
    timeBarBG.cameras = [camHUD];
    timeTxt.cameras = [camHUD];
    luigiLogo.cameras = [camHUD];
}

function onSongStart() for (i in [timeBar, timeBarBG, timeTxt, luigiLogo]) FlxTween.tween(i, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

function update(elapsed:Float) {
    if (inst != null && timeBar != null && timeBar.max != inst.length) timeBar.setRange(0, Math.max(1, inst.length));

    if (inst != null && timeTxt != null) {
        var timeRemaining = Std.int((inst.length - Conductor.songPosition) / 1000);
        var seconds = CoolUtil.addZeros(Std.string(timeRemaining % 60), 2);
        var minutes = Std.int(timeRemaining / 60);
        timeTxt.text = minutes + ":" + seconds;
    }

    botplaySine += 180 * elapsed;
    luigiLogo.angle = ((1 - Math.sin((Math.PI * botplaySine) / 180)) * 20) - 20;

    var acc = FlxMath.roundDecimal(Math.max(accuracy, 0) * 100, 2);
    var rating:String = getRating(accuracy);
    if (songScore > 0 || acc > 0 || misses > 0) hudTxt.text = "Score: " + songScore + "    Misses: " + misses +  "    Rating: " + rating + " (" + acc + "%)";

    finalFPS = CoolUtil.fpsLerp(finalFPS, FlxG.elapsed == 0 ? 0 : (1 / FlxG.elapsed), 0.25);
    fpsfunniCounter.text = "FPS: " + Std.string(Math.floor(finalFPS)) + "\nMemory: " + memories + " MB";
    player.cpu = FlxG.save.data.botplayOption;

    if (memories == 3000 || finalFPS <= Options.framerate / 2) fpsfunniCounter.color = 0xFFe30000;
    else fpsfunniCounter.color = 0xFFA11B1B;
}

function onSubstateClose(state) {
    hudTxt.color = FlxG.save.data.botplayOption ? 0xFF25cd49 : 0xFFf42626;
    timeTxt.color = FlxG.save.data.botplayOption ? 0xFF25cd49 : 0xFFf42626;
    luigiLogo.visible = FlxG.save.data.botplayOption;
    timeBar.createFilledBar(0xFF000000, FlxG.save.data.botplayOption ? 0xFF25cd49 : 0xFFF42626);
    timeBar.updateFilledBar();
}

function onPlayerHit(event) {
    if (event.note.isSustainNote) return;

    if(hudTxtTween != null) hudTxtTween.cancel();
    hudTxt.scale.x = hudTxt.scale.y = 1.1;
    hudTxtTween = FlxTween.tween(hudTxt.scale, {x: 1, y: 1}, 0.2, {onComplete: function(twn:FlxTween) {hudTxtTween = null;}});

    switch (event.rating) {
        case "sick": sicks++;
        case "good": goods++;
        case "bad": bads++;
        case "shit": shits++;
    }

    ratingFC = 'Clear';

    if(misses < 1) {
		if (bads > 0 || shits > 0) ratingFC = 'FC';
		else if (goods > 0) ratingFC = 'GFC';
		else if (sicks > 0) ratingFC = 'SFC';
	}
	else if (misses < 10) ratingFC = 'SDCB';
}

function postCreate() {
    for (i in [missesTxt, accuracyTxt, scoreTxt]) i.visible = false;

    if (downscroll) hudTxt.y = healthBarBG.y - 58;

    add(hudTxt);

    healthBar.y = FlxG.height * 0.89;
    healthBarBG.y = healthBar.y - 4;

    iconP1.y = healthBar.y - 75;
    iconP2.y = iconP1.y;

    if (!downscroll)  hudTxt.y = healthBarBG.y + 38;
    
    if (FlxG.save.data.showBar) for (i in [timeTxt, timeBar, timeBarBG]) i.visible = false;
    
    if (FlxG.save.data.showTxt) hudTxt.visible = false;
}

function destroy() for (i in [Framerate.fpsCounter, Framerate.memoryCounter, Framerate.codenameBuildField]) i.visible = true;
}