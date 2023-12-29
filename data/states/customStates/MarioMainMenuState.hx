import funkin.backend.utils.DiscordUtil;
import funkin.backend.scripting.events.DiscordPresenceUpdateEvent;
import discord_rpc.DiscordRpc;
import funkin.menus.MainMenuState;
import funkin.backend.scripting.events.MenuChangeEvent;
import funkin.backend.scripting.events.NameEvent;
import funkin.backend.scripting.EventManager;
import funkin.menus.credits.CreditsMain;
import funkin.backend.system.framerate.Framerate;
import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import flixel.math.FlxPoint;
import flixel.effects.FlxFlicker;
import flixel.addons.display.FlxBackdrop;
import funkin.backend.utils.CoolUtil;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;

var optionShit:Array<String> = ["MainGame", "WarpZone", "Freeplay", "Options", "Credits"];
var curSelected:Int = 0;
var menuItems:FlxTypedGroup<FlxSprite>;
var menuItems = new FlxTypedGroup();
var magenta:FlxSprite;

public var canAccessDebugMenus:Bool = true;
public var WEHOVERING:Bool = false;

public var corners:Array<FlxSprite> = [];

FlxG.mouseControls = true;
FlxG.mouse.enabled = true;
FlxG.mouse.visible = true;

Framerate.fpsCounter.visible = true;
Framerate.memoryCounter.visible = true;
Framerate.codenameBuildField.visible = true;

window.resizable = true;

function create() {
    CoolUtil.playMenuSong();
    window.title = "Friday Night Funkin': Mario's Madness";

    bg = new FlxBackdrop(Paths.image('menus/mainmenu/bgs/bg0'));
    bg.scale.set(3.4,3.4);
    bg.velocity.set(-50, 0);
    bg.y = 250;
    add(bg);

    estatica = new FlxSprite();
    estatica.frames = Paths.getFrames('menus/mainmenu/estatica_uwu');
    estatica.animation.addByPrefix('idle', "Estatica papu", 15);
    estatica.animation.play('idle');
    estatica.antialiasing = false;
    estatica.color = FlxColor.RED;
    estatica.alpha = 0.7;
    estatica.scrollFactor.set();
    estatica.updateHitbox();
    add(estatica);

    fog = new FlxSprite().loadGraphic(Paths.image('menus/mainmenu/126'));
    fog.alpha = 0.9;
    fog.scrollFactor.set();
    fog.updateHitbox();
    fog.screenCenter();
    add(fog);

    magenta = new FlxSprite(0).makeSolid(FlxG.width, FlxG.height, FlxColor.TRANSPARENT);
    magenta.visible = false;
    add(magenta);

    add(menuItems);
    for (i in 0...optionShit.length) {
        var option = optionShit[i];
        var menuItem = new FlxSprite(171,120);
        menuItem.frames = Paths.getFrames('menus/mainmenu/MM_Menu_Assets');
        menuItem.animation.addByPrefix('idle', option + 'Normal', 24, false);
        menuItem.animation.addByPrefix('selected', optionShit[i] + 'Selected', 24, false);
        menuItem.animation.addByPrefix('Star', 'Star', 24, false);
        menuItem.animation.play('idle');
        menuItem.ID = i;
        menuItems.add(menuItem);
        menuItem.scrollFactor.set();
        menuItem.antialiasing = true;
        menuItem.updateHitbox();
    }
    menuItems.members[1].x = 480;
    menuItems.members[2].x = 800;
    menuItems.members[4].y = 480;
    menuItems.members[4].x = 650;
    menuItems.members[3].y = 480;

    // i will try to add this later its really puzzling me rn - apurples
    /* for (i in 1...5) {
        var corner:FlxSprite = new FlxSprite();
        corner.frames = Paths.getSparrowAtlas("mainmenu/MM_Menu_Assets");
        corner.animation.addByPrefix("idle", 'Corner$i', 24);
        corner.animation.play("idle");

        corner.updateHitbox();
        corner.visible = false;
        corner.ID = i - 1;

        add(corner);

        corners.push(corner);
    }

    cornerOffset = FlxTween.num(0, 7.5, 1.5, {
        ease: FlxEase.circInOut,
        type: 5, // pingpong
        onUpdate: (_) -> {
            for (corner in corners) {
                if (corner != null) {
                    switch (corner.ID) {
                        case 0:
                            corner.offset.set(cornerOffset.value, cornerOffset.value);
                        case 1:
                            corner.offset.set(-cornerOffset.value, cornerOffset.value);
                        case 2:
                            corner.offset.set(cornerOffset.value, -cornerOffset.value);
                        case 3:
                            corner.offset.set(-cornerOffset.value, -cornerOffset.value);
                    }
                }
            }
        }
    }); */

    changeItem();
}

