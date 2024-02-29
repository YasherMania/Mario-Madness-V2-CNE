import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormat;

var autor:String = "";
var porter:String = "";
var gbcolor:FlxColor = 0xFFF42626;
var format = new FlxTextFormat(0x000000, false, false, gbcolor);

function create(){
    createText(titleText, 400, 350.4, 42);
    createText(autorText, 375, titleText.y - 70, 35);
    createText(porterText, 327.5, autorText.y - 55, 22.5);

    createLine(titleLine1, titleText.y - 14, Std.int(titleText.width + 10), 8, gbcolor);
    createLine(titleLine2, titleText.y - 14, Std.int(titleText.width), 5, FlxColor.BLACK);

    createLine(porterLine1, titleText.y - 84, Std.int(autorText.width + 10), 8, gbcolor);
    createLine(porterLine2, titleText.y - 84, Std.int(autorText.width), 5, FlxColor.BLACK);
}

function createText(text:FlxText, x:Float, y:Float, size:Float):Void {
    text = new FlxText(x, y, 0, "", size);
    text.setFormat(Paths.font("nes.ttf"), size, FlxColor.BLACK, "center", FlxTextBorderStyle.OUTLINE, gbcolor);
    text.borderSize += 2;
    text.borderColor = FlxColor.RED;
    text.cameras = [camHUD];
    text.screenCenter(FlxAxes.X);
    text.alpha = 0;
    add(text);
}

function createLine(line:FlxSprite, y:Float, width:Int, height:Int, color:Int):Void {
    line = new FlxSprite(566, y).makeGraphic(width, height, color);
    line.cameras = [camHUD];
    line.screenCenter(FlxAxes.X);
    line.alpha = 0;
    add(line);
}

function onEvent(_){
    if (_.event.name == "Show Song" && _.event.params[0]){
        autorText.text = _.event.params[1];
        porterText.scale.set(_.event.params[3], _.event.params[3]);
        porterText.text = "Ported By: " + _.event.params[2];
        window.title = "Friday Night Funkin': Mario's Madness | " + PlayState.SONG.meta.displayName + " | " + autorText.text + " | " + porterText.text;
        for (i in [titleText, autorText, porterText]){
            FlxTween.tween(i, {alpha: 1, y: downscroll ? i.y + 30 : i.y - 30}, 0.5, {ease: FlxEase.cubeOut});
        }
        autorText.screenCenter(FlxAxes.X);
        porterText.screenCenter(FlxAxes.X);
        new FlxTimer().start(_.event.params[3], function (tmr:FlxTimer){
            for (i in [titleText, autorText, porterText]) FlxTween.tween(i, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
        });
    }
}

function postCreate() {
    for (event in events) {
        if (event.name == 'Show Song') {
            window.title = "Friday Night Funkin': Mario's Madness | ";
            for (i in 0...PlayState.SONG.meta.displayName.length) {
                window.title += "?";
            }

            window.title += " | ";

            for (i in 0...event.params[1].length) {
                window.title += "?";
            }

            window.title += " | ";

            for (i in 0...event.params[2].length) {
                window.title += "?";
            }
        }
    }
}
