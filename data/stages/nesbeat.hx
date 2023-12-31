import openfl.Lib;
import flixel.group.FlxGroup;
import funkin.editors.EditorTreeMenu;

public var isUnbeatable = true;

var blackBarThingie:FlxSprite;
var shader:CustomShader = null;
var time:Float=0;

var goobersL:FlxGroup;
var goobersR:FlxGroup;
var beatuspart:FlxGroup;

var light1:FlxSprite;
var light2:FlxSprite;

var bt = 8;
var shootBt = false;
var shootTimer = -8;
var CB = 0;

var curMisses = 0;
var beatUsPart = false;
var isGameOver = false;

var tween:FlxTween;
function onCountdown(event:CountdownEvent) event.cancelled = true;

// hello!!! its me, bromaster!!! i know this code is a little messy, but uhhh, it works!!
function create() {
	cross.visible = false;

        dad.alpha = 0;
	tree.alpha = 0;
	georgeW.alpha = 0;

        Lib.application.window.title="Friday Night Funkin': Mario's Madness | Unbeatable | RedTV53 ft. theWAHbox, scrumbo_, FriedFrick & Ironik";
        bg.screenCenter();
	bg.alpha = 0;
        bg.antialiasing = true;
        add(bg);
        FlxTween.tween(bg, {angle: 360}, 35, {ease: FlxEase.smootherQuartInOut, type: FlxTween.PINGPONG});

	strumLines.members[0].characters[1].alpha = 0;
	tree.x = -200;
	georgeW.x = 1400;
	grass.alpha = 0;

        blackBarThingie = new FlxSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
        blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width + 100));
        blackBarThingie.scrollFactor.set(0, 0);
        blackBarThingie.screenCenter();
        add(blackBarThingie);

    	var light1 = new FlxSprite(-25, -200);
    	light1.frames = Paths.getSparrowAtlas('stages/beatus/ycbu_lightning');
    	light1.animation.addByPrefix('uh', "lightning", 24, true);
    	light1.antialiasing = true;
	light1.setGraphicSize(Std.int(light1.width * 1.2));
    	light1.updateHitbox();
    	add(light1);
	light1.animation.play('uh', true);
	light1.visible = false;
		//i know there might be a better way to do this but uhhh not right now
    	var light2 = new FlxSprite(900, -200);
    	light2.frames = Paths.getSparrowAtlas('stages/beatus/ycbu_lightning');
    	light2.animation.addByPrefix('uh', "lightning", 24, true);
    	light2.antialiasing = true;
	light2.setGraphicSize(Std.int(light2.width * 1.2));
    	light2.updateHitbox();
    	add(light2);
	light2.animation.play('uh', true);

    	goobersL = new FlxGroup(500);

	for (i in 0...3) {
    		var goob = new FlxSprite(-100, i * 500);
    		goob.frames = Paths.getSparrowAtlas('stages/beatus/YouCannotBeatUS_Fellas_Assets');
    		goob.animation.addByPrefix('p1', "Rotat e", 24, true);
    		goob.animation.addByPrefix('p2', "Bird Up", 24, true);
    		goob.animation.addByPrefix('p3', "Lakitu", 24, true);
    		goob.antialiasing = true;
		goob.setGraphicSize(Std.int(goob.width * 0.5));
    		goob.updateHitbox();
		goob.velocity.y = -500;
    		add(goob);
		goobersL.add(goob);
		goob.animation.play('p1', true);
	}

    	goobersR = new FlxGroup(500);

	for (i in 0...3) {
    		var goob = new FlxSprite(850, i * 500);
    		goob.frames = Paths.getSparrowAtlas('stages/beatus/YouCannotBeatUS_Fellas_Assets');
    		goob.animation.addByPrefix('p1', "Rotat e", 24, true);
    		goob.animation.addByPrefix('p2', "Bird Up", 24, true);
    		goob.animation.addByPrefix('p3', "Lakitu", 24, true);
    		goob.antialiasing = true;
		goob.setGraphicSize(Std.int(goob.width * 0.5));
    		goob.updateHitbox();
		goob.velocity.y = 500;
    		add(goob);
		goobersR.add(goob);
		goob.animation.play('p1', true);
	}

        shader = new CustomShader("crt");
	shader.anaglyphIntensity = 0.3;
	shader.whiteIntensity = 0.7;
        camGame.addShader(shader);

	boyfriend.x -= 150;
	gf.x -= 150;

    	beatuspart = new FlxGroup(500);
	beatuspart.add(light1);
	beatuspart.add(light2);
	for (i in goobersL) beatuspart.add(i);
	for (i in goobersR) beatuspart.add(i);
	for (i in beatuspart) i.visible = false;
}
var savedEvents = [];
function postCreate(){
        camHUD.alpha=0;
	savedEvents = events.copy();
}
var dummyvar = 0;

