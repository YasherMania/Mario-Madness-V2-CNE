import flixel.addons.display.FlxBackdrop; //this is my home -deadlyne // Not anymore - Yasher

var camoffsets = [
    100, -50, -700, 100
];
var path1:String = "stages/demise/1/";
var path2:String = "stages/demise/2/";
var shader:CustomShader = null; 
var shader2:CustomShader = null; 

function create() {
    window.title = "Friday Night Funkin': Mario's Madness | Demise | KennyL";
    defaultCamZoom = 0.8;
    dad.x = 700;
    dad.y = - 100;
    boyfriend.x = 300;
    boyfriend.y = 600;
    boyfriend.cameraOffset = FlxPoint.weak(camoffsets[0], camoffsets[1]);
    dad.cameraOffset = FlxPoint.weak(camoffsets[2], camoffsets[3]);

    legs = new Character(dad.x + 20, dad.y + 300, "MXBody", true);
    legs.playAnim("Legs");
    legs.scale.set(0.65,0.65);
    insert(0,legs);

    arm = new Character(dad.x - 200, dad.y + 250, "MXBody", true);
    arm.playAnim("Right Arm");
    arm.scale.set(0.65,0.65);
    insert(0,arm);

    legs2 = new Character(boyfriend.x, boyfriend.y, "bf_demise", true);
    legs2.scale.set(0.65,0.65);
    insert(1,legs2);

    arm2 = new Character(boyfriend.x, boyfriend.y, "bf_demise", true);
    arm2.scale.set(0.65,0.65);
    insert(1, arm2);

    dad.scale.set(0.65,0.65);
    boyfriend.scale.set(0.65,0.65);

    bg1 = new FlxBackdrop(Paths.image("stages/demise/1/Demise_BG_BG2"),1,1,false,true);
    bg1.scale.set(0.8,0.8);
    bg1.velocity.set(50, 0);
    bg1.y = -100;
    insert(1, bg1);

    bg = new FlxBackdrop(Paths.image("stages/demise/1/Demise_BG_BGCaca"),1,0,false,true);
    bg.scale.set(0.8,0.8);
    bg.velocity.set(250, 0);
    insert(2, bg);

    bush = new FlxBackdrop(Paths.image("stages/demise/1/Demise_BG_BG1"),1,1,false,true);
    bush.scale.set(0.7,0.7);
    bush.velocity.set(1500, 0);
    bush.y = 400;
    insert(3, bush);
    
    floor = new FlxSprite(-1000, 750);
    floor.frames = Paths.getFrames(path1 +'Demise_BG_suelo');
    floor.animation.addByPrefix('idle', "Floor", 48);
    floor.animation.play('idle');
    floor.antialiasing = false;
    //floor.y = 700;
    //floor.x = -450;
    //floor.scale.set(0.7,0.7);
    floor.visible = true; //for the switch stages
    floor.updateHitbox();
    insert(4, floor);
}

function postCreate() {
    q2 = new HealthIcon(dad != null ? dad.getIcon() : "face", false);
    q2.cameras = [camHUD];
    q2.flipX = true;
    add(q2);
    q2.x = 880;
    q2.y = 565;
    health = 2;  
}

function beatHit() {
    q2.scale.set(1.1, 1.1);
    FlxTween.tween(q2.scale, {x: 1, y: 1}, (0.5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.cubeOut});
}

function update(elapsed:Float) { 
    arm.visible = dad.animation.curAnim.name == "idle";
    arm2.visible = boyfriend.animation.curAnim.name == "idle";
}

function postUpdate() {
    legs2.playAnim("idle-legs");
    arm2.playAnim("idle-arm");
}

function onCameraMove(){
    if (curCameraTarget == 0)
           defaultCamZoom = 0.55;
    if (curCameraTarget == 1)
           defaultCamZoom = 0.8;
}