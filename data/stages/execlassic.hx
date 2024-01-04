import flixel.tweens.FlxTween.FlxTweenType;

var path = "stages/execlassic/";
var camxoffset:Float = -70; //-100
var camyoffset:Float = 0;
var dadxoffset:Float = -270; //-100
var dadyoffset:Float = 100;
var camBR = null;

var mosaic:CustomShader = null;
var mosaicTween:NumTween;
var camTween:NumTween;

function create() {
    FlxG.cameras.add(camBR = new HudCamera(), false);
    camBR.bgColor = 0;
    defaultCamZoom = 0.6;
    mycharIdleAlt = false;

    mosaic = new CustomShader("mosaicShader");
    mosaic.data.uBlocksize.value = [0.1,0.1];
    camGame.addShader(mosaic);

    remove(dad);
    remove(strumLines.members[0].characters[1]);
    remove(gf);
    remove(boyfriend);

    gf.scrollFactor.set(1, 1);
    strumLines.members[0].characters[1].visible = false;

    boyfriend.x = 1000;
    boyfriend.y = 120;
    dad.x = 100;
    dad.y = 120;
    gf.x = 570;
    gf.y = 80;

    boyfriend.cameraOffset = FlxPoint.weak(camxoffset, camyoffset);
    dad.cameraOffset = FlxPoint.weak(dadxoffset, dadyoffset);
    strumLines.members[0].characters[1].cameraOffset = FlxPoint.weak(dadxoffset, dadyoffset);

    bg = new FlxSprite(-1000, -850).loadGraphic(Paths.image(path + "Castillo fondo de hasta atras"));
    bg.antialiasing = true;
    add(bg);

    fireL = new FlxSprite(-1400, -800 + 1300);
    fireL.frames = Paths.getFrames(path + "Starman_BG_Fire_Assets");
    fireL.animation.addByPrefix("idle", "fire anim effects", 24, true);
    fireL.antialiasing = true;
    //fireL.alpha = 0.00001;
    fireL.animation.play("idle");
    add(fireL);

    fireR = new FlxSprite(700, -800 + 1300);
    fireR.frames = Paths.getFrames(path + "Starman_BG_Fire_Assets");
    fireR.animation.addByIndices('delay', 'fire anim effects', [8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7], "", 24, true);
    fireR.antialiasing = true;
    //fireR.alpha = 0.00001;
    fireR.flipX = true;
    fireR.animation.play('delay');
    add(fireR);

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

    smoke = new FlxSprite(-1000, -850).loadGraphic(Paths.image(path + "smoke"));
    smoke.scrollFactor.set();
    smoke.alpha = 0.8;
    smoke.screenCenter();
    smoke.cameras = [camHUD];
    smoke.antialiasing = true;
    smoke.alpha = 0.00001;
    add(smoke);

    add(gf);
    add(dad);
    add(strumLines.members[0].characters[1]);
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
            mycharIdleAlt = true;
            dark.cameras = [camBR];
            dad.playAnim("laugh");
            camHUD.alpha = 0.0001;
            defaultCamZoom = 0.7;
        case 355:
            dark.cameras = [camHUD];
            camHUD.alpha = 1;
            defaultCamZoom = 0.5;
            strumLines.members[0].characters[1].visible = true;
            dad.visible = false;
        case 516:
            strumLines.members[0].characters[1].playAnim("laugh");
            FlxTween.tween(fireL, {y: -800}, 20, {ease: FlxEase.quadInOut});
            FlxTween.tween(fireR, {y: -800}, 20, {ease: FlxEase.quadInOut});
            FlxTween.tween(smoke, {alpha: 1}, 25);
            FlxTween.tween(FlxG.camera, {zoom: 0.7}, 13, {ease: FlxEase.sineInOut});
        case 553:
            defaultCamZoom = 0.7;
        case 580:
            defaultCamZoom = 1;
        case 583:
            mosaicTween = FlxTween.num(0.1, 80, 5, {ease: FlxEase.circInOut, onUpdate: (_) -> {
                mosaic.data.uBlocksize.value = [mosaicTween.value, mosaicTween.value];
            }});
        case 590:
            camTween = FlxTween.num(1, 0.0001, 1, {ease: FlxEase.sineInOut, onUpdate: (_) -> {
                camGame.alpha = camTween.value;
            }});
        case 595:
            camTween = FlxTween.num(1, 0.0001, 1, {ease: FlxEase.sineInOut, onUpdate: (_) -> {
                camHUD.alpha = camTween.value;
            }});
    }
}