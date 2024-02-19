function create() {
    bg.setGraphicSize(FlxG.width * 6, FlxG.height * 6);
    start.setGraphicSize(Std.int(start.width * 4));
}

function beatHit() {
    if (curBeat % 1 == 0){
        start.visible = !start.visible;
    }
}
