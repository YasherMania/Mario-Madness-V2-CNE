function new() FlxG.sound.playMusic(Paths.music('creditsmenu'), 1);

function create(){
    bg = new FlxSprite(0, 0).loadGraphic(Paths.image('freeplay/HUD_Freeplay_2'));
    bg.updateHitbox();
    bg.screenCenter();
    bg.color = FlxColor.RED;
    bg.scrollFactor.set(0, 0);
    add(bg);

    estatica = new FlxSprite();
    estatica.frames = Paths.getSparrowAtlas('menus/mainmenu/estatica_uwu');
    estatica.animation.addByPrefix('idle', "Estatica papu", 15);
    estatica.animation.play('idle');
    estatica.antialiasing = false;
    estatica.color = FlxColor.RED;
    estatica.alpha = 0.3;
    estatica.scrollFactor.set(0, 0);
    estatica.updateHitbox();
    add(estatica);

    bg2 = new FlxSprite(0, 0).loadGraphic(Paths.image('credits/credits1'));
    bg2.updateHitbox();
    bg2.screenCenter();
    bg2.scrollFactor.set(0, 0);
    add(bg2);
}

function update(){
    if (controls.BACK){
        FlxG.sound.play(Paths.sound("menu/cancel"));
        FlxTween.tween(FlxG.sound.music, {volume: 0}, .35).onComplete = function(){
            FlxG.sound.music.stop();
        }
        FlxTween.tween(FlxG.camera, {alpha: 0}, .5).onComplete = function(){
            FlxG.switchState(new MainMenuState());
        }
    }
}