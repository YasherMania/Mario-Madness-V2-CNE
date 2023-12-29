import openfl.text.TextFormat;

var firstTxt:FlxText;
var secondTxt:FlxText;
var thirdTxt:FlxText;
var size = 150;
var timer = 50;
function create() {
	firstTxt = new FlxText(0, 250, 2000, "", 1000);
	firstTxt.setFormat(Paths.font("Retro_Gaming.ttf"), size, FlxColor.WHITE, "center");
	firstTxt.screenCenter();
	firstTxt.y -= size;
	firstTxt.scrollFactor.set();
	insert(members.indexOf(dad), firstTxt);
	insert(members.indexOf(gf), firstTxt);
	insert(members.indexOf(boyfriend), firstTxt);
	secondTxt = new FlxText(0, 250, 2000, "", 1000);
	secondTxt.setFormat(Paths.font("Retro Gaming.ttf"), size, FlxColor.WHITE, "center");
	secondTxt.screenCenter();
	secondTxt.scrollFactor.set();
	insert(members.indexOf(dad), secondTxt);
	insert(members.indexOf(gf), secondTxt);
	insert(members.indexOf(boyfriend), secondTxt);
	thirdTxt = new FlxText(0, 250, 2000, "", 1000);
	thirdTxt.setFormat(Paths.font("Retro Gaming.ttf"), size, FlxColor.WHITE, "center");
	thirdTxt.screenCenter();
	thirdTxt.scrollFactor.set();
	thirdTxt.y += size;
	insert(members.indexOf(dad), thirdTxt);
	insert(members.indexOf(gf), thirdTxt);
	insert(members.indexOf(boyfriend), thirdTxt);
}

function onEvent(e) {
	if (e.event.name == 'text') {
		timer = 50;
		firstTxt.text = e.event.params[0];
		secondTxt.text = e.event.params[1];
		thirdTxt.text = e.event.params[2];
		if (e.event.params[0] == "" && e.event.params[1] != "" && e.event.params[2] != "") {
			secondTxt.y = 250 - size/2;
			thirdTxt.y = 250 + size/2;
		} else if (e.event.params[2] == "" && e.event.params[1] != "" && e.event.params[0] != "") {
			firstTxt.y = 250 - size/2;
			secondTxt.y = 250 + size/2;
		} else {
			firstTxt.y = 250 - size;
			secondTxt.y = 250;
			thirdTxt.y = 250 + size;
		}
	}
}

function update(elapsed) {
	if (timer > 0) {
		trace("text timer is at " + timer);
		timer -= elapsed * 60;
	}
	if (timer < 1 && timer > 0) {
		trace("text timer is at " + timer);
		firstTxt.text = "";
		secondTxt.text = "";
		thirdTxt.text = "";
		timer = 0;
	}
}

function beatHit(curBeat) {
	if (curBeat % 4 == 0 && timer < 25) {
		firstTxt.text = "";
		secondTxt.text = "";
		thirdTxt.text = "";
		timer = 0;
	}
}
