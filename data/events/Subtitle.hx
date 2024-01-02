import flixel.text.FlxTextBorderStyle;

var camSubtitle:FlxCamera = new FlxCamera();

function create(){
    FlxG.cameras.add(camSubtitle, false);
    camSubtitle.bgColor = 0x00000000;

    subTitle = new FlxText(0, 560.8, FlxG.width, "", 20);
    subTitle.setFormat(Paths.font(""), 30, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    subTitle.scrollFactor.set();
    subTitle.borderSize = 1.25;
    subTitle.cameras = [camSubtitle];
    add(subTitle);
}

function onEvent(_){
    if (_.event.name == "Subtitle"){
        subTitle.text = _.event.params[0];
        subTitle.color = _.event.params[1];
        subTitle.scale.set(_.event.params[2], _.event.params[2]);
        if (_.event.params[3] == "ttf") subTitle.font = (Paths.font(_.event.params[4] + ".ttf"));
        else if (_.event.params[3] == "otf") subTitle.font = (Paths.font(_.event.params[4] + ".otf"));
    }
}