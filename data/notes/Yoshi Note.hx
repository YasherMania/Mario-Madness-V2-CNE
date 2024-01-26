var singDir = ["LEFT", "DOWN", "UP", "RIGHT"];
function onPlayerHit(e){
         if (!e.player && e.noteType == "Yoshi Note"){

            strumLines.members[3].characters[0].playAnim("sing" + singDir[note.direction] , true);
            note.cancelAnim();
	    e.mustHit = false;
            e.alpha = 0;
	    e.note.updateHitbox();
    }
}

function onPlayerHit(e) {
	if (e.noteType == "Yoshi Note") {
		e.cancel();
		deleteNote(e.note);
	}
}