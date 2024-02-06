import flixel.text.FlxTextBorderStyle;

var autor:String = "";
var porter:String = "";

function create(){
    titleText = new FlxText(400, 350.4, 0, PlayState.SONG.meta.displayName, 42);
	titleText.setFormat(Paths.font("nes.ttf"), 42, FlxColor.BLACK, "center", FlxTextBorderStyle.OUTLINE);
	titleText.borderSize = 3;
    titleText.borderColor = FlxColor.RED;
    titleText.cameras = [camHUD];
	titleText.screenCenter(FlxAxes.X);
	titleText.alpha = 0;
	add(titleText);

	autorText = new FlxText(375, titleText.y - 70, 0, autor, 35);
	autorText.setFormat(Paths.font("nes.ttf"), 35, FlxColor.BLACK, "center", FlxTextBorderStyle.OUTLINE);
	autorText.borderSize += 2;
    autorText.borderColor = FlxColor.RED;
    autorText.cameras = [camHUD];
	autorText.screenCenter(FlxAxes.X);
	autorText.alpha = 0;
	add(autorText);

    porterText = new FlxText(327.5, autorText.y - 55, 0, porter, 27.5);
	porterText.setFormat(Paths.font("nes.ttf"), 22.5, FlxColor.BLACK, "center", FlxTextBorderStyle.OUTLINE);
    porterText.borderColor = FlxColor.RED;
	porterText.borderSize += 2;
    porterText.cameras = [camHUD];
	porterText.screenCenter(FlxAxes.X);
	porterText.alpha = 0;
	add(porterText);

    var checkwidth:Float = autorText.width;

    line2 = new FlxSprite(566, titleText.y - 15).makeGraphic(Std.int(checkwidth), 5, FlxColor.BLACK);
    line2.cameras = [camHUD];
    line2.screenCenter(FlxAxes.X);
    line2.alpha = 0;

    line1 = new FlxSprite(line2.x, line2.y + 4).makeGraphic(Std.int(checkwidth + 10), 8);
    line1.cameras = [camHUD];
    line1.color = FlxColor.RED;
    line1.alpha = 0;
    // lines are wip
    //add(line1);
    //add(line2);
}

function update(){
    // mfw when upscroll players - apurples, a downscroll player
    if (!downscroll){
        autorText.y = titleText.y + 70;
        porterText.y = autorText.y + 55;
    }
}

function onEvent(_){
    if (_.event.name == "Show Song" && _.event.params[0]){
        autorText.text = _.event.params[1];
        porterText.text = "Porter(s): " + _.event.params[2];
        window.title = "Friday Night Funkin': Mario's Madness | " + PlayState.SONG.meta.displayName + " | " + autorText.text + " | " + porterText.text;
        for (i in [titleText, autorText, porterText/*, line1, line2*/]){
            if (downscroll) FlxTween.tween(i, {alpha: 1, y: i.y + 30}, 0.5, {ease: FlxEase.cubeOut});
            else FlxTween.tween(i, {alpha: 1, y: i.y - 30}, 0.5, {ease: FlxEase.cubeOut});
        }
	autorText.screenCenter(FlxAxes.X);
	porterText.screenCenter(FlxAxes.X);
        new FlxTimer().start(_.event.params[3], function (tmr:FlxTimer){
            for (i in [titleText, autorText, porterText/*, line1, line2*/]) FlxTween.tween(i, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
        });
    }
}