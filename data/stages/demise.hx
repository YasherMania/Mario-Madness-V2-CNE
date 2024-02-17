//this is my home -deadlyne

// List of what left
// - the right arm syncro with idle zzzzzzzzzzzzzzz
// - 1th stage to finished 
// - some cam event 
// - 2nd stage
// - cutscene and mid cutscene
// - changing character (no)
// - red effect
// - dialogue
// - WAHOOOOOOOOOOOOOOOO
// -bf tween without cam

import funkin.game.cutscenes.VideoCutscene;
import flixel.addons.display.FlxBackdrop;
import openfl.Lib;
import flixel.group.FlxTypedGroup;

var path1:String = "stages/demise/1/";
var path2:String = "stages/demise/2/";

var tv = new CustomShader('85');
var tv2 = new CustomShader('tv85');

function postCreate() {

    camHUD.addShader(tv);
    camHUD.addShader(tv2);
    camGame.addShader(tv);
    camGame.addShader(tv2);
    iconP2.flipX =true;
    iconP1.flipX =true;
    health = 2;

}


function create() {

    Lib.application.window.title="Friday Night Funkin': Mario's Madness | Demise | KennyL";    

    defaultCamZoom = 0.85;

    dad.x = 650;
    dad.y = - 100;
    boyfriend.y = 800;
    boyfriend.x = 225;


    remove(dad);
    remove(gf);
    remove(boyfriend);

    bg1 = new FlxBackdrop(Paths.image("stages/demise/1/Demise_BG_BG2"),1,1,false,true);
    bg1.scale.set(0.8,0.8);
    bg1.velocity.set(50, 0);
    bg1.scrollFactor.set(0.75,0.7);
    bg1.y = -200;

    bg = new FlxBackdrop(Paths.image("stages/demise/1/Demise_BG_BGCaca"),1,0,false,true);
    bg.scale.set(0.8,0.8);
    bg.scrollFactor.set(0.75,0.8);
    bg.velocity.set(250, 0);
    //bg.y = -10;

    bush = new FlxBackdrop(Paths.image("stages/demise/1/Demise_BG_BG1"),1,1,false,true);
    bush.scale.set(0.7,0.7);
    bush.velocity.set(1500, 0);
    bush.y = 400;
    
    floor = new FlxSprite();
    floor.frames = Paths.getFrames(path1 +'Demise_BG_suelo');
    floor.animation.addByPrefix('idle', "Floor", 48);
    floor.animation.play('idle');
    floor.antialiasing = false;
    //floor.screenCenter(); stupid idea
    floor.y = 700;
    floor.x = -450;
    floor.scale.set(0.7,0.7);
    floor.visible = true; //for the switch stages
    floor.updateHitbox();

    legs = new Character(dad.x + 20, dad.y + 300, "MXBody", true);
    legs.playAnim("Legs");
    legs.scale.set(0.65,0.65);

    arm = new Character(dad.x - 200, dad.y + 250, "MXBody", true);
    arm.playAnim("Right Arm");
    arm.scale.set(0.65,0.65);

    legs2 = new Character(boyfriend.x + 70, boyfriend.y - 500, "BFBody", true);
    legs2.playAnim("Legs");
    legs2.scale.set(0.65,0.65);

    arm2 = new Character(boyfriend.x + 15, boyfriend.y + 100, "BFBody", true);
    arm2.playAnim("Right Arm");
    arm2.scale.set(0.65,0.65);

    dad.scale.set(0.65,0.65);
    boyfriend.scale.set(0.65,0.65);

    bgf1 = new FlxBackdrop(Paths.image("stages/demise/1/Demise_BG_Foreground1"),1,0,false,true);
    bgf1.scale.set(0.5,0.5);
    bgf1.spacing.x = 30000;
    bgf1.scrollFactor.set(0.75,0.8);
    bgf1.velocity.set(5000, 0);
    bgf1.y = 400;

    bgf2 = new FlxBackdrop(Paths.image("stages/demise/1/Demise_BG_Foreground2"),1,0,false,true);
    bgf2.scale.set(0.4,0.4);
    bgf2.spacing.x = 30000;
    bgf2.velocity.set(5000, 0);
    bgf2.scrollFactor.set(0.75,0.8);
    bgf2.y = 400;
    bgf2.x = -2000;


    bgf3 = new FlxBackdrop(Paths.image("stages/demise/1/Demise_BG_Foreground3"),1,0,false,true);
    bgf3.scale.set(0.55,0.55);
    bgf3.spacing.x = 60000;
    bgf3.y = -150;
    bgf3.velocity.set(4000, 0);

    bgf4 = new FlxBackdrop(Paths.image("stages/demise/1/Demise_BG_Foreground4"),1,0,false,true);
    bgf4.scale.set(0.4,0.4);
    bgf4.spacing.x = 30000;
    bgf4.velocity.set(5000, 0);
    bgf4.scrollFactor.set(0.75,0.8);
    bgf4.y = 400;

    //FlxTween.tween(boyfriendGroup, { x: 100}, 2.5, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut,});
    
}

function postUpdate() {
    iconP2.x = FlxG.height/0.8;
    iconP2.y = 565;
}

function update() { 
    arm.visible = dad.animation.curAnim.name == "idle";
    arm2.visible = boyfriend.animation.curAnim.name == "idle";
    //if(boyfriend.animation.name == "idle") arm.playAnim("Right Arm");
    //if(dad.animation.name == "idle") arm.playAnim("Right Arm");
}

function onCameraMove(){
    if (curCameraTarget == 0)
           defaultCamZoom = 0.65;
    if (curCameraTarget == 1)
           defaultCamZoom = 0.85;
}

function beatHit(curBeat) {
    arm2.playAnim("Right Arm");
    arm.playAnim("Right Arm");
}

function stepHit() {
    if (curStep == 1){
        add(bg1);
        add(bg);
        add(bush);
        add(floor);
        add(arm);
        add(legs);
        add(dad);
        add(arm2);
        add(legs2);
        add(boyfriend);
        add(bgf1);
        add(bgf2);
        add(bgf3);
        add(bgf4);
    }
    if (curStep == 314){
        destroy(bg1);
        destroy(bg);
        destroy(bush);
        remove(floor);
        remove(arm);
        remove(legs);
        remove(dad);
        remove(arm2);
        remove(legs2);
        remove(boyfriend);
        remove(bgf1);
        remove(bgf2);
        remove(bgf3);
        remove(bgf4);
    }
}