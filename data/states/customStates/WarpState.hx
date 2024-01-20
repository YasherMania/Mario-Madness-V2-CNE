var pipeTimer:Float;
var canDoShit:Bool = true;
var bfSpeed:Float = .25;

var pixelTween:NumTween;
var pixel:CustomShader = null;

public var wasInWarpState:Bool = false;

function new() FlxG.sound.playMusic(Paths.music('warpzone/0'), 1); // "0" - days without fnf drama

function create(){
    bg = new FlxSprite(0, 0);
	bg.frames = Paths.getSparrowAtlas('warpzone/0/water_hub');
	bg.animation.addByPrefix('idle', "water hub idle", 6);
	bg.animation.play('idle');
	bg.setGraphicSize(Std.int(bg.width * 3));
	bg.antialiasing = false;
	bg.screenCenter();
	add(bg);

    bgworld = new FlxSprite(0, 0);
	bgworld.loadGraphic(Paths.image('warpzone/0/world'));
	bgworld.setGraphicSize(Std.int(bgworld.width * 3));
	bgworld.antialiasing = false;
	bgworld.screenCenter();
	add(bgworld);

	bgWarps = new FlxSprite(0, 0);
	bgWarps.frames = Paths.getSparrowAtlas('warpzone/0/hub_path');
	bgWarps.setGraphicSize(Std.int(bgWarps.width * 3));
	bgWarps.updateHitbox();
	bgWarps.screenCenter();
	bgWarps.antialiasing = false;
	bgWarps.y = Std.int(bgWarps.y);
	add(bgWarps);

    pibemapa = new FlxSprite(400, 251);
	var deadSuffix = '';
	//if(ClientPrefs.storySave[7]) deadSuffix = 'dead_';
	pibemapa.frames = Paths.getSparrowAtlas('warpzone/' + deadSuffix + 'overworld_bf');
	pibemapa.animation.addByPrefix('idle', "overworld bf walk down", 6);
	pibemapa.animation.addByPrefix('up', "overworld bf walk up", 6);
	pibemapa.animation.addByPrefix('down', "overworld bf walk down", 6);
	pibemapa.animation.addByPrefix('left', "overworld bf walk left", 6);
	pibemapa.animation.addByPrefix('right', "overworld bf walk right", 6);
	pibemapa.animation.addByPrefix('start', "overworld bf level start", 6);
	pibemapa.animation.add('warp', [0, 5, 9, 13], 10);
	pibemapa.animation.play('idle');
	pibemapa.setGraphicSize(Std.int(pibemapa.width * 3));
	pibemapa.antialiasing = false;
	//pibemapa.visible = false;
	pibemapa.updateHitbox();
	add(pibemapa);

    pibeback = new FlxSprite(616, 497);
    pibeback.frames = Paths.getSparrowAtlas('warpzone/bfAnims/' + deadSuffix + 'overworldreturnpipe');
    pibeback.animation.addByPrefix('intro', "overworldreturnpipe intro", 12, false);
    pibeback.animation.addByPrefix('enter', "overworldreturnpipe enter", 12, false);
    pibeback.animation.addByPrefix('cancel', "overworldreturnpipe cancel",24, false);
    pibeback.setGraphicSize(Std.int(pibeback.width * 3));
    pibeback.antialiasing = false;
    pibeback.updateHitbox();
    pibeback.animation.play('intro');
    pibeback.visible = false;
    add(pibeback);

    gameLives = new FlxSprite(0, 0);
	gameLives.frames = Paths.getSparrowAtlas('warpzone/overworld_overlay');
	gameLives.animation.addByPrefix('idle', "overworld overlay idle", 6);
	gameLives.animation.play('idle');
	gameLives.setGraphicSize(Std.int(gameLives.width * 3));
	gameLives.antialiasing = false;
	gameLives.updateHitbox();
	gameLives.screenCenter();
	add(gameLives);

    pixel = new CustomShader("mosaicShader");
    pixel.data.uBlocksize.value = [0, 0];
}

function update(elapsed:Float){
    if (FlxG.keys.justPressed.BACKSPACE && canDoShit){
        canDoShit = false;
        FlxTween.tween(FlxG.camera, {alpha: 0}, .5);
        CoolUtil.playMenuSFX(2, 1);
        FlxG.sound.music.stop();
        new FlxTimer().start(.65, function(tmr:FlxTimer){
            FlxG.switchState(new MainMenuState());
        });
    }
    
    if (FlxG.keys.pressed.ESCAPE){
        if(pipeTimer == 0){
            pibeback.animation.play('intro');
            pibeback.visible = true;
            pibemapa.visible = false;
        }

        pipeTimer += elapsed;

        if (pipeTimer >= 5) Sys.exit(0);
    }else{
        if(pibeback.animation.curAnim.name != 'cancel') pibeback.animation.play('cancel');
        else if(pibeback.animation.curAnim.finished){
            pibeback.visible = false;
            pibemapa.visible = true;
        }

        pipeTimer = 0;
    }

    if (controls.ACCEPT && canDoShit){
        canDoShit = false;
        pibemapa.animation.play("start", true);
        FlxG.sound.music.fadeOut(0.5, 0);
        FlxG.sound.play(Paths.sound("warpzone/smw_feather_get")); // prob not the right sound
        FlxTween.tween(FlxG.camera, {alpha: 0}, 1.25);
        FlxG.camera.addShader(pixel);
        pixelTween = FlxTween.num(0, 40, 1.25, {onUpdate: (_) -> {
            pixel.data.uBlocksize.value = [pixelTween.value, pixelTween.value];
        }});
        pixelTween.onComplete = function(){
            wasInWarpState = true;
            PlayState.loadSong("golden-land", "golden-land");
            FlxG.switchState(new PlayState());
        };
    }

    if (FlxG.keys.pressed.RIGHT){
        pibemapa.animation.play("right");
        pibemapa.x += bfSpeed;
    }else if (FlxG.keys.pressed.LEFT){
        pibemapa.animation.play("left");
        pibemapa.x -= bfSpeed;
    }else pibemapa.animation.play("idle");
}