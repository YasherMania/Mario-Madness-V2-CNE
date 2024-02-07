function onPlayerHit(e) if (e.noteType == "No Animation") e.showSplash = true;

function onPlayerMiss(e) {
	if (e.noteType == "No Animation") {
		e.cancel();
		deleteNote(e.note);
	}
}

function onDadHit(e) if (!e.player && e.noteType == "No Animation") e.cancel();