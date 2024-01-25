import funkin.backend.system.framerate.Framerate;
import flixel.effects.FlxFlicker;

var canDoShit:Bool = true;

// the scaling could be incorrect depending on your monitor's resolution btw !
FlxG.resizeWindow(fsX / 2.084691, fsY / 1.562952);
FlxG.resizeGame(fsX / 2.084691, fsY / 1.562952);
FlxG.scaleMode.width = fsX / 2.084691;
FlxG.scaleMode.height = fsY / 1.562952;
FlxG.mouse.visible = false;
window.x = 500;
window.y = 195;

Framerate.fpsCounter.visible = true;
Framerate.memoryCounter.visible = true;
Framerate.codenameBuildField.visible = true;

var camEnter = new FlxCamera();

var hands:Array<FlxSprite> = [];

var ntsc, staticShader, bloom, ntscGlitch:CustomShader = null;

var twn1, twn2:NumTween;

var zoomOutTwn, curtainUpTwn:FlxTween;

function new(){
    CoolUtil.playMenuSong();
    FlxG.sound.music.volume = 0;
}

function create(){
    FlxG.cameras.add(camEnter, false);
	camEnter.bgColor = 0x00000000;
    camEnter.height += 1;
    camEnter.width += 1;

    FlxG.camera.shake(0.000005, 999999999999);
	FlxG.camera.zoom = 0.875 * 1.1;

    staticShader = new CustomShader("TVStatic");
    staticShader.data.strengthMulti.value = [1, 1];
    FlxG.camera.addShader(staticShader);

    bloom = new CustomShader("Bloom");
    bloom.data.dim.value = [.5, .5];
    camEnter.addShader(bloom);

    ntsc = new CustomShader("NTSCFilter");
    camEnter.addShader(ntsc);

    blackSprite = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
	blackSprite.updateHitbox();
	blackSprite.screenCenter();

    _static = new FlxSprite(0,-350);
	_static.frames = Paths.getSparrowAtlas('menus/estatica_uwu');
	_static.animation.addByPrefix('idle', "Estatica papu", 15);
	_static.animation.play('idle');
	_static.alpha = 0.33;
	_static.cameras = [FlxG.camera];
	_static.color = FlxColor.RED;
	_static.screenCenter(FlxAxes.X);
	add(_static);

    bottomGroup = new FlxSpriteGroup();
	bottomGroup.cameras = [FlxG.camera];
    bottomGroup.setPosition(-170, -26.5);
	add(bottomGroup);

    floor = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/title/floor'));
	floor.scale.set(0.95, 0.95);
	floor.updateHitbox();
	floor.setPosition(-40.0567375886525, 360); // bros being specific
	bottomGroup.add(floor);

    for (i in 0...2) {
        var hand:FlxSprite = new FlxSprite(96 + (601 * i), 125);
        hand.frames = Paths.getSparrowAtlas("menus/title/titleAssets");
        hand.animation.addByPrefix("idle", "Spookihand", 24, true);
        hand.animation.play("idle", true);
        hand.scale.set(0.75, 0.75);
        hand.updateHitbox();
        bottomGroup.add(hand);

        ntscGlitch = new CustomShader("NTSCGlitch");
        ntscGlitch.data.glitchAmount.value = [.2, .2];
        hand.shader = ntscGlitch;

        hand.flipX = i == 1; // WHAT NO WAY!!

        hand.ID = i;
        hands.push(hand);
    }

    bf = new FlxSprite(303, 312);
    bf.frames = Paths.getSparrowAtlas("menus/title/titleAssets");
    bf.animation.addByPrefix("idle", "BF", 24, false);
    bf.scale.set(0.75, 0.75);
    bf.updateHitbox();
    bottomGroup.add(bf);

    gf = new FlxSprite(705, 230);
    gf.frames = Paths.getSparrowAtlas("menus/title/titleAssets");
    gf.animation.addByPrefix("idle", "GF", 24, false);
    gf.scale.set(0.75, 0.75);
    gf.updateHitbox();
    bottomGroup.add(gf);

    enterSprite = new FlxSprite(0, 560);
    enterSprite.frames = Paths.getSparrowAtlas("menus/title/enter");
    enterSprite.animation.addByPrefix("idle", "EnterLoop", 24, false);
    enterSprite.animation.addByPrefix("press", "EnterBegin", 24, false);
    enterSprite.animation.play("idle");
    enterSprite.cameras = [camEnter];
    enterSprite.updateHitbox();
    enterSprite.screenCenter(FlxAxes.X);
    enterSprite.x -= 2;
    add(enterSprite);

    logoBl = new FlxSprite(0, 60).loadGraphic(Paths.image('menus/title/MMv2LogoFINAL'));
	logoBl.setGraphicSize(Std.int(logoBl.width * (0.295 * 0.9)));
	logoBl.updateHitbox();
	logoBl.screenCenter(FlxAxes.X);
	logoBl.cameras = [camEnter];
	add(logoBl);

    curtain = new FlxSprite().loadGraphic(Paths.image('menus/title/duh'));
	curtain.scale.set(1.289 * 0.9, 1.286 * 0.9);
	curtain.updateHitbox();
	curtain.screenCenter();
	curtain.cameras = [camEnter];
	curtain.y = -682.501606766917 * 0.25;
	add(curtain);

    prevWallpaper = getWallpaper(); // this is for paranoia

    blackSprite.cameras = [camEnter];
	add(blackSprite);

    new FlxTimer().start(Conductor.stepCrochet/1000 * 2, (_) -> {
        FlxG.sound.music.fadeIn((Conductor.stepCrochet/1000 * 16) * 2, 0, 1.2);

        FlxTween.tween(blackSprite, {alpha: 0}, Conductor.stepCrochet/1000 * 6, {onComplete: (_) -> {
            blackSprite.alpha = 0.05;
            FlxFlicker.flicker(blackSprite, 999999999999);
        }});
        
        curtainUpTwn = FlxTween.tween(curtain, {y: -682.501606766917}, Conductor.stepCrochet/1000 * 4, {ease: FlxEase.circOut, startDelay: (Conductor.stepCrochet/1000) / 8});
        FlxG.camera.zoom += 0.075;
        zoomOutTwn = FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom - 0.075}, (Conductor.stepCrochet/1000 * 12), {ease: FlxEase.circOut});
    });
}

