/**
    Purpose of this is to see notes as they can be
    blended in the background by having a big black square
    behind camHUD, so they work for any kind of strumlines
    without any conflict for coop and opponent mode :thumpsup:
**/

function postCreate() {
    if (FlxG.save.data.transparency_value != 0) {
        camHUD.bgColor = FlxColor.fromRGBFloat(0, 0, 0, FlxG.save.data.transparency_value);
    }
}