var selectedSomethin:Bool = false;

function update(elapsed:Float) {
    FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.screenX-(FlxG.width/2)) * 0.015, (1/30)*240*elapsed);
	FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.screenY-6-(FlxG.height/2)) * 0.015, (1/30)*240*elapsed);

    if (FlxG.sound.music.volume < 0.8)
        FlxG.sound.music.volume += 0.5 * elapsed;

    if (!selectedSomethin) {
        if (canAccessDebugMenus) {
            if (FlxG.keys.justPressed.SEVEN) {
                persistentUpdate = false;
                persistentDraw = true;
                openSubState(new EditorPicker());
            }
        }
        if (controls.SWITCHMOD) {
            openSubState(new ModSwitchMenu());
            persistentUpdate = false;
            persistentDraw = true;
        }
        if (controls.UP_P)
            changeItem(-1);

        if (controls.DOWN_P)
            changeItem(1);

        if (controls.ACCEPT)
        {
            selectItem();
        }

        // if (curSelected != null) postionCorners(curSelected);
    }

	if (!selectedSomethin){
		for (i in menuItems.members){
			if (FlxG.mouse.overlaps(i)){
				curSelected = menuItems.members.indexOf(i);
				changeItem();

                if (FlxG.mouse.justPressed) selectItem();
			}
		}
    }
}

function selectItem() {
    selectedSomethin = true;

	FlxG.sound.play(Paths.sound('menu/confirm'));

    if (Options.flashingMenu) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

    FlxTween.tween(menuItems.members[curSelected], {x: 480, y: 200}, .6, {ease: FlxEase.circOut});

    FlxFlicker.flicker(menuItems.members[curSelected], 1, Options.flashingMenu ? 0.06 : 0.15, false, false, function(flick:FlxFlicker)
    {
        var daChoice:String = optionShit[curSelected];

        var event = event("onSelectItem", EventManager.get(NameEvent).recycle(daChoice));
        if (event.cancelled) return;
        switch (daChoice)
        {
            case 'MainGame':
                FlxG.switchState(new StoryMenuState());
            case 'WarpZone':
                FlxG.switchState(new MainMenuState());
            case 'Freeplay':
                FlxG.switchState(new FreeplayState());
            case 'Options':
                FlxG.sound.music.fadeOut(0.5, 0);
                FlxG.switchState(new OptionsMenu());
            case 'Credits':
                FlxG.switchState(new CreditsMain());
        }
    });
}

function changeItem(huh:Int = 0) {
    var event = event("onChangeItem", EventManager.get(MenuChangeEvent).recycle(curSelected, FlxMath.wrap(curSelected + huh, 0, menuItems.length-1), huh, huh != 0));
    if (event.cancelled) return;

    // if (event.playMenuSFX) CoolUtil.playMenuSFX("SCROLL", 0.7); sound goes kinda wonky so im commenting this for now - apurples

    curSelected = event.value;

    menuItems.forEach(function(spr:FlxSprite) {
    spr.animation.play('idle');
        
    if (spr.ID == curSelected) {
        spr.animation.play('selected');
        var mid = spr.getGraphicMidpoint();
        mid.put();
    }

    spr.updateHitbox();
    spr.centerOffsets();
});
}

/* function postionCorners(obj:FlxSprite, ?space:FlxPoint) {
    if (space == null)
        space = FlxPoint.get(12.5, 12.5);

    var res:FlxPoint = menuInfo[currentLevel].res;
    var postions:Map<Int, FlxPoint> = [
        0 => FlxPoint.get((obj.x-obj.offset.x) - space.x, (obj.y-obj.offset.y) - space.y),
        1 => FlxPoint.get(((obj.x-obj.offset.x) + res.x) + space.x, (obj.y-obj.offset.y) - space.y),
        2 => FlxPoint.get((obj.x-obj.offset.x) - space.x, ((obj.y-obj.offset.y) + res.y) + space.y),
        3 => FlxPoint.get(((obj.x-obj.offset.x) + res.x) + space.x, ((obj.y-obj.offset.y) + res.y) + space.y)
    ];

    for (corner in corners) {
        if (corner == null)
            continue;

        var postion:FlxPoint = postions[corner.ID];

        if (postion == null)
            continue;

        corner.setPosition(postion.x, postion.y);
        corner.visible = true;

        switch (corner.ID) // I swear im not weird - lunar
        {
            case 1:
                corner.x -= corner.width / 1.9;
            case 2:
                corner.y -= corner.height / 1.75;
            case 3:
                corner.x -= corner.width / 1.9;
                corner.y -= corner.height / 1.75;
        }

        postion.put();
    }

    space.put();
} */