function update(){
    if (FlxG.sound.music != null) Conductor.songPosition = FlxG.sound.music.time;

    if (ntsc != null) ntsc.data.uFrame.value = [Conductor.songPosition];

    if (staticShader != null) staticShader.data.iTime.value = [Conductor.songPosition];

    if (controls.ACCEPT && canDoShit) enterPressed();

    var currentBeat = (Conductor.songPosition / 1000) * (Conductor.bpm / 60);

    if (bloom != null /*&& !transitioning*/) {
        bloom.data.Size.value = [1.0 + (0.5 * FlxMath.fastSin(currentBeat * 2))];
    }

    for (hand in hands) {
        if (hand != null) {
            hand.y = 125 + 20 * FlxMath.fastCos((currentBeat / 4) * Math.PI);
            hand.offset.x = 80.125 + FlxG.random.float(-3.5, 3.5);

            hand.angle = 10 * (hand.ID == 1 ? -1 : 1) * FlxMath.fastSin((currentBeat / 4) * Math.PI);
        }
    }

    if (logoBl != null) logoBl.y = 60 + 7.5 * FlxMath.fastCos((currentBeat / 3) * Math.PI);
}

function enterPressed(){
    canDoShit = false;
    CoolUtil.playMenuSFX(1);
    
    /*if (FlxG.save.data.flashingLights){
        bloom.data.Size.value = [18 * 2, 18 * 2];
        bloom.data.dim.value = [0.25, 0.25];

        twn1 = FlxTween.num(18.0 * 2, 3.0, 1.5, {
            onUpdate: (_) -> {
                bloom.data.Size.value = [3, 3];
            }
        });

        twn2 = FlxTween.num(0.25, 2.0, 1.5, {
            onUpdate: (_) -> {
                bloom.data.dim.value = [2, 2];
            }
        });
    }*/

    enterSprite.offset.set(127, 85);
	enterSprite.animation.play("press", true);
	enterSprite.animation.finishCallback = (_) -> {enterSprite.visible = false;};

    FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.075}, Conductor.stepCrochet/1000 * 4, {ease: FlxEase.circOut});

    new FlxTimer().start(Conductor.stepCrochet/1000 * 2, function(tmr:FlxTimer) {
        FlxTween.tween(curtain, {y: curtain.y - 40}, (Conductor.stepCrochet/1000), {
            ease: FlxEase.circInOut,
            onComplete: (_) -> {
                FlxTween.tween(curtain, {y: 3}, Conductor.stepCrochet/1000 * 4.6, {ease: FlxEase.quintOut, startDelay: 0.03});

                FlxFlicker.stopFlickering(blackSprite); 
                blackSprite.alpha = 0; blackSprite.visible = true;

                FlxTween.tween(blackSprite, {alpha: 1}, Conductor.stepCrochet/1000 * 2, {
                    startDelay: 0.04,
                    onComplete: (_) -> {
                        FlxG.updateFramerate = 30; // Makes it smoother and consistant
                        
                        FlxTween.tween(window, {x: 325, width: resizex, height: resizey}, 0.3 * 4, {
                            ease: FlxEase.circInOut,
                            onComplete: function(twn:FlxTween){
                                completeWindowTwn();
                            }
                        });

                        FlxG.camera.visible = false;
                        camEnter.visible = false;
                    }
                });
            }
        });
    });
}

function completeWindowTwn(){
    FlxG.resizeWindow(resizex, resizey);
    FlxG.resizeGame(resizex, resizey);
    FlxG.scaleMode.width = resizex;
    FlxG.scaleMode.height = resizey;
    FlxG.updateFramerate = Options.fpsCounter;

    FlxG.mouse.visible = true;
    FlxG.switchState(new MainMenuState());
};

function stepHit(){
    if (enterSprite != null && curStep % 2 == 0 && enterSprite.animation.name != "press")
        enterSprite.animation.play("idle", true);

    if (curStep % 2 == 0)
        bf.animation.play("idle");
        gf.animation.play("idle");
}