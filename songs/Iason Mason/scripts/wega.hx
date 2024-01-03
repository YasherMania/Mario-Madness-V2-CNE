import flixel.addons.effects.FlxSkewedSprite;

var wega:FlxSprite = null;
var wegaLEFT:FlxSprite = null;
var wegaDOWN:FlxSprite = null;
var wegaUP:FlxSprite = null;
var wegaRIGHT:FlxSprite = null;

var tween:FlxTween;
var tween2:FlxTween;
var tween3:FlxTween;
var tween4:FlxTween;

var timer = 0;

var sclr = 0;
var spd = 0.025;

function create() {
	dad.scale.x = 0;
	dad.y -= 200;
	
    	wega = new FlxSkewedSprite(dad.x - 50, dad.y + 350).loadGraphic(Paths.image("wega/idle"), false);
    	wega.antialiasing = true;
	wega.scale.x = 0.8;
	wega.scale.y = 0.8;
    	wega.active = false;
	wega.origin.set(0, 0);
    	add(wega);
    	wegaLEFT = new FlxSkewedSprite(dad.x + 50, dad.y + 200).loadGraphic(Paths.image("wega/left"), false);
    	wegaLEFT.antialiasing = true;
	wegaLEFT.scale.x = 0.8;
	wegaLEFT.scale.y = 0.8;
    	wegaLEFT.active = false;
    	add(wegaLEFT);
    	wegaDOWN = new FlxSkewedSprite(dad.x + 50, dad.y + 200).loadGraphic(Paths.image("wega/down"), false);
    	wegaDOWN.antialiasing = true;
	wegaDOWN.scale.x = 0.8;
	wegaDOWN.scale.y = 0.8;
    	wegaDOWN.active = false;
    	add(wegaDOWN);
    	wegaUP = new FlxSkewedSprite(dad.x + 50, dad.y + 200).loadGraphic(Paths.image("wega/up"), false);
    	wegaUP.antialiasing = true;
	wegaUP.scale.x = 0.8;
	wegaUP.scale.y = 0.8;
    	wegaUP.active = false;
    	add(wegaUP);
    	wegaRIGHT = new FlxSkewedSprite(dad.x + 50, dad.y + 200).loadGraphic(Paths.image("wega/right"), false);
    	wegaRIGHT.antialiasing = true;
	wegaRIGHT.scale.x = 0.8;
	wegaRIGHT.scale.y = 0.8;
    	wegaRIGHT.active = false;
    	add(wegaRIGHT);
	idle();
	tween2 = FlxTween.tween(wega, {angle:0}, 0.35, {ease:FlxEase.backOut});
	tween2.cancel();
	tween3 = FlxTween.tween(wega, {angle:0}, 0.35, {ease:FlxEase.backOut});
	tween3.cancel();
	tween4 = FlxTween.tween(wega, {angle:0}, 0.35, {ease:FlxEase.backOut});
	tween4.cancel();
}

function update(elapsed) {
	wegaLEFT.x = wega.x - 125;
	wegaLEFT.y = wega.y - 100;
	wegaLEFT.scale.x = wega.scale.x;
	wegaLEFT.scale.y = wega.scale.y;
	wegaLEFT.angle = wega.angle;
	wegaLEFT.skew.x = wega.skew.x;

	wegaDOWN.x = wega.x - 125;
	wegaDOWN.y = wega.y - 100;
	wegaDOWN.scale.x = wega.scale.x;
	wegaDOWN.scale.y = wega.scale.y;
	wegaDOWN.angle = wega.angle;
	wegaDOWN.skew.x = wega.skew.x;

	wegaUP.x = wega.x - 125;
	wegaUP.y = wega.y - 100;
	wegaUP.scale.x = wega.scale.x;
	wegaUP.scale.y = wega.scale.y;
	wegaUP.angle = wega.angle;
	wegaUP.skew.x = wega.skew.x;

	wegaRIGHT.x = wega.x - 125;
	wegaRIGHT.y = wega.y - 100;
	wegaRIGHT.scale.x = wega.scale.x;
	wegaRIGHT.scale.y = wega.scale.y;
	wegaRIGHT.angle = wega.angle;
	wegaRIGHT.skew.x = wega.skew.x;

	if (timer == 0) {
		idle();
	} else {
		//wega.scale.y = 0.8;
	}

	if (timer > 0) {
		timer -= 1;
	}
}

function onDadHit(event) {
	if (event.direction == 0) {
		left();
		tween2.cancel();
		tween3.cancel();
		tween4.cancel();
		wega.x = dad.x - 150;
		wega.y = dad.y + 350;
		wega.scale.x = wega.scale.y = 0.8;
		wega.angle = 0;
		wega.skew.x = 20;
		tween2 = FlxTween.tween(wega, {x:dad.x - 50}, 0.15, {ease:FlxEase.quadOut});
		tween3 = FlxTween.tween(wega.skew, {x:0}, 0.15, {ease:FlxEase.quadOut});
	}
	if (event.direction == 1) {
		down();
		tween2.cancel();
		tween3.cancel();
		tween4.cancel();
		wega.x = dad.x - 50;
		wega.y = dad.y + 375;
		wega.scale.x = 1.0;
		wega.scale.y = 0.6;
		wega.angle = 0;
		wega.skew.x = 0;
		tween2 = FlxTween.tween(wega, {y:dad.y + 350, angle:0}, 0.15, {ease:FlxEase.quadOut});
		tween4 = FlxTween.tween(wega.scale, {x:0.8, y:0.8}, 0.15, {ease:FlxEase.quadOut});
	}
	if (event.direction == 2) {
		up();
		tween2.cancel();
		tween3.cancel();
		tween4.cancel();
		wega.x = dad.x - 50;
		wega.y = dad.y + 300;
		wega.scale.x = 0.6;
		wega.scale.y = 1.0;
		wega.angle = 0;
		wega.skew.x = 0;
		tween2 = FlxTween.tween(wega, {y:dad.y + 350, angle:0}, 0.15, {ease:FlxEase.quadOut});
		tween4 = FlxTween.tween(wega.scale, {x:0.8, y:0.8}, 0.15, {ease:FlxEase.quadOut});

	}
	if (event.direction == 3) {
		right();
		tween2.cancel();
		tween3.cancel();
		tween4.cancel();
		wega.x = dad.x + 50;
		wega.y = dad.y + 350;
		wega.scale.x = wega.scale.y = 0.8;
		wega.angle = 0;
		wega.skew.x = -20;
		tween2 = FlxTween.tween(wega, {x:dad.x - 50}, 0.15, {ease:FlxEase.quadOut});
		tween3 = FlxTween.tween(wega.skew, {x:0}, 0.15, {ease:FlxEase.quadOut});
	}
	timer = 100;
}

function idle() {
	wega.alpha = 1;
	wegaLEFT.alpha = wegaDOWN.alpha = wegaUP.alpha = wegaRIGHT.alpha = 0;
}

function left() {
	wegaLEFT.alpha = 1;
	wega.alpha = wegaDOWN.alpha = wegaUP.alpha = wegaRIGHT.alpha = 0;
}

function down() {
	wegaDOWN.alpha = 1;
	wega.alpha = wegaLEFT.alpha = wegaUP.alpha = wegaRIGHT.alpha = 0;
}

function up() {
	wegaUP.alpha = 1;
	wega.alpha = wegaLEFT.alpha = wegaDOWN.alpha = wegaRIGHT.alpha = 0;
}

function right() {
	wegaRIGHT.alpha = 1;
	wega.alpha = wegaLEFT.alpha = wegaDOWN.alpha = wegaUP.alpha = 0;
}