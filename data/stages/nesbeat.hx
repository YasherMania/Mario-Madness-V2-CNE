import openfl.Lib;
var blackBarThingie:FlxSprite;
var shader:CustomShader = null;
var time:Float=0;

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

        shader = new CustomShader("crt");
	shader.anaglyphIntensity = 0.3;
	shader.whiteIntensity = 0.7;
        camGame.addShader(shader);
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
}

function part2trans() {
	trace("part2!!! 'aim your zapper gun'!!");
	//transition into part 2!!!
}
