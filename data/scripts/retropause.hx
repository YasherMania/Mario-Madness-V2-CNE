import flixel.text.FlxText;
import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxAxes;
import funkin.backend.scripting.events.MenuChangeEvent;
import funkin.backend.scripting.events.NameEvent;
import funkin.backend.scripting.EventManager;
import PlayState;
import flixel.tweens.FlxTweenType;

var pauseCam = new FlxCamera();
var menuItems:Array<String> = ['Resume', 'Restart', 'Botplay','Exit'];
var curSelected:Int = 0;
var grpMenuShit = new FlxTypedGroup();
var ispixel:Array<String> = ['', '500', '150', '130', '3.71', '-4', '395'];
var canDoShit = true;
var num:NumTween;
var arrowOff:Int = 0;
var arrowX:Int = 760;
var arrowTime = 0;

function create(event) {
    event.cancel();
    event.music = "mario-time" + Std.string(FlxG.random.int(1,3));
    FlxG.sound.play(Paths.sound("menu/pauseb"));
    PlayState.allowGitaroo = false;

    if (menuItems.contains("Botplay") && PlayState.isStoryMode) {
		menuItems.remove("Botplay");
	}

    cameras = [];

    FlxG.cameras.add(pauseCam, false);
    pauseCam.bgColor = 0x88000000;
    pauseCam.alpha = 0;

    somaridesc = new FlxSprite(260, 60).loadGraphic(Paths.image('menus/pausemenu/pixel/imtiredofthisfuckingmenu'));
    somaridesc.setGraphicSize(Std.int(somaridesc.width * 1.15));
    somaridesc.alpha = 0;
    add(somaridesc);

    descArrow = new FlxSprite(arrowX, 350).loadGraphic(Paths.image('menus/pausemenu/pixel/arrow'));
    descArrow.setGraphicSize(Std.int(descArrow.width * 3.71));
    descArrow.alpha = 0;
    descArrow.angle = 0;
    add(descArrow);

    bg = new FlxSprite(-400,Std.parseFloat(ispixel[4])).loadGraphic(Paths.image("menus/pausemenu/pixel/momichiPIXEL"));
    bg.scale.set(5,5);
    bg.screenCenter(FlxAxes.Y);
    bg.cameras = [pauseCam];
    bg.alpha = 0;
    add(bg);

	add(grpMenuShit);

    for (i in 0...menuItems.length) {
        var option = menuItems[i];
        var offset:Float = (88 - (Math.max(menuItems.length, 4) - 4) * 80) - (Std.parseFloat(ispixel[4]) * 5);
        var theY:String = ispixel[6];
        if(menuItems.contains("Botplay")) theY = ispixel[2];
        var button = new FlxSprite(-235, ((i * 175) + offset - 50)); //25
        button.scale.set(5,5);
        button.alpha = 0;
        button.frames = Paths.getFrames('menus/pausemenu/pixel/'+ option + "Pixel");
        button.animation.addByPrefix("idle", option + " basic", 24, false);
        button.animation.addByPrefix("Selected", option + " press", 24, false);
        button.animation.play("idle");
        button.ID = i;
        button.setGraphicSize(Std.int(button.width * (0.5 + ((Std.parseFloat(ispixel[3]) * 0.8) * Std.parseFloat(ispixel[5])))));
        grpMenuShit.add(button);
        button.antialiasing = false;
        button.updateHitbox();
    }

    botplaytxt = new FlxText(1150,690,0,"Botplay", 17);
    botplaytxt.alpha = FlxG.save.data.botplayOption ? 1 : 0;
    botplaytxt.setFormat(Paths.font("marioNES.ttf"), 17);
    add(botplaytxt);

    FlxTween.tween(bg, {x: -420 + Std.parseFloat(ispixel[1])}, 0.2, {ease: FlxEase.backOut});
    FlxTween.tween(bg, {alpha: 1}, 0.4, {ease: FlxEase.quartOut});
    FlxTween.tween(descArrow, {alpha: 1}, 0.4, {ease: FlxEase.quartOut});
    FlxTween.tween(somaridesc, {alpha: 0.5}, 0.4, {ease: FlxEase.quartOut});
    for (i in grpMenuShit.members) {
        FlxTween.tween(i, {x:45}, 0.2, {ease:FlxEase.quartOut});
        FlxTween.tween(i, {alpha: 1}, 0.4, {ease: FlxEase.quartOut});
    }

    changeSelection();
    cameras = [pauseCam];
}

