var poisoned:Bool = false;

// Credit to MAZ for basically everything here.

function onPlayerHit(e) {
    if (e.noteType == "Nota veneno") {
			e.showSplash = true;
			if (!e.note.isSustainNote) {
                poisoned = true;
			} else e.healthGain = 0;
    }
}

function onPlayerMiss(e) {
	if (e.noteType == "Nota veneno") {
		e.cancel();
		deleteNote(e.note);
	}
}

function onDadHit(e) {
	if (!e.player && e.noteType == "Nota veneno") {
		e.cancel();
    }
}

function postUpdate() {
    if (poisoned) {
        if (health > 0.1) health -= 0.0125;
        if (health <= 0.1) health = 0;
        new FlxTimer().start(0.9, stopP, 1);
    }
}

function stopP() {poisoned = false;}

function onNoteCreation(e) {
		switch (e.noteType) {
			case "Nota veneno":
			if (PlayState.opponentMode && e.strumLineID >= 1) e.note.wasGoodHit = true;

			if (!PlayState.opponentMode && e.strumLineID <= 0) e.note.wasGoodHit = true;
			e.noteSprite = "game/notes/poisonMushroom";
			e.noteScale = 0.73;
			e.mustHit = false;
			e.note.updateHitbox();
			e.note.earlyPressWindow = 0.1;
			e.note.latePressWindow = 0.2;
	}
}