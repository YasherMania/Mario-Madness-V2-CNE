import openfl.Lib;

var shader:CustomShader = null;
var shader2:CustomShader = null;
import hxvlc.flixel.FlxVideo;
import flixel.util.FlxTimer;
var tween:FlxTween;
var sclr = 0;
var spd = 0.075;
var jump:FlxSprite;
function create() {
        Lib.application.window.title="Friday Night Funkin': Mario's Madness | Iason Mason | KennyL ft GP, VanScotch, Scrubb & Dewott GAMERRR";
	shader = new CustomShader("hueshift");
	shader.uHsv = [0.5, 0, 0];
	shader2 = new CustomShader("hueshift");
	shader2.uHsv = [0.6, 0, 0];
	bg.shader = shader2;
	dad.shader = shader;
	boyfriend.shader = shader2;
	camHUD.addShader(shader);

    	jump = new FlxSprite(350, 0).loadGraphic(Paths.image("wega/down"), false);
	jump.scrollFactor.set(0, 0);
	jump.scale.x = 3;
	jump.camera = camHUD;
	jump.shader = shader;
    	add(jump);

	jump.scale.x = jump.scale.y = 0;
	tween = FlxTween.tween(jump.scale, {x: 0}, 0.3, {ease: FlxEase.linear, type: FlxTween.ONESHOT});
}

function scare() {
	trace("ahh! jumpscare!!");
	jump.alpha = 1;
	jump.scale.x = 3.2;
}

function update(elapsed) {

	if (jump.scale.x > 0) {
		jump.scale.x = jump.scale.x / 1.008;
	}
	jump.alpha = (jump.scale.x) / 2;
	jump.scale.y = jump.scale.x / 3;
	jump.x = jump.scale.x * 100 + 200;
	if (health > 0.1) {
		health -= jump.alpha / 600;
	}
	camGame.x = jump.alpha * FlxG.random.int(25, 50);
	camGame.y = jump.alpha * FlxG.random.int(25, 50);
	camHUD.x = jump.alpha * FlxG.random.int(25, 50);
	camHUD.y = jump.alpha * FlxG.random.int(25, 50);
}
