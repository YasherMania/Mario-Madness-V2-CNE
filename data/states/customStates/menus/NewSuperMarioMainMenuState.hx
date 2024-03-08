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
import flixel.tweens.FlxTween.FlxTweenType;
import flixel.group.FlxTypedSpriteGroup;
import flixel.math.FlxPoint;

static var currentLevel:Int = 1;
static var curSelected:Int = 0;
var canselectshit = true;
var selectedSomethin = false;
var lerpCamZoom = false;
var smOpen = false;
var optionShit:Array<String> = ["MainGame", "WarpZone", "Freeplay", "Options", "Credits"];
var WEHOVERING:Bool = false;
var corners:Array<FlxSprite> = [];
var curButton:FlxSprite = null;
var  menuGroups:Array<FlxTypedSpriteGroup<FlxSprite>>;
var stars = new FlxTypedGroup();
var cornerOffset:NumTween;
public var canAccessDebugMenus:Bool = true;
var starData = [1,2,3,4];
var unlocked:Int = 0;
var storySave = [1,2,3,4];

// shader stuff
var ntsc:CustomShader = null;
var bloom:CustomShader = null;

var menuInfo:Array<{group:Null<FlxTypedSpriteGroup<FlxSprite>>, choices:Array<String>, res:FlxPoint, scroll:FlxPoint}> = [
    {
        group: null,
        choices: ["Patch"],
        res: FlxPoint.get(555, 88.05),
        scroll: FlxPoint.get(1, .7)
    },
    {
        group: null,
        choices: ["MainGame"],
        res: FlxPoint.get(271, 275.5),
        scroll: FlxPoint.get(1.4, .95)
    },
    {
        group: null,
        choices: ["Options", "Credits"],
        res: FlxPoint.get(390, 131.05),
        scroll: FlxPoint.get(1, .7)
    }
];

var menuLevelPostions = [
    0 => [FlxPoint.get(1280 / 1.85, 5), 0],
    1 => [FlxPoint.get(1280 / 2.62, 170), 10],
    2 => [FlxPoint.get((1280 / 6.6) + 0.05, 520), 40]
];
Framerate.fpsCounter.visible = true;
Framerate.memoryCounter.visible = true;
Framerate.codenameBuildField.visible = true;

window.resizable = true;

function new() if (FlxG.sound.music == null || !FlxG.sound.music.playing) CoolUtil.playMenuSong();

function create() {

    if(storySave[4] || storySave[0]){
        menuInfo[1].choices.insert(1, "Freeplay");
        menuLevelPostions[1][0].x -= 149.75;
    }
    if (storySave[0]) {
        menuInfo[1].choices.insert(1, "WarpZone");
        menuLevelPostions[1][0].x -= 149.75;
    }

    bg = new FlxBackdrop(Paths.image('menus/mainmenu/bgs/bg0'), FlxAxes.X);
    bg.scale.set(3.4,3.4);
    bg.velocity.set(-50, 0);
    bg.y = 250;
    add(bg);

    bgFP = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/mainmenu/HUD_Freeplay_2'));
    bgFP.scale.set(1.4, 1.4);
    bgFP.antialiasing = true;
    bgFP.updateHitbox();
    bgFP.screenCenter(FlxAxes.XY);
    bgFP.alpha = 0;
    bgFP.scrollFactor.set(0, 0);
    bgFP.color = 0x00FF0000;
    add(bgFP);

    estatica = new FlxSprite();
    estatica.frames = Paths.getFrames('menus/estatica_uwu');
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

    for (info in menuInfo) {
		var levelIdx = menuInfo.indexOf(info);

		if (info.choices == [])
			continue;

		info.group = new FlxTypedSpriteGroup();
		info.group.scrollFactor.set(info.scroll.x, info.scroll.y);

		for (choice in info.choices) {
			var menuIdx = info.choices.indexOf(choice);

		    var button:FlxSprite = new FlxSprite();
			button.frames = Paths.getFrames("menus/mainmenu/MM_Menu_Assets");
			button.animation.addByPrefix("idle", choice + "Normal", 30, true); // Selected
			button.animation.addByPrefix("selected", choice + "Selected", 30, true); // Selected
			button.animation.play("idle");
				

			button.updateHitbox();
			button.setPosition((button.width * menuIdx) + (menuLevelPostions[levelIdx][1] * menuIdx), 0);

			button.ID = menuIdx;
			info.group.add(button);
		}
        add(info.group);

		var pos:FlxPoint = menuLevelPostions[levelIdx][0];

		if (pos.x == -1) {
            info.group.screenCenter(FlxAxes.X);
        } else {
			info.group.x = pos.x;
        }
        if (pos.y == -1) {
			info.group.screenCenter(FlxAxes.Y);
        } else {
            info.group.y = pos.y;
        }
        pos.put();
	}

    for (i in 1...5) {
        var corner:FlxSprite = new FlxSprite();
        corner.frames = Paths.getFrames("menus/mainmenu/MM_Menu_Assets");
        corner.animation.addByPrefix("idle", 'Corner' + i, 24);
        corner.animation.play("idle");

        corner.updateHitbox();
        corner.visible = false;
        corner.ID = i - 1;

        add(corner);

        corners.push(corner);
    }

    cornerOffset = FlxTween.num(0, 7.5, 1.5, {
        ease: FlxEase.circInOut,
        type: FlxTweenType.PINGPONG,
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
    });
    add(stars);
    for (i in 0...starData.length) {
        var star:FlxSprite = new FlxSprite();
        star.frames = Paths.getSparrowAtlas("menus/mainmenu/MM_Menu_Assets");
        star.animation.addByPrefix("idle", "Star", 30, true);
        star.animation.play("idle");

        star.updateHitbox();
        star.y += star.height * i;
        star.x -= star.width;
        star.alpha = 0;
        star.visible = false;
        star.screenCenter(FlxAxes.Y);

        if (starData[i]) {
            star.visible = true;
            star.ID = i;

            FlxTween.tween(star, {x: Math.PI, alpha: 0.9}, 1, {
                ease: FlxEase.circOut,
                startDelay: 0.15 * unlocked,
                onComplete: (_) -> {
                    FlxTween.tween(star.offset, {y: 7.5}, 1.5, {type: FlxTweenType.PINGPONG, loopDelay: 0.25});
                }
            });
            unlocked++;
        }

        star.scrollFactor.set(0.6, 1);
        stars.add(star);
    }

    menuGroups = [for (info in menuInfo) info.group];

    changeItem();
    //FlxG.camera.zoom += 0.1;

    ntsc = new CustomShader("NTSCGlitch");
    ntsc.data.glitchAmount.value = [0.4, 0.4];
    FlxG.camera.addShader(ntsc);

    bloom = new CustomShader("Bloom");
    bloom.data.Size.value = [1, 1];
    bloom.data.dim.value = [.5, .5];
    FlxG.camera.addShader(bloom);
}

