var dadCamZoom:Int = 0.5;
var bfCamZoom:Int = 0.6;
import flixel.util.FlxSpriteUtil;
import flixel.effects.FlxFlicker;
var John:HealthIcon = iconP1;
var Peach:HealthIcon = iconP1;
var Yoshi:HealthIcon = iconP1;
var cancelCameraMove:Bool = false;
var exampleTween:FlxTween;

function postCreate(){

John = new FlxSprite().loadGraphic(Paths.image('icons/SS_Koopa'));
John.width = iconP2.width / 2;
John.loadGraphic(Paths.image('icons/SS_Koopa'), true, Math.floor(iconP2.width), Math.floor(iconP2.height));
John.y = healthBar.y - (John.height / 2);

Peach = new FlxSprite().loadGraphic(Paths.image('icons/peach_exe'));
Peach.width = iconP2.width / 2;
Peach.loadGraphic(Paths.image('icons/peach_exe'), true, Math.floor(iconP2.width), Math.floor(iconP2.height));
Peach.y = healthBar.y - (Peach.height / 2);

Yoshi = new FlxSprite().loadGraphic(Paths.image('icons/yoshi_exe'));
Yoshi.width = iconP2.width / 2;
Yoshi.loadGraphic(Paths.image('icons/yoshi_exe'), true, Math.floor(iconP2.width), Math.floor(iconP2.height));
Yoshi.y = healthBar.y - (Yoshi.height / 2);

melted = new FlxSprite().loadGraphic(Paths.image('icons/melted_mario'));
melted.width = iconP2.width / 2;
melted.loadGraphic(Paths.image('icons/melted_mario'), true, Math.floor(iconP2.width), Math.floor(iconP2.height));
melted.y = healthBar.y - (melted.height / 2);

add(Peach);
add(John);
add(Yoshi);
add(melted);
}
function beatHit(){
 for (i in [John, Peach,Yoshi]){
        i.scale.set(1.1, 1.1);
        FlxTween.tween(i.scale, {x: 1, y: 1}, (0.5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.cubeOut});
    }
  John.origin.set(147.5, 75);
  Peach.origin.set(147.5, 75);
  Yoshi.origin.set(147.5, 75);
}
function postUpdate(elapsed:Float) {

//john dick icon
John.animation.add("win", [0], 10, true);
John.animation.add("lose", [1], 10, true);
John.cameras = [camHUD];
John.x = iconP2.x - 50;
John.y = iconP2.y - 40;

//Peach icon
Peach.animation.add("win", [0], 10, true);
Peach.animation.add("lose", [1], 10, true);
Peach.cameras = [camHUD];
Peach.x = iconP1.x - 100;
Peach.y = iconP1.y;
Peach.scale.x = iconP2.scale.x;
Peach.scale.y = iconP2.scale.y;

//Yoshi icon
Yoshi.animation.add("win", [0], 10, true);
Yoshi.animation.add("lose", [1], 10, true);
Yoshi.cameras = [camHUD];
Yoshi.x = iconP2.x - 50;
Yoshi.y = iconP1.y - 40;
Yoshi.scale.x = iconP2.scale.x;
Yoshi.scale.y = iconP2.scale.y;

//melted icon
melted.animation.add("win", [0], 10, true);
melted.animation.add("lose", [1], 10, true);
melted.cameras = [camHUD];
melted.x = iconP2.x;
melted.y = iconP1.y;
melted.scale.x = iconP2.scale.x;
melted.scale.y = iconP2.scale.y;

Yoshi.alpha = strumLines.members[3].characters[0].alpha;
Peach.alpha = rando.alpha;
John.alpha = strumLines.members[2].characters[0].alpha;
melted.alpha = mario2.alpha;

}
function update(elapsed:Float){
if(health > 1.6 || health < 0.4){
				John.animation.play('lose');
				Yoshi.animation.play('lose');
				Peach.animation.play('lose');
				melted.animation.play('lose');
			}else{
				John.animation.play('win');
				Peach.animation.play('win');
				Yoshi.animation.play('win');
				melted.animation.play('win');
			}

    switch (curCameraTarget){
        case 0: defaultCamZoom = dadCamZoom;
        case 1: defaultCamZoom = bfCamZoom;
        case 5: defaultCamZoom = bfCamZoom;
    }
}
function create(){
defaultCamZoom = 0.6;
strumLines.members[3].characters[0].alpha = 0;
strumLines.members[5].characters[0].alpha = 0;
strumLines.members[2].characters[0].alpha = 0;
strumLines.members[2].characters[0].y = 3100;
strumLines.members[2].characters[0].x = 650;


//stage shit
fireR = new FlxSprite();
fireR.x = 700;
fireR.y = fireL.y;
fireR.frames = Paths.getFrames('stages/exesequel/Starman_BG_Fire_Assets');
fireR.animation.addByIndices('delay', 'fire anim effects', [8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7], "", 24, true);
fireR.animation.play("delay");
fireR.flipX = true;
fireR.alpha = 1;

rando.alpha = 0;

//death shit
peachCuts = new FlxSprite(-2460, -600);
peachCuts.frames = Paths.getFrames('characters/Peach_EXE_death');
peachCuts.animation.addByPrefix('floats', "PeachFalling1", 24, true);
peachCuts.animation.addByPrefix('fall', "PeachFalling2", 24, false);
peachCuts.animation.addByPrefix('dies', "PeachDIES", 24, false);
peachCuts.antialiasing = true;
peachCuts.alpha = 1;
peachCuts.animation.play("floats");
FlxTween.tween(strumLines.members[3].characters[0], {y: -210}, 0.20, {startDelay: 1.04});

mario = new FlxSprite(-1500,-600);
mario.frames = Paths.getFrames('characters/melted_mario');
mario.animation.addByPrefix('jump', "meltio jump0", 24, false);
mario.animation.addByPrefix('ground', "meltio jump2", 24, false);
mario.antialiasing = true;
mario.alpha = 0;

mario2 = new FlxSprite();
mario2.frames = Paths.getFrames('characters/melted_mario');
mario2.animation.addByPrefix('ground', "meltio jump 2", 24, true);
mario2.animation.play("ground",true);
mario2.antialiasing = true;
mario2.alpha = 0;
mario2.x = 100;

remove(strumLines.members[0].characters[0]);
remove(strumLines.members[3].characters[0]);
remove(strumLines.members[2].characters[0]);
remove(sky);
remove(castle);
remove(fireL);
remove(far);
remove(pow);
remove(mid);
remove(floor);
remove(foreground);
remove(dad);
remove(boyfriend);
remove(gf);

add(sky);
add(castle);
add(fireL);
add(fireR);
add(far);
add(pow);
add(strumLines.members[3].characters[0]);

//scrollFactor shit
fireL.scrollFactor.set(0.4,0.4);
fireR.scrollFactor.set(0.4,0.4);
sky.scrollFactor.set(0.1,0.1);
castle.scrollFactor.set(0.2,0.2);
mid.scrollFactor.set(0.65,0.65);
far.scrollFactor.set(0.55,0.55);
pow.scrollFactor.set(0.55,0.55);
foreground.scrollFactor.set(1.6,1);
strumLines.members[3].characters[0].scrollFactor.set(0.55,0.55);

add(mid);
add(strumLines.members[2].characters[0]);
add(floor);
add(gf);
add(dad);
add(peachCuts);
add(mario);
add(boyfriend);
add(foreground);
}
function onCameraMove(e) if(cancelCameraMove) e.cancel();

