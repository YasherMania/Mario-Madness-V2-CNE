import flixel.addons.display.FlxBackdrop;

public var ringDisplay:FlxText;
var path = "stages/somari/";
var camoffsets = [3,-20,200,4];

function create() {
    defaultCamZoom = 1.35;
    cameraMovementEnabled = false;
    PlayState.instance.comboGroup.visible = false;

    remove(dad);
    remove(gf);
    remove(boyfriend);

    dad.x = 370;
    dad.y = 20;

    boyfriend.x = 820;
    boyfriend.y = 52;

    gf.x = 900;
    gf.y = 32;
    gf.scrollFactor.set(1,1);

    boyfriend.cameraOffset = FlxPoint.weak(camoffsets[0], camoffsets[1]);
    dad.cameraOffset = FlxPoint.weak(camoffsets[2], camoffsets[3]);

    bg = new FlxSprite(256, 222).loadGraphic(Paths.image(path+"somari_stag1"));
    bg.scale.set(4, 4);
    bg.antialiasing = false;
    bg.updateHitbox();

    building = new FlxSprite(256, 222);
    building.frames = Paths.getFrames(path+"buildings_papu");
    building.animation.addByPrefix("idle", "buildings papu color", 1, true);
    building.animation.play('idle');
    building.scale.set(4, 4);
    building.antialiasing = false;
    building.updateHitbox();
    
    bgstars = new FlxBackdrop(Paths.image(path+"bgstars"), FlxAxes.X);
    bgstars.y = 222;
    bgstars.frames = Paths.getFrames(path+"bgstars");
    bgstars.animation.addByPrefix("idle", "bgstars flash", 5, true);
    bgstars.animation.play('idle');
    bgstars.scale.set(4, 4);
    bgstars.velocity.set(-30, 0);
    bgstars.antialiasing = false;
    bgstars.updateHitbox();

    platform = new FlxSprite(800, 493).loadGraphic(Paths.image(path+"platform"));
    platform.scale.set(4,4);
    platform.antialiasing = false;
    platform.updateHitbox();

    ringDisplay = new FlxText(1080, 670, FlxG.width, '00', 24);
    ringDisplay.setFormat(Paths.font("mariones.ttf"), 40, FlxColor.WHITE, "RIGHT");
    ringDisplay.antialiasing = false;
    ringDisplay.cameras = [camHUD];
    add(ringDisplay);

    ringicon = new FlxSprite(1020, ringDisplay.y).loadGraphic(Paths.image(path+"image"));
    ringicon.scale.set(8, 8);
    ringicon.updateHitbox();
    ringicon.antialiasing = false;
    ringicon.cameras = [camHUD];
    add(ringicon);

    add(bgstars);
    add(building);
    add(bg);
    add(platform);
    add(dad);
    add(gf);
    add(boyfriend);
}

function postCreate() {
    for (i in [timeTxt, timeBar, timeBarBG, hudTxt, healthBar, healthOverlay]) {
        i.visible = false;
    }
}

var wobble = 2.5;
function update(elapsed:Float) {
    ringDisplay.text = ringCounter;
    if (!Note.isSustainNote) {
        //daNote.x = daNote.x + Math.sin(time * Math.PI * 3) * wobble;
    }
}

function destroy() {
    FlxG.scaleMode.width = 1280;
    FlxG.resizeWindow(1280, 720);
}

var noteSize:Float = 6.5;
function onNoteCreation(event) {
	event.cancel();

	var note = event.note;
	if (event.note.isSustainNote) {
		note.loadGraphic(Paths.image('game/notes/NES_NOTE_assetsENDS'), true, 7, 6);
		note.animation.add("hold", [event.strumID]);
		note.animation.add("holdend", [4 + event.strumID]);
	}else{
		note.loadGraphic(Paths.image('game/notes/NES_NOTE_assets'), true, 17, 17);
		note.animation.add("scroll", [4 + event.strumID]);
	}
	note.scale.set(noteSize, noteSize);
	note.updateHitbox();
}

function onStrumCreation(event) {
	event.cancel();

	var strum = event.strum;
	strum.loadGraphic(Paths.image('game/notes/NES_NOTE_assets'), true, 17, 17);
	strum.animation.add("static", [event.strumID]);
	strum.animation.add("pressed", [4 + event.strumID, 8 + event.strumID], 12, false);
	strum.animation.add("confirm", [12 + event.strumID, 16 + event.strumID], 24, false);

	strum.updateHitbox();

    strum.scale.set(noteSize, noteSize);
}

function onPostNoteCreation(event) {
    var note = event.note;
    if (note.isSustainNote)
        note.frameOffset.x = 0.4;
        //trace(note.frameOffset.x);
}