function destroy() {
    FlxG.camera.removeShader(bloom);
    FlxG.camera.removeShader(ntsc);
}

var fullTimer:Float = 0;
function update(elapsed:Float) {
    fullTimer += elapsed;

    if (FlxG.sound.music.volume < 0.8 && !selectedSomethin)
        FlxG.sound.music.volume += 0.5 * FlxG.elapsed;

    FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.screenX-(FlxG.width/2)) * 0.015, (1/30)*240*elapsed);
    FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.screenY-6-(FlxG.height/2)) * 0.015, (1/30)*240*elapsed);

    if (lerpCamZoom) { // stealing your supa code lunar sorry - Yasher
        FlxG.camera.zoom = FlxMath.lerp(
            FlxG.camera.zoom, camZoomMulti * (.98 - 
            (Math.abs(((FlxG.mouse.screenX*0.4) + 
            (FlxMath.remapToRange(FlxG.mouse.screenY, 0, FlxG.height, 0, FlxG.width)*0.6))
            -(FlxG.width/2)) * 0.00002)), 
        (1/30)*240*elapsed);

        fog.scale.set(1/FlxG.camera.zoom, 1/FlxG.camera.zoom);
        estatica.scale.set(1/FlxG.camera.zoom, 1/FlxG.camera.zoom);
    }

    WEHOVERING = false;
    if(canselectshit){
        for (group in menuGroups) {
            if (group == null) continue;

            var hovering:Bool = false;
            group.forEach((button) -> {
                var groupLevel:Int = findGroupLevel(group);

                button.offset.y = 8*(Math.floor(8 * FlxMath.fastSin((fullTimer/2) + ((.5*button.ID)+(2*groupLevel))))/8);
                button.offset.x = 4*(Math.floor(8 * FlxMath.fastSin((fullTimer/8) + ((2/8)*groupLevel)))/8);

                if (FlxG.mouse.overlaps(button)) {
                    hovering = WEHOVERING = true;
                    
                    if ((currentLevel != groupLevel) || (curSelected != button.ID)) {
                        currentLevel = groupLevel;
                        changeLevel(0, false);

                        curSelected = button.ID;
                        changeItem(0, false);

                        FlxG.sound.play(Paths.sound('menu/scroll'));
                    }
                }
            });

            if (FlxG.mouse.justReleased && hovering && canSelectSomethin) trace("wowie this works insane!!!"); //goToState();
        }	
    }
    if (curButton != null) postionCorners(curButton);

    if (controls.BACK) {
        FlxG.switchState(new MainMenuState());
    }
    if (ntsc != null) ntsc.data.time.value = [fullTimer, fullTimer];
}

function findGroupLevel(grp:FlxTypedSpriteGroup<FlxSprite>):Int {
    for (info in menuInfo) {
        if (info.group == grp)
            return menuInfo.indexOf(info);
    }
    return 0;
}

function changeItem(?huh:Int = 0, ?arrowCheck:Bool = true) {
    curSelected += huh;

    if (arrowCheck) {
        if (curSelected >= menuInfo[currentLevel].group.length)
            curSelected = 0;
        if (curSelected < 0)
            curSelected = menuInfo[currentLevel].group.length - 1;
    }

    for (group in menuGroups) {
        group.forEachAlive((_) -> {
            if (findGroupLevel(group) == currentLevel && _.ID == curSelected) {
                _.animation.play("selected", true);
                curButton = _;
                postionCorners(_);
            }
            else
                _.animation.play("idle", true);
        });
    }
}

function changeLevel(?duh:Int = 0, ?arrowCheck:Bool = true) {
    var lastGroup = menuGroups[currentLevel];

    currentLevel += duh;

    if (arrowCheck) {
        if (currentLevel >= menuInfo.length)
            currentLevel = 0;
        if (currentLevel < 0)
            currentLevel = menuInfo.length - 1;

        
        if (curSelected == lastGroup.members.length-1) {
            curSelected = menuGroups[currentLevel].members.length-1;
        }
    }

    changeItem();
}

function postionCorners(obj:FlxSprite, ?space:FlxPoint) {
    if (space == null)
        space = FlxPoint.get(12.5, 12.5);

    var res:FlxPoint = menuInfo[currentLevel].res;
    var postions = [
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
}