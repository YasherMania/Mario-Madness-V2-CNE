var noteSize:Float = 6;
var noteOffset:Float = 17;
var noteSusX:Float = 7;
var noteSusY:Float = 12 / 2;

var staticShader:CustomShader = null;
var border:CustomShader = null;

function create(){
	staticShader = new CustomShader("TVStatic");
	staticShader.data.strengthMulti.value = [0.5, 0.5];
	staticShader.data.imtoolazytonamethis.value = [0.3, 0.3];
	camGame.addShader(staticShader);

	border = new CustomShader("border");
	camGame.addShader(border);
}

function postCreate(){
    healthOverlay.loadGraphic(Paths.image("game/healthbars/gb"));
    hudTxt.color = timeTxt.color = 0xFFADADAD;
	FlxTween.color(fpsfunniCounter, 1, 0xFFA11B1B, 0xFFADADAD);
    timeBar.createFilledBar(0xFF000000,0xFFADADAD);
}

function onNoteCreation(event) {
	event.cancel();

	var note = event.note;
	if (event.note.isSustainNote) {
		note.loadGraphic(Paths.image('game/notes/GB_NOTE_assetsENDS'), true, noteSusX, noteSusY);
		note.animation.add("hold", [event.strumID]);
		note.animation.add("holdend", [4 + event.strumID]);
	}else{
		note.loadGraphic(Paths.image('game/notes/GB_NOTE_assets'), true, noteOffset, noteOffset);
		note.animation.add("scroll", [4 + event.strumID]);
	}
	note.scale.set(noteSize, noteSize);
	note.updateHitbox();
}

function onStrumCreation(event) {
	event.cancel();

	var strum = event.strum;
	strum.loadGraphic(Paths.image('game/notes/GB_NOTE_assets'), true, noteOffset, noteOffset);
	strum.animation.add("static", [event.strumID]);
	strum.animation.add("pressed", [4 + event.strumID, 8 + event.strumID], 12, false);
	strum.animation.add("confirm", [12 + event.strumID, 16 + event.strumID], 24, false);

	strum.updateHitbox();

    strum.scale.set(noteSize, noteSize);
}

function onPostNoteCreation(event) {  
    var note = event.note;  
    //if (FlxG.save.data.Splashes) note.splash = "redDiamond";
    //else if (FlxG.save.data.Splashes == 0) note.splash = "redVanilla";
    //else return;
}

function onSongEnd() FlxTween.color(fpsfunniCounter, 1, 0xFFADADAD, 0xFFA11B1B);