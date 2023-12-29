import flixel.util.FlxSpriteUtil;

var camxoffset:Float = -400;
var camyoffset:Float = 0;
var dadxoffset:Float = 10;
var dadyoffset:Float = -100;
var brimdef:Int = 250;
var path:String = "stages/hatebg/";

function create() {
    defaultCamZoom = 0.7;

    dad.x = -300;
    dad.y = -30;
    gf.y = 220;
    gf.scrollFactor.set(1, 1);
    boyfriend.y = 350;

    boyfriend.cameraOffset = FlxPoint.weak(camxoffset, camyoffset);
    dad.cameraOffset = FlxPoint.weak(dadxoffset, dadyoffset);

    remove(dad);
    remove(gf);
    remove(boyfriend);

    bfcape = new Character(boyfriend.x, boyfriend.y, "bfihy", true);
    bfcape.playAnim("Capeanim");

    puente = new FlxSprite(-1500,-700).loadGraphic(Paths.image(path + "Puente Roto"));

    wall = new FlxSprite(-1000, -700).loadGraphic(Paths.image(path + "Ladrillos y ventanas"));

    brimstone = new FlxSprite(0, 250).loadGraphic(Paths.image(path + "deg"));
    brimstone.scale.set(4,4);
    brimstone.scrollFactor.set(0,1);

    add(wall);
    add(puente);
    add(gf);
    add(dad);
    add(bfcape);
    add(boyfriend);
    add(brimstone);
}

function onPlayerMiss() bfcape.playAnim("CapeanimMISS"); // Probably a better way to do this but this works for now

function beatHit(curBeat) bfcape.playAnim("Capeanim");

function update(elapsed:Float) brimstone.y = brimdef + (Math.sin(Conductor.songPosition / 750 + Math.PI / 2) * 60);