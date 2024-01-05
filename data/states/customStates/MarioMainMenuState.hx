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

var mainMenuOptions:Map<String, FlxState> = [
    'MainGame' => new StoryMenuState(),
    'WarpZone' => new MainMenuState(),
    'Freeplay' => new FreeplayState(),
    'Options' => new OptionsMenu(),
    'Credits' => new CreditsMain()
];

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
        var itemPos:Map<String, {x:Float, y:Float}> = [
            'MainGame' => {x: 217, y: 134},
            'Options' => {x: 217, y: 478},
            'Credits' => {x: 641, y: 478},
            'Freeplay' => {x: 828, y: 134},
            'WarpZone' => {x: 524, y: 134}           
        ];

        var menuItem = new FlxSprite(itemPos.get(optionShit[i]).x, itemPos.get(optionShit[i]).y);
        menuItem.frames = Paths.getFrames('menus/mainmenu/MM_Menu_Assets');
        menuItem.animation.addByPrefix('idle', optionShit[i] + 'Normal', 24, false);
        menuItem.animation.addByPrefix('selected', optionShit[i] + 'Selected', 24, false);
        menuItem.animation.addByPrefix('Star', 'Star', 24, false);
        menuItem.animation.play('idle');
		menuItem.ID = i;
        menuItems.add(menuItem);
        menuItem.scrollFactor.set();
        menuItem.antialiasing = true;
        menuItem.updateHitbox();
    }
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
      
        for (spr in menuItems.members)
        {
            if (FlxG.mouse.overlaps(spr))
            {
                // var event = event("onChangeItem", EventManager.get(MenuChangeEvent).recycle(curSelected, FlxMath.wrap(curSelected + huh, 0, menuItems.length-1), huh, huh != 0));
                // if (event.cancelled) return;

                if (curSelected != spr.ID)
                {
                	FlxG.sound.play(Paths.sound("menu/scroll"));
                
                    curSelected = spr.ID;
                }

                if (curSelected == spr.ID)
                {
                    spr.animation.play('selected', true);

                    if (FlxG.mouse.justPressed)
                    {
                        selectedSomethin = true;

                        var daChoice:String = optionShit[curSelected];

						trace(daChoice);
                        
                        FlxG.sound.play(Paths.sound('menu/confirm'));
                        FlxG.switchState(mainMenuOptions.get(daChoice)); 
                    }
                }
            }
            else
                spr.animation.play('idle', true);
            
        }
    }
}

//i tried to use in map but it dont works so
//nvm
// function getState(selectedString:String)
// {
// 	var state:FlxState = null;
// 	switch (selectedString)
// 	{
// 		case 'MainGame':
// 			state = new StoryMenuState();
// 		case 'WarpZone':
// 			state = new MainMenuState();
// 		case 'Freeplay':
// 			state = new FreeplayState();
// 		case 'Options':
// 			state = new OptionsMenu();
// 		case 'Credits':
// 			state = new CreditsMain();
// 		default:
// 			state = new FreeplayState();
// 	}

// 	return state;
// }