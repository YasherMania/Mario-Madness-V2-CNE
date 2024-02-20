// mhm

import flixel.text.FlxText.FlxTextAlign;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.text.FlxText.FlxTextFormat;

public var camEst:FlxCamera;
function create() {
    camEst = new FlxCamera();
    camEst.bgColor = 0x00000000;
    FlxG.cameras.add(camEst, false);

    //disableIcons = true;
}

public var iconSys:HealthIcon; // sys guy
public var iconHunter:HealthIcon; // hunter
public var iconBowser:HealthIcon; // bowser
public var iconOrder:Array<HealthIcon> = [];
public var iconMap:Map<String, HealthIcon> = [];
public var iconPos:Array<Array<Int>> = [
    [0, 0],
    [-85, 50],
    [-85, -50]
];

public var vcr:CustomShader;
public var border:CustomShader;
public var beatend:CustomShader;
public var angel:CustomShader;
function postCreate() {
    multipleIcons = true;

    iconSys = new HealthIcon("sys", false);
    iconHunter = new HealthIcon("hunt", false);
    iconBowser = new HealthIcon("bowser", false);
    iconOrder = [iconSys, iconHunter, iconBowser];
    iconMap = ["mrSYS" => iconSys, "hunter" => iconHunter, "koopa" => iconBowser];
    iconP2.visible = false;

    for (i in [iconBowser, iconHunter, iconSys]) {
        i.cameras = [camHUD];
        insert(members.indexOf(iconP2), i);
        if (i != iconSys) i.visible = false;
    }

    // for (i in [scoreTxt, missesTxt, accuracyTxt]) {
    //     i.color = FlxColor.RED;
    //     i.font = Paths.font("mariones.ttf");
    //     i.size = i.size-5;
    // }

    vcr = new CustomShader("VCRMario85");
    border = new CustomShader("VCRBorder");
    beatend = new CustomShader("YCBUEndingShader");
    angel = new CustomShader("angel");
    angel.data.pixel.value = [1, 1];
    angel.data.stronk.value = [1, 1];

    if (FlxG.save.data.tvShader) for (i in [camGame, camHUD, camEst]) {
        i.addShader(vcr);
        i.addShader(border);
    }

    // camGame.addShader(beatend); TODO: ewww
    camGame.addShader(angel);
    camEst.addShader(angel);
}

function update(elapsed:Float) {
    if (angel != null) {
        angel.data.stronk.value[0] = FlxMath.lerp(angel.data.stronk.value[0], 0, FlxMath.bound(elapsed * 8, 0, 1));
        angel.data.pixel.value[0] = FlxMath.lerp(angel.data.pixel.value[0], 1, FlxMath.bound(elapsed * 4, 0, 1));
        angel.data.iTime.value = [Conductor.songPosition / 1000];
    }

    if (startingSong || !canPause || paused || health <= 0) return;
    updateSpeed(FlxG.keys.pressed.TWO);

    if (FlxG.keys.pressed.THREE)
        player.cpu = true;
}

// this is here just for testing reasons LOL, will remove when port is fully finished - apurples
function updateSpeed(fast:Bool) {
    if (!PlayState.opponentMode) {
        FlxG.timeScale = inst.pitch = vocals.pitch = (player.cpu = fast) ? 20 : 1;
        FlxG.sound.muted = fast;
        health = !(canDie != fast) ? 2 : health;
    }
}

function postUpdate() {
    healthBar.updateHitbox();
    for (i in [iconSys, iconHunter, iconBowser]) {
        i.x = healthBar.x + iconPos[iconOrder.indexOf(i)][0] + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 1, 0))) - (i.width - 26);
        i.y = icoP1.y + iconPos[iconOrder.indexOf(i)][1];
        i.health = iconP2.health;
        i.alpha = iconP2.alpha;
    }
}

function beatHit()
    for (i in [iconSys, iconHunter, iconBowser]){
        i.scale.set(1.1, 1.1);
        FlxTween.tween(i.scale, {x: 1, y: 1}, (0.5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.cubeOut});
        i.origin.set(175, 77.5);
    }