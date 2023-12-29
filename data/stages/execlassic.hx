var path = "stages/execlassic/";
var camxoffset:Float = 0;
var camyoffset:Float = 0;
var dadxoffset:Float = -100;
var dadyoffset:Float = 0;
var camBR = null;

function create() {
    FlxG.cameras.add(camBR = new HudCamera(), false);
    camBR.bgColor = 0;
    defaultCamZoom = 0.6;

    remove(dad);
    remove(gf);
    remove(boyfriend);

    gf.scrollFactor.set(1, 1);

    boyfriend.x = 1000;
    boyfriend.y = 120;
    dad.x = 100;
    dad.y = 120;
    gf.x = 570;
    gf.y = 80;

    boyfriend.cameraOffset = FlxPoint.weak(camxoffset, camyoffset);
    dad.cameraOffset = FlxPoint.weak(dadxoffset, dadyoffset);

    bg = new FlxSprite(-1000, -850).loadGraphic(Paths.image(path + "Castillo fondo de hasta atras"));
    bg.antialiasing = true;
    add(bg);

    floor = new FlxSprite(-1000, -850).loadGraphic(Paths.image(path + "Suelo y brillo atmosferico"));
    floor.antialiasing = true;
    add(floor);

    trees = new FlxSprite(-1000, -850).loadGraphic(Paths.image(path + "Arboles y sombra"));
    trees.antialiasing = true;
    add(trees);

    bricks = new FlxSprite(-1000, -850).loadGraphic(Paths.image(path + "CLadrillosPapus"));
    bricks.antialiasing = true;
    add(bricks);

    dark = new FlxSprite(-1000, -850).loadGraphic(Paths.image(path + "dark"));
    dark.scrollFactor.set();
    dark.alpha = 0.8;
    dark.screenCenter();
    dark.cameras = [camHUD];
    dark.antialiasing = true;
    add(dark);

    add(gf);
    add(dad);
    add(boyfriend);
}

function beatHit(curBeat) {
    switch (curBeat) {
        case 18:
            FlxTween.tween(FlxG.camera, {zoom: 0.62}, 0.2, {ease: FlxEase.sineInOut});
            defaultCamZoom = 0.62;
        case 22:
            defaultCamZoom = 0.64;
            FlxTween.tween(FlxG.camera, {zoom: 0.64}, 0.2, {ease: FlxEase.sineInOut});
        case 26:
            defaultCamZoom = 0.68;
            FlxTween.tween(FlxG.camera, {zoom: 0.68}, 0.2, {ease: FlxEase.sineInOut});
        case 30:
            defaultCamZoom = 0.7;
            FlxTween.tween(FlxG.camera, {zoom: 0.7}, 0.2, {ease: FlxEase.sineInOut});
        case 35:
            defaultCamZoom = 0.5;
        case 340:
            dark.cameras = [camBR];
            dad.playAnim("laugh");
            camHUD.alpha = 0.000;
            defaultCamZoom = 0.7;
        case 355:
            dark.cameras = [camHUD];
            camHUD.alpha = 1;
            defaultCamZoom = 0.6;
    }
}