function postUpdate(elapsed:Float) {
    	switch(curCameraTarget) {
        	case 0:
                	dad.visible = true;
                	boyfriend.visible = false;
                	gf.visible = false;
			strumLines.members[0].characters[1].visible = true;
                    
                	if (dummyvar != -1) {
		 	       blackBarThingie.alpha = 0.3;
                        	FlxTween.tween(blackBarThingie, {alpha: 0},1, {ease: FlxEase.linear, type: FlxTween.ONESHOT});    
            	        	dummyvar = -1;
                	}

                	alreadychange = false;
        	case 1:
                	dad.visible = false;
                	boyfriend.visible = true;
                	gf.visible = true; 
			strumLines.members[0].characters[1].visible = false;    
                	if (dummyvar != 1) {
		        	blackBarThingie.alpha = 0.3;
                        	FlxTween.tween(blackBarThingie, {alpha: 0},1, {ease: FlxEase.linear, type: FlxTween.ONESHOT});    
                        	dummyvar = 1;
                	}
    	}
	for (goob in goobersL) {
		if (goob.y < -500) {
			goob.y = 1000;
		}
	}
	for (goob in goobersR) {
		if (goob.y > 1000) {
			goob.y = -500;
		}
	}
	if (shootTimer > 0) {
		shootTimer -= elapsed * 120;
		if (health > 0.2) {
			health -= 0.004;
		}
		trace(shootTimer);
	}
	if (shootTimer < 1 && shootTimer > -1) {
		camGame.bgColor = FlxColor.fromRGB(85,149,218,255);
		trace("shots disarmed");
		shootTimer = -8;
	}

	if (misses != curMisses) {
		trace("FUCK");
		curMisses = misses;
		if (beatUsPart) {
			gameOver();
		}
	}
}

function beatHit(curBeat)
{
	trace(curBeat);
	if (curBeat == 0) {
		bg.alpha = 0;
		tween = FlxTween.tween(bg, {alpha: 0.8}, 16, {ease: FlxEase.linear, type: FlxTween.ONESHOT});
		dad.visible = false;
		boyfriend.visible = false;
		gf.visible = false;
		tree.alpha = 0;
		georgeW.alpha = 0;
		strumLines.members[0].characters[1].alpha = 0;
		tree.x = -200;
		georgeW.x = 1400;
		grass.alpha = 0;
		camGame.bgColor = FlxColor.BLACK;
	}
	if (curBeat > 428 && curBeat < 700) tween.cancel();
	if ((curBeat - 1) % bt == 0) {
		trace(bt);
		if (Std.string(bt) == "8") {} else shoot(); //dunno man
	}
}
function stepHit(curStep){
        switch(curStep){
                case 109:FlxTween.tween(camHUD,{alpha:1},2.5,{ease:FlxEase.smootherStepInOut});
        }
}

function START() {
	dad.alpha = 1;
	boyfriend.alpha = 1;
	gf.alpha = 1;
	dad.visible = true;
	boyfriend.visible = true;
	gf.visible = true;
}

var curVideo = null;
import hxvlc.flixel.FlxVideo;
function gameOver() {
	health = 0.1;
	inst.time = 0;
	inst.volume = 0;
	isGameOver = true;
	trace("uh oh you died!!");
        curVideo = new FlxVideo();
        curVideo.onEndReached.add(curVideo.dispose);
        var path = Paths.file("videos/hutchersonCR.mp4");
        curVideo.play(Assets.getPath(path));
        trace("video played!");
        if (curVideo == null) trace("video did not play! did you check if the video name is spelled correctly?");

}

function update(elapsed:Float){
	time += 100;
	shader.time = time;
	if (health < 0.1) gameOver();
	if (isGameOver) {
		health = 0.1;
		inst.time = 0;
		vocals.time = 0;
		if (controls.BACK || controls.ACCEPT) {
			trace("IM OUTA HERE!!!!");
			end();
		}
	} else {
		inst.volume = 1;
		vocals.volume = 1;
	}
}
function end() {
	curVideo.dispose();
	if (FlxG.sound.music != null) FlxG.sound.music.stop();
	if (FlxG.game.contains(curVideo)) {
		FlxG.game.removeChild(curVideo);
	}
	isGameOver = false;
	bg.alpha = 0;
	tween = FlxTween.tween(bg, {alpha: 0.8}, 16, {ease: FlxEase.linear, type: FlxTween.ONESHOT});
	dad.alpha = 0;
	boyfriend.alpha = 0;
	gf.alpha = 0;
	tree.alpha = 0;
	georgeW.alpha = 0;
	strumLines.members[0].characters[1].alpha = 0;
	tree.x = -200;
	georgeW.x = 1400;
	grass.alpha = 0;
	camGame.bgColor = FlxColor.BLACK;
	bt = 8;
	resyncVocals();
	for (s in strumLines) s.generate(s.data, null);
	events = savedEvents.copy();
}

function fadeOpp() {
	//face opponent notes out (for function 'mid()')
	for (i in 0...4) {
    		FlxTween.tween(cpuStrums.members[i], {alpha:0}, 1, {ease: FlxEase.smootherStepInOut});
		FlxTween.tween(cpuStrums.members[i], {x:-1000}, 4, {ease: FlxEase.smootherStepIn});
	}
}

