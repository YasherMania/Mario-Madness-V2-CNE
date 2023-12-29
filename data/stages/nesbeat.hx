import openfl.Lib;
import flixel.group.FlxGroup;
var blackBarThingie:FlxSprite;
var shader:CustomShader = null;
var time:Float=0;

var goobersL:FlxGroup;
var goobersR:FlxGroup;
var beatuspart:FlxGroup;

var light1:FlxSprite;
var light2:FlxSprite;

function onCountdown(event:CountdownEvent) event.cancelled = true;

// i will reorganize this code later - apurples
function create() {
        dad.alpha = 0;
        Lib.application.window.title="Friday Night Funkin': Mario's Madness | Unbeatable | RedTV53 ft. theWAHbox, scrumbo_, FriedFrick & Ironik";
        bg.screenCenter();
	bg.alpha = 0;
        bg.antialiasing = true;
        add(bg);
        FlxTween.tween(bg, {angle: 360}, 40, {ease: FlxEase.smootherStepInOut, type: FlxTween.PINGPONG});

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
    	var light2 = new FlxSprite(850, -200);
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
    		var goob = new FlxSprite(800, i * 500);
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

function postCreate(){
        camHUD.alpha=0;
}
function update(elapsed:Float){
	time += 100;
	shader.time = time;
}
var dummyvar = 0;
function postUpdate(elapsed:Float) {
    	switch(curCameraTarget) {
        	case 0:
                	dad.visible = true;
                	boyfriend.visible = false;
                	gf.visible = false;
                    
                	if (dummyvar != -1) {
		 	       blackBarThingie.alpha = 0.3;
                        	FlxTween.tween(blackBarThingie, {alpha: 0},1, {ease: FlxEase.linear, type: FlxTween.ONESHOT});    
            	        	dummyvar = -1;
                	}

                	alreadychange = false;
        	case 1:
                	dad.visible = false;
                	boyfriend.alpha = 1;
                	boyfriend.visible = true;
                	gf.visible = true;
                	gf.alpha = 1;      
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
}

function beatHit(curBeat)
{
	if (curBeat == 0) FlxTween.tween(bg, {alpha: 0.8}, 16, {ease: FlxEase.linear, type: FlxTween.ONESHOT});
}
function stepHit(curStep){
        switch(curStep){
                case 109:FlxTween.tween(camHUD,{alpha:1},2.5,{ease:FlxEase.smootherStepInOut});
        }
}

function START() dad.alpha = 1;

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

function return() {
	//after the middlescroll sections
	for (i in 0...4) {
    		cpuStrums.members[i].x = 96 + i * 105;
		cpuStrums.members[i].alpha = 1;
    		playerStrums.members[i].x = 736 + i * 105;
		playerStrums.members[i].alpha = 1;
	}
}

function part1cantbeat() {
	//shit function name, i know, but it's the one part where it speeds up and goes middlescroll
	for (i in beatuspart) i.visible = true;
	for (goob in goobersL) goob.animation.play('p1', true);
	for (goob in goobersR) goob.animation.play('p1', true);
}

function part2trans() {
	trace("part2!!! 'aim your zapper gun'!!");
	//transition into part 2!!!
}
