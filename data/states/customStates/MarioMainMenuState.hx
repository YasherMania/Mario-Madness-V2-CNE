import funkin.backend.utils.DiscordUtil;
import funkin.backend.scripting.events.DiscordPresenceUpdateEvent;
import discord_rpc.DiscordRpc;
import funkin.menus.MainMenuState;
import funkin.backend.scripting.events.MenuChangeEvent;
import funkin.backend.scripting.events.NameEvent;
import funkin.backend.scripting.EventManager;
import funkin.menus.credits.CreditsMain;
import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import flixel.effects.FlxFlicker;
import flixel.addons.display.FlxBackdrop;
import funkin.backend.utils.CoolUtil;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import funkin.backend.system.framerate.Framerate;

var optionShit:Array<String> = ["MainGame", "WarpZone", "Freeplay", "Options", "Credits"];
var curSelected:Int = 0;
var menuItems:FlxTypedGroup<FlxSprite>;
var menuItems = new FlxTypedGroup();
var magenta:FlxSprite;
public var canAccessDebugMenus:Bool = true;

FlxG.mouseControls = true;
FlxG.mouse.enabled = true;
FlxG.mouse.visible = true;

Framerate.fpsCounter.visible = true;
Framerate.memoryCounter.visible = true;
Framerate.codenameBuildField.visible = true;

window.resizable = true;

function create() {
    CoolUtil.playMenuSong();
    window.title = "Friday Night Funkin: Mario's Madness V2";
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
    changeItem();
}

var selectedSomethin:Bool = false;

function update(elapsed:Float) {
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
    }
}

function selectItem() {
    selectedSomethin = true;

	FlxG.sound.play(Paths.sound('menu/confirm'));

    if (Options.flashingMenu) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

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
                FlxG.switchState(new OptionsMenu());
            case 'Credits':
                FlxG.switchState(new CreditsMain());
        }
    });
}

function changeItem(huh:Int = 0) {
    var event = event("onChangeItem", EventManager.get(MenuChangeEvent).recycle(curSelected, FlxMath.wrap(curSelected + huh, 0, menuItems.length-1), huh, huh != 0));
    if (event.cancelled) return;

    curSelected = event.value;

    if (event.playMenuSFX)
        CoolUtil.playMenuSFX("SCROLL", 0.7);

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