function update(elasped:Float) {
    pauseCam.alpha = lerp(pauseCam.alpha, 1, 0.25);
    arrowTime += elasped;

    if(arrowTime > 0.5){
        if(descArrow.x == arrowX + arrowOff){
            descArrow.x = (arrowX - 10) + arrowOff;
        }else{
            descArrow.x = arrowX + arrowOff;
        }
        arrowTime = 0;
    }

    if (controls.RIGHT_P) {
        FlxTween.tween(bg, {x:-400}, 0.2, {ease:FlxEase.quartOut});
        FlxTween.tween(bg, {alpha: 0}, 0.4, {ease: FlxEase.quartOut});
        for (i in grpMenuShit.members) {
            FlxTween.tween(i, {x:-252}, 0.2, {ease:FlxEase.quartOut});
            FlxTween.tween(i, {alpha: 0}, 0.4, {ease: FlxEase.quartOut});
        }
        FlxTween.tween(somaridesc, {alpha: 1}, 0.4, {ease: FlxEase.quartOut});
        descArrow.flipX = true;
        canDoShit = false;
        arrowX = 280;
    }

    if (controls.LEFT_P) {
        FlxTween.tween(bg, {x: -420 + Std.parseFloat(ispixel[1])}, 0.2, {ease: FlxEase.backOut});
        FlxTween.tween(bg, {alpha: 1}, 0.4, {ease: FlxEase.quartOut});
        for (i in grpMenuShit.members) {
            FlxTween.tween(i, {x:45}, 0.2, {ease:FlxEase.quartOut});
            FlxTween.tween(i, {alpha: 1}, 0.4, {ease: FlxEase.quartOut});
        }
        FlxTween.tween(somaridesc, {alpha: 0.5}, 0.4, {ease: FlxEase.quartOut});
        descArrow.flipX = false;
        canDoShit = true;
        arrowX = 760;
    }

    if (!canDoShit) return;
    if (controls.DOWN_P) {
        changeSelection(1, false);
    }
    if (controls.UP_P) {
        changeSelection(-1);
    }
    if (controls.ACCEPT) {
        var option = menuItems[curSelected];
        if (option == "Resume" || option == "Exit") {
            canDoShit == false;
            FlxTween.tween(bg, {x:-400}, 1, {ease:FlxEase.circOut});
            for (i in grpMenuShit.members) {
                FlxTween.tween(i, {x:-252}, 1, {ease:FlxEase.circOut});
            }
            FlxTween.tween(bg, {alpha: 0}, 0.125, {ease: FlxEase.cubeOut, onComplete: function() {
                selectOption();
            }});
        } else if (option == "Restart") {
            canDoShit = false;
            blink();
            FlxG.sound.play(Paths.sound("menu/restart"));
                new FlxTimer().start(1, () -> {selectOption();}, 1);
        } else if (option == "Botplay") {
            selectOption();
            new FlxTimer().start(0.2, () -> {grpMenuShit.members[curSelected].animation.play("idle");}, 1);
        }
    }
}

function blink() {
    num = FlxTween.num(1, 0, 0.1, {ease:FlxEase.circInOut, type: FlxTweenType.PINGPONG, onUpdate: (_) -> {
        grpMenuShit.members[curSelected].alpha = num.value;
        if (num.value) grpMenuShit.members[curSelected].animation.play("Selected");
        if (num.value == 1) grpMenuShit.members[curSelected].animation.play("idle");
    }});
}

function selectOption() {
	var event = EventManager.get(NameEvent).recycle(menuItems[curSelected]);

	if (event.cancelled) return;

	var daSelected:String = event.name;

	switch (daSelected) {
		case "Resume":
			close();
		case "Restart":
			parentDisabler.reset();
			PlayState.instance.registerSmoothTransition();
			FlxG.resetState();
		case "Botplay":
            FlxG.save.data.botplayOption = !FlxG.save.data.botplayOption;
            botplaytxt.alpha = FlxG.save.data.botplayOption ? 1 : 0;
		case "Exit":
			CoolUtil.playMenuSong();
			FlxG.switchState(PlayState.isStoryMode ? new StoryMenuState() : new FreeplayState());
	}
}

function changeSelection(change:Int = 0) {
	var event = EventManager.get(MenuChangeEvent).recycle(curSelected, FlxMath.wrap(curSelected + change, 0, menuItems.length-1), change, change != 0);
	if (event.cancelled) return;
    
    FlxG.sound.play(Paths.sound("menu/scroll"));

	curSelected = event.value;

	var bullShit:Int = 0;

	for (item in grpMenuShit.members) {
		item.ID = bullShit - curSelected;
		bullShit++;
        if (item.ID == 0) {
            item.animation.play("Selected");
            item.alpha = 1;
            item.color = 0xFFFFFFFF;
        } else {
            item.animation.play("idle");
            item.alpha = 0.9;
            item.color = 0xFF878282;
        }
	}
}