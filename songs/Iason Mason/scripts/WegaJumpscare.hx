var tween:FlxTween;
var sclr = 0;
var spd = 0.075;
var jump:FlxSprite;
var shader:CustomShader = null;
var theBeat = 0;
var scaleFactor = 1.8;
function create() {
	shader = new CustomShader("hueshift");
	shader.uHsv = [0.5, 0, 0];
    	jump = new FlxSprite(350, 0).loadGraphic(Paths.image("wega/down"), false);
	jump.scrollFactor.set(0, 0);
	jump.scale.x = 3;
	jump.alpha = 0;
	jump.camera = camHUD;
	jump.shader = shader;
    	insert(members.indexOf(boyfriend), jump); //there's prob a better insert for this but it works!! :3c

	jump.scale.x = jump.scale.y = 0;
	tween = FlxTween.tween(jump.scale, {x: 0}, 0.1, {ease: FlxEase.linear, type: FlxTween.ONESHOT});
}

function beatHit(curBeat)
	theBeat = curBeat;


function scare(length:float) {
	if (length == "") {
		if (theBeat > 194 && theBeat < 218) {length = 0.2;} else {length = 0.6;}
	}
	tween.cancel();
	trace("ahh! jumpscare!! its length is " + length);
	jump.alpha = 1;
	jump.scale.x = 3.2;
	jump.scale.y = 1.5;
	tween = FlxTween.tween(jump.scale, {x: 3.2/scaleFactor, y: 1.5/scaleFactor}, length, {ease: FlxEase.cubicIn, type: FlxTween.ONESHOT});
}

function update(elapsed) {
	jump.alpha = (jump.scale.y - (1.5/scaleFactor)) / 0.3;
	jump.x = jump.scale.x * 100 + 200;
	if (health > 0.1) {
		health -= jump.alpha / 600;
	}
	camGame.x = jump.alpha * FlxG.random.int(-25, 25);
	camGame.y = jump.alpha * FlxG.random.int(-25, 25);
	camHUD.x = jump.alpha * FlxG.random.int(-25, 25);
	camHUD.y = jump.alpha * FlxG.random.int(-25, 25);
}