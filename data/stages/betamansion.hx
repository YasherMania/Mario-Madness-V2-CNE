var peppino:FlxSound;
public var cameraMovementStrength = 40;
public var cameraMovementEnabled = true;
var timer = 0;
var tarX = 0;
var tarY = 0;

function postCreate() {
	peppino = FlxG.sound.play(Paths.sound("peppino that is my name"), 1);
	peppino.volume = 0;
	strumLines.members[3].characters[0].alpha = 0;
	strumLines.members[3].characters[0].x -= 75;
	strumLines.members[3].characters[0].y -= 550;
	strumLines.members[3].characters[0].scale.x = strumLines.members[3].characters[0].scale.y = 0.01;
	strumLines.members[0].characters[1].alpha = 0;
	strumLines.members[0].characters[1].x += 100;
	strumLines.members[0].characters[1].y += 200;
	strumLines.members[1].characters[0].alpha = 0;
	strumLines.members[1].characters[0].y -= 100;
	strumLines.members[2].characters[0].alpha = 0;
	strumLines.members[2].characters[0].scrollFactor.set(1, 1);
}

function beatHit(curBeat) {
	if (curBeat == 0) {
		if (FlxG.save.data.peppino == true) {
		peppino = FlxG.sound.play(Paths.sound("peppino that is my name"), 1);
		peppino.volume = 0.6;
		}
	}
	if (curBeat % 32 == 0) {
		trace("reset the peppino part time");
		peppino.time = inst.time;
	}
	if (curBeat > 47 && strumLines.members[0].characters[1].alpha != 1) {
		strumLines.members[0].characters[0].x += 200;
		strumLines.members[0].characters[0].visible = false;
		strumLines.members[0].characters[1].x -= 100;
		strumLines.members[0].characters[1].y -= 200;
		strumLines.members[0].characters[1].visible = true;
		strumLines.members[0].characters[1].alpha = 1;
		strumLines.members[1].characters[0].alpha = 0.7;
		strumLines.members[2].characters[0].alpha = 0.7;
	}
}

function normal() {
	strumLines.members[0].characters[0].danceOnBeat = false;
	strumLines.members[0].characters[0].playAnim('stand', true);
	FlxTween.tween(strumLines.members[1].characters[0], {alpha: 0.7}, 3, {ease: FlxEase.linear, type: FlxTween.ONESHOT});
	FlxTween.tween(strumLines.members[2].characters[0], {alpha: 0.7}, 3, {ease: FlxEase.linear, type: FlxTween.ONESHOT});
}

function update(elapsed) {
	if (strumLines.members[0].characters[0].animation.name == "stand" && strumLines.members[0].characters[0].animation.finished && strumLines.members[0].characters[1].alpha != 1) {
		trace("oh lawd he standin");
		strumLines.members[0].characters[0].x += 200;
		strumLines.members[0].characters[0].visible = false;
		strumLines.members[0].characters[1].x -= 100;
		strumLines.members[0].characters[1].y -= 200;
		strumLines.members[0].characters[1].alpha = 1;
	}

	timer += elapsed * 60;
	strumLines.members[2].characters[0].x = Math.sin(timer / 50) * 50 + 300;
	strumLines.members[2].characters[0].y = Math.cos(timer / 50) * 25 + 200;
	tarX = -1 * Math.sin(timer / 50) * 100 + 350;
	tarY = -1 * Math.cos(timer / 50) * 50 - 300;
	strumLines.members[3].characters[0].x = tarX;
	if (strumLines.members[3].characters[0].alpha == 0.7) {
		strumLines.members[3].characters[0].y = lerp(strumLines.members[3].characters[0].y, tarY, 0.5);
	}
}

function postUpdate() {
	if (curCameraTarget == 2) {
		var anim = strumLines.members[3].characters[0].getAnimName();
		switch(anim){
			case "singLEFT"|"singLEFT-alt": camFollow.x -= cameraMovementStrength;
			case "singDOWN"|"singDOWN-alt": camFollow.y += cameraMovementStrength;
			case "singUP"|"singUP-alt": camFollow.y -= cameraMovementStrength;
			case "singRIGHT"|"singRIGHT-alt": camFollow.x += cameraMovementStrength;
		}
	}
}

function marioAppear() {
	trace("here comes Mario...");
	defaultCamZoom -= 0.2;
	peppino.time = inst.time;
	strumLines.members[3].characters[0].alpha = 0;
	FlxTween.tween(strumLines.members[3].characters[0], {y: -300, alpha:0.7}, 4, {ease: FlxEase.backOut, type: FlxTween.ONESHOT});
	FlxTween.tween(strumLines.members[3].characters[0].scale, {x:1, y: 1}, 4, {ease: FlxEase.quadOut, type: FlxTween.ONESHOT});
}

function marioBye() {
	defaultCamZoom += 0.2;
	trace("bye bye peppino.... i mean, mario...");
	strumLines.members[3].characters[0].alpha = 0.65;
	FlxTween.tween(strumLines.members[3].characters[0], {y: -1600, alpha:0}, 3, {ease: FlxEase.quadIn, type: FlxTween.ONESHOT});
}

function sad() {
	defaultCamZoom += 0.2;
	strumLines.members[0].characters[0].x -= 200;
	strumLines.members[0].characters[0].visible = true;
	strumLines.members[0].characters[1].visible = false;
	FlxTween.tween(strumLines.members[1].characters[0], {alpha: 0}, 3, {ease: FlxEase.linear, type: FlxTween.ONESHOT});
	FlxTween.tween(strumLines.members[2].characters[0], {alpha: 0}, 3, {ease: FlxEase.linear, type: FlxTween.ONESHOT});
}