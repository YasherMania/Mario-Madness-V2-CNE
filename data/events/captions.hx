import flixel.text.FlxTextBorderStyle;

var sub:FlxText;
function create() {
    sub = new FlxText(0, 19, 400, "", 32);
    sub.setFormat(Paths.font("Mario2.ttf"), 42, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    sub.scrollFactor.set();
    sub.borderColor = 0xFF000000;
    sub.borderSize = 2;
    sub.screenCenter(FlxAxes.X);
    add(sub);
    sub.cameras = [camHUD];
}

function updateText(text:String) {
    sub.scale.x = 1.2;
    sub.scale.y = 1.2;
    sub.text = text;
    FlxTween.tween(sub.scale, {x: 1, y: 1}, 0.2, {ease: FlxEase.circOut});
}

function onEvent(e) {
	if (e.event.name == 'captions') {
		updateText(e.event.params[0]);
	}
}