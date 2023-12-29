import funkin.backend.system.framerate.Framerate;

var canDoShit:Bool = true;

FlxG.resizeWindow(960, 720);
FlxG.resizeGame(960, 720);
FlxG.scaleMode.width = 960;
FlxG.scaleMode.height = 720;
window.resizable = false;
window.x = 500;
window.title = "Friday Night Funkin': Mario's Madness";

FlxG.camera.zoom = 1.1;

Framerate.fpsCounter.visible = false;
Framerate.memoryCounter.visible = false;
Framerate.codenameBuildField.visible = false;

var camEnter = new FlxCamera();

function new() CoolUtil.playMenuSong();

function create(){
    FlxG.cameras.add(camEnter, false);
	camEnter.bgColor = 0x00000000;

    FlxTween.tween(FlxG.camera, {zoom: 1}, 2, {ease: FlxEase.quartInOut});

    estatica = new FlxSprite(-250);
    estatica.frames = Paths.getFrames('menus/mainmenu/estatica_uwu');
    estatica.animation.addByPrefix('idle', "Estatica papu", 15);
    estatica.animation.play('idle');
    estatica.antialiasing = false;
    estatica.color = FlxColor.RED;
    estatica.alpha = 0.25;
    add(estatica);

    bg = new FlxSprite(0, 375).loadGraphic(Paths.image('menus/title/floor'));
    bg.screenCenter(FlxAxes.X);
    add(bg);

    hand1 = new FlxSprite(-85, 125);
    hand1.scale.set(.775, .775);
    hand1.frames = Paths.getSparrowAtlas('menus/title/titleAssets');
    hand1.animation.addByPrefix('idle', "Spookihand", 24);
    hand1.animation.play("idle", true);
    FlxTween.tween(hand1, {y: hand1.y - 25}, 2, {ease: FlxEase.sineInOut, type: 4});
    FlxTween.tween(hand1, {angle: 7.5}, 1, {ease: FlxEase.sineInOut, type: 4});
    add(hand1);

    hand2 = new FlxSprite(445, 125);
    hand2.scale.set(.775, .775);
    hand2.frames = Paths.getSparrowAtlas('menus/title/titleAssets');
    hand2.animation.addByPrefix('idle', "Spookihand", 24);	
    hand2.animation.play("idle", true);
    FlxTween.tween(hand2, {y: hand2.y - 25}, 2, {ease: FlxEase.sineInOut, type: 4});
    FlxTween.tween(hand2, {angle: -7.5}, 1, {ease: FlxEase.sineInOut, type: 4});
    hand2.flipX = true;
    add(hand2);

    bf = new FlxSprite(45, 315);
    bf.scale.set(.65, .65);
    bf.frames = Paths.getSparrowAtlas('menus/title/titleAssets');
    bf.animation.addByPrefix('idle', "BF", 24);	
    bf.animation.play("idle", true);
    add(bf);

    gf = new FlxSprite(460, 250);
    gf.scale.set(.65, .65);
    gf.frames = Paths.getSparrowAtlas('menus/title/titleAssets');
    gf.animation.addByPrefix('idle', "GF", 24);	
    gf.animation.play("idle", true);
    add(gf);

    titleText = new FlxSprite(185, 600);
    titleText.frames = Paths.getSparrowAtlas('menus/title/enter');
    titleText.animation.addByPrefix('idle', "EnterLoop", 24, true);
    titleText.animation.addByPrefix('press', "EnterBegin", 24, false);		
    titleText.animation.play('idle');
    titleText.cameras = [camEnter];
    add(titleText);

    logo = new FlxSprite(-50, -250).loadGraphic(Paths.image('menus/title/MMv2LogoFINAL'));
    FlxTween.tween(logo, {y: logo.y + 25}, 4, {ease: FlxEase.sineInOut, type: 4});
    logo.scale.set(.3, .3);
    logo.cameras = [camEnter];
    add(logo);

    curtain = new FlxSprite(0, -325).loadGraphic(Paths.image('menus/title/duh'));
    FlxTween.tween(curtain, {y: -650}, 1.75, {ease: FlxEase.sineOut});
    curtain.scale.set(1.25, 1.25);
    curtain.screenCenter(FlxAxes.X);
    curtain.cameras = [camEnter];
    add(curtain);
}

function update(){
    FlxG.camera.shake(.001, 9999999999999999);

    if (controls.ACCEPT && canDoShit) enterPressed();
}

function enterPressed(){
    canDoShit = false;
    titleText.animation.play("press");
    CoolUtil.playMenuSFX(1);
    if (FlxG.save.data.flashingLights) camEnter.flash(0xB7FF0000);

    // there is def a better way fixing offsets when a different animation plays but this will do for now - apurples
    titleText.x -= 122.5;
    titleText.y -= 85;

    for (i in [FlxG.camera, camEnter]) FlxTween.tween(i, {zoom: 1.05}, 1, {ease: FlxEase.sineInOut});

    new FlxTimer().start(.6, function(tmr:FlxTimer){
        titleText.alpha = 0;
    });

    new FlxTimer().start(1.5, function(tmr:FlxTimer){
        FlxTween.tween(curtain, {y: curtain.y - 25}, .5, {ease: FlxEase.sineOut});
    });

    new FlxTimer().start(2, function(tmr:FlxTimer){
        FlxTween.tween(curtain, {y: 25}, 1, {ease: FlxEase.sineOut});
        FlxG.camera.fade(FlxColor.BLACK, 1);
        camEnter.fade(FlxColor.BLACK, 1);
    });

    new FlxTimer().start(3, function(tmr:FlxTimer){
        FlxTween.tween(window, {x: 325, y: 175, width: 1280, height: 720}, 2, {ease: FlxEase.quartOut}).onComplete = function(){
            FlxG.resizeWindow(1280, 720);
            FlxG.scaleMode.width = 1280;
            FlxG.scaleMode.height = 720;
            FlxG.switchState(new MainMenuState());
        };
    });
}