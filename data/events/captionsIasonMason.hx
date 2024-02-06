import openfl.text.TextFormat;
import flixel.text.FlxText.FlxTextBorderStyle;

var theTxt:FlxText;
var size = 32;

function create() {
	theTxt = new FlxText(640, 400, 500, "", 32);
	theTxt.screenCenter();
	trace(theTxt.y);
	if (downscroll) {
		theTxt.y = 338 - 200;
	} else {
		theTxt.y = 338 + 200;
	}
	theTxt.alignment = "center";
	theTxt.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4, 1);
	theTxt.camera = camHUD;
	add(theTxt);
}

function onEvent(e) {
	if (e.event.name == 'captionsIasonMason') {
		theTxt.text = e.event.params[0];
	}
}