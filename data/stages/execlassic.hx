import flixel.tweens.FlxTween.FlxTweenType;

var path = "stages/execlassic/";
var camxoffset:Float = -70; //-100
var camyoffset:Float = -100;
var dadxoffset:Float = -270; //-100
var dadyoffset:Float = 100;
var camBR = null;

var mosaic:CustomShader = null;
var mosaicTween:NumTween;
var camTween:NumTween;

function create() {
    FlxG.cameras.add(camBR = new HudCamera(), false);
    camBR.bgColor = 0;
    defaultCamZoom = 0.5;

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
    strumLines.members[0].characters[1].cameraOffset = FlxPoint.weak(dadxoffset + 60, dadyoffset);

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
        case 268:
            defaultCamZoom = 0.45;
        case 272:
            defaultCamZoom = 0.6;
        case 304:
            defaultCamZoom = 0.5;
        case 340:
            dark.cameras = [camBR];
            dad.playAnim("laugh");
            camHUD.alpha = 0.0001;
            defaultCamZoom = 0.6;
        case 344:
            defaultCamZoom = 0.45;
        case 355:
            dark.cameras = [camHUD];
            camHUD.alpha = 1;
            defaultCamZoom = 0.5;
            strumLines.members[0].characters[1].visible = true;
            dad.visible = false;
        case 484:
            defaultCamZoom = 0.65;
        case 488:
            defaultCamZoom = 0.7;
        case 492:
            defaultCamZoom = 0.75;
        case 496:
            defaultCamZoom = 0.8;
        case 500:
            defaultCamZoom = 0.6;
        case 504:
            defaultCamZoom = 0.55;
        case 508:
            defaultCamZoom = 0.5;
        case 512:
            defaultCamZoom = 0.45;
        case 516:
            strumLines.members[0].characters[1].playAnim("laugh");
            FlxTween.tween(fireL, {y: -800}, 20, {ease: FlxEase.quadInOut});
            FlxTween.tween(fireR, {y: -800}, 20, {ease: FlxEase.quadInOut});
            FlxTween.tween(smoke, {alpha: 1}, 25);
            FlxTween.tween(FlxG.camera, {zoom: 0.7}, 13, {ease: FlxEase.sineInOut});
            defaultCamZoom = 0.75;
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