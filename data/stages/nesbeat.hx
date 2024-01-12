import openfl.Lib;
import flixel.group.FlxGroup;
import funkin.editors.EditorTreeMenu;
import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideo;
var curVideo:Video;

public var isUnbeatable = true;

var blackBarThingie:FlxSprite;
var shader:CustomShader = null;
var shader2:CustomShader = null;
var time:Float=0;

var goobersL:FlxGroup;
var goobersR:FlxGroup;
var beatuspart:FlxGroup;

var rob:FlxSprite;
var lakitu:FlxSprite;

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

var whiteThingie:FlxSprite;
var firstTxt:FlxText;
var secondTxt:FlxText;
var thirdTxt:FlxText;
var size = 150;
var timer = 50;

var dog;
var bowz;

var dogTalk = false;
var bowzTalk = false;
var robTalk = false;
var lakTalk = false;
var curAnim = "p1";

//modchart vars
var freeze = false;
var swapped = false;
var tarVel = 500;
var ySpd = 500;
var icon1:HealthIcon = iconP1;
var icon2:HealthIcon = iconP1;
var icon3:HealthIcon = iconP1;

var noteNum = 0;
var noteRotL:FlxGroup;
var noteRotR:FlxGroup;

// hello!!! its me, bromaster!!! i know this code is a little messy, but uhhh, it works!!
function onNoteCreation(e) {
	noteNum += 1;
	var n = e.note;
	if (n.isSustainNote) {
		if (noteNum % 2 == 0) {
			noteRotL.add(n);
			n.angle = 5;
		}
		if (noteNum % 2 != 0) {
			noteRotR.add(n);
			n.angle = -5;
		}
	}
}

