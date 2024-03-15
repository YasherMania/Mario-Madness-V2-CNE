var noteSize:Float = 6.5;
public var ringCounter:Int = 0;

function onPlayerHit(e) {
    if (e.noteType == "Ring Note") {
		e.showSplash = false;
        ringCounter++;
        FlxG.sound.play(Paths.sound("ringhit"));
    }
}

function onPlayerMiss(e) {
    if (!e.isSustainNote) {
        ringCounter--;
        FlxG.sound.play(Paths.sound("ringloss"));
    }
    if (ringCounter < 0) {
        health = 0;
        FlxG.sound.play(Paths.sound("ringout"));
    }
	if (e.noteType == "Ring Note") {
		e.cancel();
		deleteNote(e.note);
	}
}

function onDadHit(e) {
	if (!e.player && e.noteType == "Ring Note") {
		e.cancel();
    }
}

function onNoteCreation(e) {
    switch (e.noteType) {
        case "Ring Note":
            var note = e.note;
            if (note.isSustainNote) {
                note.loadGraphic(Paths.image('game/notes/ringNES_NOTE_assetsENDS'), true, 7, 6);
                note.animation.add("hold", [event.strumID]);
                note.animation.add("holdend", [4 + event.strumID]);
            }else{
                note.loadGraphic(Paths.image('game/notes/ringNES_NOTE_assets'), true, 17, 17);
                note.animation.add("scroll", [4 + event.strumID]);
            }
            note.scale.set(noteSize, noteSize);
            note.updateHitbox();
            e.mustHit = false;
    }
}