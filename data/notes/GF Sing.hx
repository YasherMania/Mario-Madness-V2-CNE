var singDir = ["LEFT", "DOWN", "UP", "RIGHT"];
function onNoteHit(note:NoteHitEvent){
    var curNotes = note.noteType;
    switch(curNotes){
    case "GF Sing":
        gf.playAnim("sing" + singDir[note.direction], true);
        strumLines.members[3].characters[0].playAnim("sing" + singDir[note.direction] , true);
        note.cancelAnim();
    }
}
function onNoteCreation(e) {
             switch (e.noteType) {
                      case "GF Sing":
			e.mustHit = false;
			e.note.updateHitbox();
                        e.noteScale = 0.01;
  }
}