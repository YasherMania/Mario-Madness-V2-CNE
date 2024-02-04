import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormat;

var autor:String = "";
var porter:String = "";

var gbcolor:FlxColor = 0xFFF42626;
var format = new FlxTextFormat(0x000000, false, false, gbcolor);

function create(){
    titleText = new FlxText(400, 350.4, 0, PlayState.SONG.meta.displayName, 42);
	titleText.setFormat(Paths.font("nes.ttf"), 42, FlxColor.BLACK, "center", FlxTextBorderStyle.OUTLINE, gbcolor);
	titleText.borderSize = 3;
    titleText.borderColor = FlxColor.RED;
    titleText.cameras = [camHUD];
	titleText.screenCenter(FlxAxes.X);
	titleText.alpha = 0;
	add(titleText);

	autorText = new FlxText(375, titleText.y - 70, 0, autor, 35);
	autorText.setFormat(Paths.font("nes.ttf"), 35, FlxColor.BLACK, "center", FlxTextBorderStyle.OUTLINE, gbcolor);
	autorText.borderSize += 2;
    autorText.borderColor = FlxColor.RED;
    autorText.cameras = [camHUD];
    autorText.screenCenter(FlxAxes.X);
	autorText.alpha = 0;
	add(autorText);

    porterText = new FlxText(327.5, autorText.y - 55, 0, porter, 22.5);
	porterText.setFormat(Paths.font("nes.ttf"), 22.5, FlxColor.BLACK, "center", FlxTextBorderStyle.OUTLINE, gbcolor);
    porterText.borderColor = FlxColor.RED;
	porterText.borderSize += 2;
    porterText.cameras = [camHUD];
    porterText.screenCenter(FlxAxes.X);
	porterText.alpha = 0;
	add(porterText);

    titleLine2 = new FlxSprite(566, titleText.y - 14).makeGraphic(Std.int(titleText.width), 5, FlxColor.BLACK);
    titleLine2.cameras = [camHUD];
    titleLine2.screenCenter(FlxAxes.X);
    titleLine2.alpha = 0;

    titleLine1 = new FlxSprite(titleLine2.x - 5, titleLine2.y - 2).makeGraphic(Std.int(titleText.width + 10), 8, gbcolor);
    titleLine1.cameras = [camHUD];
    titleLine1.alpha = 0;
    //add(titleLine1);
    //add(titleLine2);

    porterLine2 = new FlxSprite(566, titleText.y - 84).makeGraphic(Std.int(autorText.width), 5, FlxColor.BLACK);
    porterLine2.cameras = [camHUD];
    porterLine2.screenCenter(FlxAxes.X);
    porterLine2.alpha = 0;

    porterLine1 = new FlxSprite(porterLine2.x - 5, porterLine2.y - 2).makeGraphic(Std.int(autorText.width + 10), 8, gbcolor);
    porterLine1.cameras = [camHUD];
    porterLine1.alpha = 0;
    //add(porterLine1);
    //add(porterLine2);
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
        porterText.text = "Ported by: " + _.event.params[2];
        porterText.scale.set(_.event.params[3], _.event.params[3]);
        window.title = "Friday Night Funkin': Mario's Madness | " + PlayState.SONG.meta.displayName + " | " + autorText.text + " | " + porterText.text;
        for (i in [autorText, porterText]) i.screenCenter(FlxAxes.X);
        for (i in [titleText, autorText, porterText/*, titleLine1, titleLine2, porterLine1, porterLine2*/]){
            if (downscroll) FlxTween.tween(i, {alpha: 1, y: i.y + 30}, 0.5, {ease: FlxEase.cubeOut});
            else FlxTween.tween(i, {alpha: 1, y: i.y - 30}, 0.5, {ease: FlxEase.cubeOut});
        }

        new FlxTimer().start(_.event.params[4], function (tmr:FlxTimer){
            for (i in [titleText, autorText, porterText/*, titleLine1, titleLine2, porterLine1, porterLine2*/]) FlxTween.tween(i, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
        });
    }
}