function mid() {
	//middlescroll
	for (i in 0...4) {
    		FlxTween.tween(playerStrums.members[i], {x:425 + i * 105}, 1, {ease: FlxEase.quintOut});
	}
}

function qMid() {
	//middlescroll
	for (i in 0...4) {
    		FlxTween.tween(playerStrums.members[i], {x:425 + i * 105}, 0.1, {ease: FlxEase.quintOut});
    		FlxTween.tween(cpuStrums.members[i], {alpha:0}, 0.1, {ease: FlxEase.smootherStepInOut});
		FlxTween.tween(cpuStrums.members[i], {x:-1000}, 0.1, {ease: FlxEase.smootherStepIn});
	}
}

function part1cantbeat() {
	//shit function name, i know, but it's the one part where it speeds up and goes middlescroll
	for (i in beatuspart) i.visible = true;
	for (goob in goobersL) goob.animation.play('p1', true);
	for (goob in goobersR) goob.animation.play('p1', true);
}

function cantbeat(anim:String) {
	trace(anim);
	beatUsPart = true;
	for (i in beatuspart) i.visible = true;
	if (anim != "p1") {
		for (goob in goobersL) goob.x = -50;
		for (goob in goobersR) goob.x = 900;
	}
	for (goob in goobersL) goob.animation.play(anim, true);
	for (goob in goobersR) goob.animation.play(anim, true);
}

function cantbeatOver() {
	for (i in beatuspart) i.visible = false;

	for (i in 0...4) {
    		cpuStrums.members[i].x = 96 + i * 105;
		cpuStrums.members[i].alpha = 1;
    		playerStrums.members[i].x = 736 + i * 105;
		playerStrums.members[i].alpha = 1;
	}

	beatUsPart = false;
}

function part2trans1() {
	trace("part2!!! 'aim your zapper gun'!!");
	FlxTween.tween(dad, {alpha: 0},2, {ease: FlxEase.linear, type: FlxTween.ONESHOT});
	//transition into part 2!!!
}

function part2trans2() {
	//transition into part 2!!!
	camGame.bgColor = FlxColor.fromRGB(85,149,218,255);
	grass.alpha = 1;
	strumLines.members[0].characters[1].alpha = 0;
	strumLines.members[0].characters[1].y += 500;
	tree.alpha = 1;
	georgeW.alpha = 1;
	FlxTween.tween(bg, {alpha: 0}, 2, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
	FlxTween.tween(tree, {x: 200}, 2, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
	FlxTween.tween(georgeW, {x: 1000}, 2, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
	FlxTween.tween(strumLines.members[0].characters[1], {y: strumLines.members[0].characters[1].y - 500, alpha:1}, 3, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
}

function beatShoot(num:Int) {
	bt = num;
}
var random = false;
function shoot() {
	trace("shots fired!!!");
	shootTimer = 25;
	camGame.bgColor = FlxColor.fromString("0xf77d62");
	random = FlxMath.roundDecimal(FlxG.random.float(0, 2), 0);
	trace(random);
    	var duck = new FlxSprite(-500, FlxG.random.float(0, 300));
	if (random == 0) {
    		duck.frames = Paths.getSparrowAtlas('stages/beatus/duck0');
	}
	if (random == 1) {
    		duck.frames = Paths.getSparrowAtlas('stages/beatus/duck1');
	}
	if (random == 2) {
    		duck.frames = Paths.getSparrowAtlas('stages/beatus/duck2');
	}
	//----------------------------------------------------------
	//|/\/\/\ if anybody can optimize this please do so! /\/\/\|
	//----------------------------------------------------------
		

    	duck.animation.addByPrefix('right', "duck fly", 12, true);
    	duck.antialiasing = false;
	duck.setGraphicSize(Std.int(duck.width * 5));
    	duck.updateHitbox();
	if (FlxG.random.bool(50) == true) {
		duck.x = -1000;
		duck.velocity.x = FlxG.random.float(700, 1200);
	} else {
		duck.scale.x *= -1;
		duck.x = 2000;
		duck.velocity.x = FlxG.random.float(-1200, -700);
	}
	duck.velocity.y = FlxG.random.float(-100, 100);
	insert(members.indexOf(dad), duck);
	insert(members.indexOf(boyfriend), duck);
	insert(members.indexOf(gf), duck);
	duck.animation.play('right', true);
}

function lockFlash(which = 1) {
	trace(Std.string(which)); //I DONT FUCKING KNOW WHY IT WONT WORK AS AN INTEGER (if anybody knows, hit me up!!!!!!!!!)
	if (Std.string(which) == "0") {
		//remove
		cross.visible = false;
		camHUD.visible = true;
	}
	if (Std.string(which) == "1") {
		//white
		cross.color = FlxColor.WHITE;
		cross.visible = true;
		camHUD.visible = false;
	}
	if (Std.string(which) == "2") {
		//red
		cross.color = FlxColor.RED;
		cross.visible = true;
		camHUD.visible = false;
	}
}               