function create() {
    	noteRotL = new FlxGroup(50000);
    	noteRotR = new FlxGroup(50000);
	shader2 = new CustomShader("WiggleShader");
	//Video.initInstance();
	trace("video inited!");

        curVideo = new FlxVideo();
        curVideo.onEndReached.add(curVideo.dispose);
        var path = Paths.file("videos/hutcherson.mp4");
	curVideo.load(Assets.getPath(path));

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
	strumLines.members[0].characters[2].alpha = 0;
	tree.x = -200;
	georgeW.x = 1400;
	grass.alpha = 0;

        blackBarThingie = new FlxSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
        blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width + 100));
        blackBarThingie.scrollFactor.set(0, 0);
        blackBarThingie.screenCenter();
        add(blackBarThingie);

    	light1 = new FlxSprite(-25, -200);
    	light1.frames = Paths.getSparrowAtlas('stages/beatus/ycbu_lightning');
    	light1.animation.addByPrefix('uh', "lightning", 24, true);
    	light1.antialiasing = true;
	light1.setGraphicSize(Std.int(light1.width * 1.2));
    	light1.updateHitbox();
    	add(light1);
	light1.animation.play('uh', true);
	light1.visible = false;
		//i know there might be a better way to do this but uhhh not right now
    	light2 = new FlxSprite(900, -200);
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
    		goob.animation.addByPrefix('p2', "Bird Up", 24, false);
    		goob.animation.addByPrefix('p3', "Lakitu", 24, false);
    		goob.antialiasing = true;
		goob.setGraphicSize(Std.int(goob.width * 0.5));
    		goob.updateHitbox();
    		add(goob);
		goobersL.add(goob);
		goob.animation.play('p1', true);
	}

    	goobersR = new FlxGroup(500);

	for (i in 0...3) {
    		var goob = new FlxSprite(850, i * 500);
    		goob.frames = Paths.getSparrowAtlas('stages/beatus/YouCannotBeatUS_Fellas_Assets');
    		goob.animation.addByPrefix('p1', "Rotat e", 24, true);
    		goob.animation.addByPrefix('p2', "Bird Up", 24, false);
    		goob.animation.addByPrefix('p3', "Lakitu", 24, false);
    		goob.antialiasing = true;
		goob.setGraphicSize(Std.int(goob.width * 0.5));
    		goob.updateHitbox();
    		add(goob);
		goobersR.add(goob);
		goob.animation.play('p1', true);
	}

        //shader = new CustomShader("crt");
	//shader.anaglyphIntensity = 0.3;
	//shader.whiteIntensity = 0.7;

	shader = new CustomShader("CRTShader");
	shader.res = [256.0 / 0.5, 224.0 / 0.5];
	shader.sHardScan = -8.0;
	shader.kHardPix = -2.0;
	shader.kWarp = [80.0, 80.0]; // THE WARP ON THE EDGES OF SCREEN
	shader.kMaskDark = 2.0;
	shader.kMaskLight = 1.5;
        camGame.addShader(shader);

	boyfriend.x = dad.x - 100;
	gf.x = 300;

    	beatuspart = new FlxGroup(500);
	beatuspart.add(light1);
	beatuspart.add(light2);
	for (i in goobersL) beatuspart.add(i);
	for (i in goobersR) beatuspart.add(i);
	for (i in beatuspart) i.visible = false;

        whiteThingy = new FlxSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.WHITE);
        whiteThingy.setGraphicSize(Std.int(blackBarThingie.width + 100));
        whiteThingy.scrollFactor.set(0, 0);
        whiteThingy.screenCenter();
	whiteThingy.camera = camGame;
	whiteThingy.alpha = 0;
        add(whiteThingy);

	firstTxt = new FlxText(0, 250, 2000, "", 32);
	firstTxt.setFormat(Paths.font("Retro_Gaming.ttf"), size, FlxColor.BLACK, "center");
	firstTxt.screenCenter();
	firstTxt.y -= size;
	firstTxt.scrollFactor.set();
	firstTxt.camera = camGame;
	add(firstTxt);
	secondTxt = new FlxText(0, 250, 2000, "", 32);
	secondTxt.setFormat(Paths.font("Retro Gaming.ttf"), size, FlxColor.BLACK, "center");
	secondTxt.screenCenter();
	secondTxt.scrollFactor.set();
	secondTxt.camera = camGame;
	add(secondTxt);
	thirdTxt = new FlxText(0, 250, 2000, "", 32);
	thirdTxt.setFormat(Paths.font("Retro Gaming.ttf"), size, FlxColor.BLACK, "center");
	thirdTxt.screenCenter();
	thirdTxt.scrollFactor.set();
	thirdTxt.y += size;
	thirdTxt.camera = camGame;
	add(thirdTxt);

	dog = new Character(dad.x, dad.y, "DHD");
	dog.scale.x = dog.scale.y = dad.scale.x;
	dog.alpha = 0;
	add(dog);
	bowz = new Character(dad.x, dad.y, "bowser");
	bowz.scale.x = bowz.scale.y = dad.scale.x;
	bowz.alpha = 0;
	add(bowz);


    	rob = new FlxSprite(-800, 500);
    	rob.frames = Paths.getSparrowAtlas('stages/beatus/YouCannotBeatUS_Fellas_Assets');
    	rob.animation.addByPrefix('1', "Bird Up", 24, false);
    	rob.antialiasing = true;
	rob.setGraphicSize(Std.int(rob.width));
    	rob.updateHitbox();
    	add(rob);
	rob.animation.play('1', true);

    	lakitu = new FlxSprite(1400, 500);
    	lakitu.frames = Paths.getSparrowAtlas('stages/beatus/YouCannotBeatUS_Fellas_Assets');
    	lakitu.animation.addByPrefix('1', "Lakitu", 24, false);
    	lakitu.antialiasing = true;
	lakitu.setGraphicSize(Std.int(lakitu.width));
    	lakitu.updateHitbox();
    	add(lakitu);
	lakitu.animation.play('1', true);

	strumLines.members[2].characters[1].y = 500;
	strumLines.members[2].characters[1].alpha = 0;

}
var savedEvents = [];
function postCreate(){
        //camHUD.alpha=0;
	savedEvents = events.copy();
        icon1 = new HealthIcon(strumLines.members[0].characters[0].getIcon(), false);
        icon1.cameras = [camHUD];
        icon1.y = healthBar.y - (icon1.height / 2);
        add(icon1);
        icon2 = new HealthIcon(strumLines.members[0].characters[1].getIcon(), false);
        icon2.cameras = [camHUD];
        icon2.y = healthBar.y - (icon2.height / 2);
        add(icon2);
        icon3 = new HealthIcon(strumLines.members[0].characters[2].getIcon(), false);
        icon3.cameras = [camHUD];
        icon3.y = healthBar.y - (icon3.height / 2);
        add(icon3);

	shader2.uSpeed = 0.1;
	shader2.uFrequency = 5;
	shader2.uWaveAmplitude = 0.05;
}
var dummyvar = 0;
var angg = 0;
function postUpdate(elapsed:Float) {
    	switch(curCameraTarget) {
        	case 0:
                	dad.visible = true;
                	boyfriend.visible = false;
                	gf.visible = false;
			strumLines.members[0].characters[1].visible = true;
			strumLines.members[0].characters[2].visible = true;
			strumLines.members[2].characters[1].visible = true;
			bowz.visible = true;
			dog.visible = true;
			lakitu.visible = true;
			rob.visible = true;
                    
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
			strumLines.members[0].characters[2].visible = false;
			strumLines.members[2].characters[1].visible = false;
			bowz.visible = false;
			dog.visible = false;
			lakitu.visible = false;
			rob.visible = false;
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
		if (goob.y > 1000) {
			goob.y = -500;
		}
	}
	for (goob in goobersR) {
		if (goob.y < -500) {
			goob.y = 1000;
		}
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
	iconP2.alpha = 0;
	icon1.x = iconP2.x;
	icon1.y = iconP1.y;
	icon1.scale.x = iconP2.scale.x;
	icon1.scale.y = iconP2.scale.y;

	icon1.alpha = strumLines.members[0].characters[0].alpha;
	if (strumLines.members[0].characters[0].alpha > 0.1) {
		icon2.x = iconP2.x - 50;
		icon2.y = iconP1.y;
		icon2.scale.x = iconP2.scale.x / 1.5;
		icon2.scale.y = iconP2.scale.y / 1.5;
		icon3.x = iconP2.x - 100;
		icon3.y = iconP1.y;
		icon3.scale.x = iconP2.scale.x / 2;
		icon3.scale.y = iconP2.scale.y / 2;
	} else {
		icon2.x = iconP2.x;
		icon2.y = iconP1.y;
		icon2.scale.x = iconP2.scale.x;
		icon2.scale.y = iconP2.scale.y;
		icon3.x = iconP2.x;
		icon3.y = iconP1.y;
		icon3.scale.x = iconP2.scale.x;
		icon3.scale.y = iconP2.scale.y;
	}
	icon2.alpha = strumLines.members[0].characters[1].alpha;
	icon3.alpha = strumLines.members[0].characters[2].alpha + strumLines.members[2].characters[1].alpha;
	time += 0.5;
	shader2.uTime = time;
}

function beatHit(curBeat)
{
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
		if (Std.string(bt) == "8") {} else shoot(); //dunno man
	}
	if (curBeat > 796) {
		camGame.bgColor = FlxColor.BLACK;
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


function gameOver() {
    health = 0.1;
    inst.time = 0;
    inst.volume = 0;
    isGameOver = true;
    trace("uh oh you died!!");
        curVideo.play();
        trace("video played!");
        if (curVideo == null) trace("video did not play! did you check if the video name is spelled correctly?");
}

function update(elapsed:Float){
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

	for (goob in goobersL) goob.y -= (ySpd / 250);
	for (goob in goobersR) goob.y += ySpd / 250;
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
	castle.alpha = 0;
	castle2.alpha = 0;
	lava.alpha = 0;
	plat.alpha = 0;
	staticbg1.alpha = 0;
	staticbg2.alpha = 0;
	staticc.alpha = 0;
	cross.alpha = 0;
	camGame.bgColor = FlxColor.BLACK;
	bt = 8;
	resyncVocals();
	for (s in strumLines) s.generate(s.data, null);
	events = savedEvents.copy();
	cantbeatOver();
}

function fadeOpp() {
	//face opponent notes out (for function 'mid()')
	for (i in 0...4) {
    		FlxTween.tween(cpuStrums.members[i], {alpha:0}, 1, {ease: FlxEase.smootherStepInOut});
		FlxTween.tween(cpuStrums.members[i], {x:-1000}, 1, {ease: FlxEase.smootherStepIn});
	}
}

function mid() {
	//middlescroll
	for (i in 0...4) {
    		FlxTween.tween(playerStrums.members[i], {x:425 + i * 105}, 1, {ease: FlxEase.quintInOut});
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
	curAnim = anim;
	beatUsPart = true;
	for (i in beatuspart) i.visible = true;
	if (anim != "p1") {
		for (goob in goobersL) goob.x = -50;
		for (goob in goobersR) goob.x = 900;
	}
	if (anim == "p1") {
		for (goob in goobersL) goob.x = -100;
		for (goob in goobersR) goob.x = 850;
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

function cantbeatOver2() {
	for (i in beatuspart) i.visible = false;

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

function part3trans1() {
	FlxTween.tween(tree, {y: tree.y + 1200}, 4, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
	FlxTween.tween(georgeW, {y: georgeW.y + 1200}, 4, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
	FlxTween.tween(grass, {y: grass.y + 1200}, 4, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
	FlxTween.tween(strumLines.members[0].characters[1], {alpha:0}, 2, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
	castle2.alpha = 1;
	FlxTween.tween(castle2, {y: 0}, 8, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
	castle.alpha = 1;
	FlxTween.tween(castle, {y: 250}, 4, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});

}
function part3trans2() {
	camHUD.flash(FlxColor.WHITE, 0.5);
	camGame.bgColor = FlxColor.BLACK;
	strumLines.members[0].characters[2].y = 500;
	FlxTween.tween(strumLines.members[0].characters[2], {y: 0, alpha:1}, 2, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
	plat.alpha = 1;
	FlxTween.tween(plat, {x: 800}, 4, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
	lava.alpha = 1;
	FlxTween.tween(lava, {y: 800}, 3, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
}

function back2p1() {
	bg.color = FlxColor.GRAY;
	strumLines.members[0].characters[0].alpha = 0;
	strumLines.members[0].characters[1].alpha = 0;
	strumLines.members[0].characters[2].alpha = 0;
	FlxTween.tween(bg, {alpha:1}, 2, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
	FlxTween.tween(staticbg1, {alpha:0}, 2, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
	FlxTween.tween(staticbg2, {alpha:0}, 2, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
	FlxTween.tween(staticc, {alpha:0}, 2, {ease: FlxEase.smootherStepInOut, type: FlxTween.ONESHOT});
}

function bfUnsolo() {
	bg.alpha = 0;
	grass.alpha = 0;
	tree.alpha = 0;
	georgeW.alpha = 0;
	castle.alpha = 0;
	castle2.alpha = 0;
	lava.alpha = 0;
	plat.alpha = 0;
	strumLines.members[0].characters[0].alpha = 0;
	strumLines.members[0].characters[1].alpha = 0;
	strumLines.members[0].characters[2].alpha = 0;
}

function robEnter() {
	rob.x = 1200;
	bowzTalk = false;
	dogTalk = false;
	robTalk = true;
	lakTalk = false;
	FlxTween.tween(rob, {x:700}, 0.7, {ease: FlxEase.smootherStepOut, type: FlxTween.ONESHOT});
	FlxTween.tween(rob, {y:300}, 0.7, {ease: FlxEase.smootherStepIn, type: FlxTween.ONESHOT});
}

function lakituEnter() {
	lakitu.x = -400;
	bowzTalk = false;
	dogTalk = false;
	robTalk = false;
	lakTalk = true;
	FlxTween.tween(lakitu, {x:0}, 0.7, {ease: FlxEase.smootherStepOut, type: FlxTween.ONESHOT});
	FlxTween.tween(lakitu, {y:300}, 0.7, {ease: FlxEase.smootherStepIn, type: FlxTween.ONESHOT});
}

function bowzEnter() {
	bowz.x = 300;
	bowz.y = 500;
	bowz.alpha = 1;
	strumLines.members[0].characters[2].alpha = 0;
	bowzTalk = true;
	dogTalk = false;
	FlxTween.tween(bowz, {y:0}, 0.7, {ease: FlxEase.backOut, type: FlxTween.ONESHOT});
}

function dogEnter() {
	dog.x = -300;
	dog.y = 500;
	dog.alpha = 1;
	bowzTalk = false;
	dogTalk = true;
	strumLines.members[0].characters[1].alpha = 0;
	FlxTween.tween(dog, {y:0}, 0.7, {ease: FlxEase.backOut, type: FlxTween.ONESHOT});
}

function updateYSPD(value:float) {
	ySpd = value;
}

function onDadHit(event) {
	if (dogTalk) dog.playSingAnim(event.direction);
	if (bowzTalk) bowz.playSingAnim(event.direction);
	if (event.note.strumLine == strumLines.members[3]) {
		if (robTalk) rob.animation.play('1', true);
		if (lakTalk) lakitu.animation.play('1', true);
		if (curAnim != "p1" ) {
			for (goob in goobersL) goob.animation.play(curAnim, true);
			for (goob in goobersR) goob.animation.play(curAnim, true);
		}
	}
	//THE HOLY MODCHART STRUM!!! (the one to the far right of the chart editor)
	if (event.note.strumLine == strumLines.members[4]) {
		if (event.note.strumID == 0) {
			freeze = !freeze;
			trace("freeze = " + freeze);
			if (freeze) tarVel = 0;
			if (!freeze) {
				tarVel = 500;
				ySpd = tarVel;
			}
		}
		if (event.note.strumID == 1) {
			tarVel *= -1;
			FlxTween.num(-3000, tarVel, 0.2, {ease:FlxEase.smootherStepOut}, updateYSPD);
		}
		if (event.note.strumID == 2) {
			tarVel *= -1;
			FlxTween.num(3000, tarVel, 0.2, {ease:FlxEase.smootherStepOut}, updateYSPD);
		}
		if (event.note.strumID == 3) {
			swapped = !swapped;
			trace("swapped = " + swapped);
			if (curAnim == "p1") {
			if (swapped) {
			for (goob in goobersL) FlxTween.tween(goob,{x:850},0.2,{ease:FlxEase.smootherStepOut});
			for (goob in goobersR) FlxTween.tween(goob,{x:-100},0.2,{ease:FlxEase.smootherStepOut});
			FlxTween.tween(light1,{x:900},0.2,{ease:FlxEase.smootherStepOut});
			FlxTween.tween(light2,{x:-25},0.2,{ease:FlxEase.smootherStepOut});
			} else {
			for (goob in goobersL) FlxTween.tween(goob,{x:-100},0.2,{ease:FlxEase.smootherStepOut});
			for (goob in goobersR) FlxTween.tween(goob,{x:850},0.2,{ease:FlxEase.smootherStepOut});
			FlxTween.tween(light1,{x:-25},0.2,{ease:FlxEase.smootherStepOut});
			FlxTween.tween(light2,{x:900},0.2,{ease:FlxEase.smootherStepOut});
			}
			} else {
			if (swapped) {
			for (goob in goobersL) FlxTween.tween(goob,{x:900},0.2,{ease:FlxEase.smootherStepOut});
			for (goob in goobersR) FlxTween.tween(goob,{x:-50},0.2,{ease:FlxEase.smootherStepOut});
			FlxTween.tween(light1,{x:900},0.2,{ease:FlxEase.smootherStepOut});
			FlxTween.tween(light2,{x:-25},0.2,{ease:FlxEase.smootherStepOut});
			} else {
			for (goob in goobersL) FlxTween.tween(goob,{x:-50},0.2,{ease:FlxEase.smootherStepOut});
			for (goob in goobersR) FlxTween.tween(goob,{x:900},0.2,{ease:FlxEase.smootherStepOut});
			FlxTween.tween(light1,{x:-25},0.2,{ease:FlxEase.smootherStepOut});
			FlxTween.tween(light2,{x:900},0.2,{ease:FlxEase.smootherStepOut});
			}
			}
		}
	}
}

function whiteScreen(what) {
	whiteThingy.alpha = 1;
	if (what == "true") {
		strumLines.members[0].characters[0].alpha = 1;
		strumLines.members[0].characters[1].alpha = 0;
		strumLines.members[0].characters[2].alpha = 0;
		rob.alpha = 0;
		lakitu.alpha = 0;
		dog.alpha = 0;
		bowz.alpha = 0;
	}
}
function unwhite() {
	whiteThingy.alpha = 0;
	strumLines.members[0].characters[0].alpha = 1;
	strumLines.members[0].characters[1].alpha = 0;
	strumLines.members[0].characters[2].alpha = 0;
	strumLines.members[2].characters[1].alpha = 0;
	strumLines.members[0].characters[0].x = 0;
	lakitu.alpha = 0;
	rob.alpha = 0;
	dog.alpha = 0;
	bowz.alpha = 0;
	staticbg1.alpha = 0;
	staticbg2.alpha = 0;
	staticc.alpha = 0;
	bg.alpha = 1;
	firstTxt.text = "";
	secondTxt.text = "";
	thirdTxt.text = "";
}

function untext() {
	firstTxt.text = "";
	secondTxt.text = "";
	thirdTxt.text = "";
}

function hudTxt(f:String, s:String, t:String) {
	firstTxt.text = f;
	secondTxt.text = s;
	thirdTxt.text = t;
	secondTxt.y = 250 - size/2;
	thirdTxt.y = 250 + size/2;
}

function dogPart4() {
	bg.color = FlxColor.WHITE;
	strumLines.members[0].characters[1].x = 0;
	strumLines.members[0].characters[2].x = 0;
	strumLines.members[0].characters[0].alpha = 0;
	strumLines.members[0].characters[1].alpha = 1;
	strumLines.members[0].characters[2].alpha = 0;
	staticbg1.alpha = 1;
	staticc.alpha = 1;
}
function bowPart4() {
	lakitu.alpha = 0;
	strumLines.members[0].characters[1].x = 0;
	strumLines.members[0].characters[2].x = 0;
	strumLines.members[0].characters[0].alpha = 0;
	strumLines.members[0].characters[1].alpha = 0;
	strumLines.members[0].characters[2].alpha = 1;
	staticbg1.alpha = 1;
	staticbg2.alpha = 1;
	staticc.alpha = 1;
}
function mrsysreEnter() {
	FlxTween.tween(strumLines.members[0].characters[1], {x:-400}, 0.7, {ease: FlxEase.backOut, type: FlxTween.ONESHOT});
	strumLines.members[0].characters[0].y = 500;
	strumLines.members[0].characters[0].alpha = 1;
	FlxTween.tween(strumLines.members[0].characters[0], {y:0}, 0.7, {ease: FlxEase.backOut, type: FlxTween.ONESHOT});
}

function bowzEnter2() {
	strumLines.members[2].characters[1].y = 500;
	strumLines.members[2].characters[1].alpha = 1;
	FlxTween.tween(strumLines.members[2].characters[1], {y:0}, 0.7, {ease: FlxEase.backOut, type: FlxTween.ONESHOT});
}

function bowzEnter() {
	bowz.x = 300;
	bowz.y = 500;
	bowz.alpha = 1;
	strumLines.members[0].characters[2].alpha = 0;
	bowzTalk = true;
	dogTalk = false;
	FlxTween.tween(bowz, {y:0}, 0.7, {ease: FlxEase.backOut, type: FlxTween.ONESHOT});
}

function dogEnter2() {
	dog.x = 0;
	dog.y = 500;
	dog.alpha = 1;
	bowzTalk = false;
	dogTalk = true;
	FlxTween.tween(dog, {y:0}, 0.7, {ease: FlxEase.backOut, type: FlxTween.ONESHOT});
}

function robEnter2() {
	rob.y = 500;
	rob.alpha = 1;
	bowzTalk = false;
	dogTalk = false;
	FlxTween.tween(rob, {y:300}, 0.7, {ease: FlxEase.backOut, type: FlxTween.ONESHOT});
}

function lakituEnter2() {
	lakitu.y = 500;
	lakitu.alpha = 1;
	bowzTalk = false;
	dogTalk = false;
	FlxTween.tween(lakitu, {y:300}, 0.7, {ease: FlxEase.backOut, type: FlxTween.ONESHOT});
}

//"SCORE ONE MILLION!!"
function ONEMILLION() {
	trace("SCORE ONE MILLION!");
	FlxTween.num(0, 1000000, 0.75, {ease:FlxEase.cubeOut}, updateValue);
}

function updateValue(value:Float) {
	thirdTxt.text = Std.string(Std.int(value));
}

function bowzEnter2() {
	strumLines.members[2].characters[1].x = 400;
	strumLines.members[2].characters[1].y = 500;
	strumLines.members[2].characters[1].alpha = 1;
	FlxTween.tween(strumLines.members[2].characters[1], {y:0}, 0.7, {ease: FlxEase.backOut, type: FlxTween.ONESHOT});
}

function bowzEnter3() {
	bowz.x = 0;
	bowz.y = 500;
	bowz.alpha = 1;
	strumLines.members[0].characters[2].alpha = 0;
	bowzTalk = true;
	dogTalk = false;
	FlxTween.tween(bowz, {y:0}, 0.7, {ease: FlxEase.backOut, type: FlxTween.ONESHOT});
}

function lakituGone() {
	lakitu.alpha = 0;
}

//THE LAST FUNCTION!!!!!
//WOOHOO!!!!!!!!!!!!!!!!!!!
//IM SO FUCKING TIRED
//- bromaster

function WEARENINTENDO() {
	whiteThingy.alpha = 0;
	strumLines.members[0].characters[0].alpha = 1;
	strumLines.members[0].characters[1].alpha = 0;
	strumLines.members[0].characters[2].alpha = 0;
	strumLines.members[2].characters[1].alpha = 0;
	bowz.alpha = 1;
	bowz.x = 500;
	bowz.y = 0;
	dog.alpha = 1;
	dog.x = -500;
	dog.y = 0;
	strumLines.members[0].characters[0].x = 0;
	lakitu.alpha = 1;
	rob.alpha = 1;
	staticbg1.alpha = 0;
	staticbg2.alpha = 0;
	staticc.alpha = 0;
	bg.alpha = 0;
	firstTxt.text = "";
	secondTxt.text = "";
	thirdTxt.text = "";
	bowzTalk = false;
	dogTalk = false;
}

function YOUCANNOTBEATUS() {
	bowzTalk = true;
	dogTalk = true;
	lakTalk = true;
	robTalk = true;
	lakitu.animation.play('1', true);
	rob.animation.play('1', true);
}