function normcam(){
bfCamZoom = .5;
}
function middlecam(){
bfCamZoom = .4;
}

function stepHit(){
if (curStep == 528){
strumLines.members[2].characters[0].alpha = 1;
FlxTween.tween(strumLines.members[2].characters[0], {y: -100}, 1, {ease: FlxEase.quadInOut});
bfCamZoom = .55;
dadCamZoom = .55;
 }
if (curStep == 535){
gfGroup = strumLines.members[2].characters[0];
FlxTween.tween(gfGroup, {x: gfGroup.x - 100}, 3, {startDelay: 2,ease: FlxEase.quadInOut, type: 4});
FlxTween.tween(gfGroup, {y: -100}, 1, {ease: FlxEase.quadInOut, type: 4});
}

if (curStep == 1021){
gfGroup = gf;
FlxTween.tween(gfGroup, {x: 3500}, 1.5, {ease: FlxEase.quadInOut});
FlxTween.tween(gfGroup, {y: -400}, 1.5, {ease: FlxEase.cubeIn});
FlxTween.tween(John, {x: 900}, 1, {ease: FlxEase.quadInOut});
} 
if (curStep == 1046){
//cam
cancelCameraMove = true;
cameraMovementEnabled = false;
exampleTween = FlxTween.tween(camFollow, {y: 550}, 1, {ease: FlxEase.quadInOut});

strumLines.members[3].characters[0].alpha = 1;
FlxTween.tween(strumLines.members[3].characters[0], {y: 10}, .1, {startDelay: .1});
FlxTween.tween(dad, {y: 1900}, 1, {ease: FlxEase.quadInOut});
strumLines.members[3].characters[0].playAnim("pound");
strumLines.members[2].characters[0].alpha = 0;
camHUD.alpha = 0;
} 
if (curStep == 1048){
pow.alpha = 0;
rando.alpha = 1;
iconP2.alpha = 0;
camGame.shake(0.01, 1);
camHUD.shake(0.01, 1);
}
if (curStep == 1053){
strumLines.members[3].characters[0].playAnim("idle");
}
if (curStep == 1078){
FlxTween.tween(peachCuts, {y: -200}, 1, {startDelay: .1, ease: FlxEase.backIn});
FlxTween.tween(camFollow, {x: 1650, y: 300}, 1.38, {ease: FlxEase.expoIn});
}
if (curStep == 1070){
exampleTween = FlxTween.tween(camFollow, {y: 150}, 1, {ease: FlxEase.quadInOut});
FlxTween.tween(peachCuts, {y: -380}, 1.25, {ease: FlxEase.quadInOut});
FlxTween.tween(peachCuts, {x: -235}, 1.5, {ease: FlxEase.backOut});
healthBar.createFilledBar(dad.iconColor, 0xFFA83454);
healthBar.updateBar();
pow.alpha = 0;
}
if (curStep == 1080){
dad.alpha = 0;
}
if (curStep == 1082){
FlxTween.tween(camHUD, {alpha: 1}, .2, {startDelay: .5});
dadCamZoom = .57;
}
if (curStep == 1086){
cancelCameraMove = false;
cameraMovementEnabled = true;
peachCuts.animation.play('fall');
}
if (curStep == 1560){
cancelCameraMove = true;
cameraMovementEnabled = false;
FlxTween.tween(camGame, {zoom: 0.65}, 1.5, {ease: FlxEase.quadInOut});
exampleTween = FlxTween.tween(camFollow, {x: 650, y: 250}, 1.25, {startDelay: 0.25, ease: FlxEase.quadInOut});
}
if (curStep == 1573){
peachCuts.animation.play('dies');
strumLines.members[3].characters[0].playAnim("watch");
strumLines.members[3].characters[0].animation.curAnim.pause();
peachCuts.alpha = 1;
dad.alpha = 0;  
new FlxTimer().start(2.5, function(tmr:FlxTimer)
{       
	FlxFlicker.flicker(peachCuts, 2, 0.12, false);
        FlxFlicker.flicker(rando, 2, 0.12, false);
        FlxFlicker.flicker(Peach, 2, 0.12, false);
	});

}
if (curStep == 1094){
rando.alpha = 1;
peachCuts.alpha = 0;
dad.alpha = 1;
}
if (curStep == 1600){
   dad.alpha = 0.000;
 }
if (curStep == 1617){
strumLines.members[3].characters[0].alpha = 0.000;
}
if (curStep == 1615){
cancelCameraMove = false;
exampleTween.cancel();
healthBar.createFilledBar(dad.iconColor, 0xFF870C0A);
healthBar.updateBar();
mario.alpha = 1;
mario.x -= 1000;
mario.y += 1200;
 }
if (curStep == 1619){
dad.alpha = 1;
FlxTween.tween(mario, {x: -940}, .95, {ease: FlxEase.quadInOut});
FlxTween.tween(mario, {y: -200}, .6, {startDelay: 0.8, ease: FlxEase.quadOut});
FlxTween.tween(mario2, {x: -940}, .95, {ease: FlxEase.quadInOut});
FlxTween.tween(mario2, {y: -200}, .6, {startDelay: 0.8, ease: FlxEase.quadOut});
mario.animation.play("jump");
mario.alpha = 1;
}
if (curStep == 1623){
FlxTween.tween(mario2, {y: 0}, .6, {startDelay: 0.8, ease: FlxEase.quadOut});
mario.y += 0;
mario2.animation.play("ground");
dad.playAnim("ground");
mario2.alpha = 1;
dad.alpha = 1;
}			
 if (curStep == 2056){
       defaultCamZoom = 0.7;
       sky.alpha = 0.000;
       castle.alpha = 0.000;
       fireL.alpha = 0.000;
       fireR.alpha = 0.000;
       far.alpha = 0.000;
       mid.alpha = 0.000;
       floor.alpha = 0.000;
       foreground.alpha = 0.000;
       gf.alpha = 0;
       boyfriend.alpha = 0;
iconP1.alpha = 0;
melted.alpha = 0;
healthBarBG.visible = false;
healthBar.visible = false;
timeBarBG.visible = false;
timeBar.visible = false;
timeTxt.visible = false;
hudTxt.visible = false;

remove(combo);
FlxG.camera.flash(FlxColor.RED, 0.5);
FlxTween.tween(camGame, {zoom: 0.7}, 3, {ease: FlxEase.linear});
for (i in cpuStrums.members) 
FlxTween.tween(i, {alpha: 0}, .1, {ease: FlxEase.smootherStepInOut});

  } 
if (curStep == 2075){
       FlxTween.tween(camHUD, {alpha: 0},1);
       FlxTween.tween(camGame, {alpha: 0},1);
  } 

}