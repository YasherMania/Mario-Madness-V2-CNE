var singDir = ["LEFT", "DOWN", "UP", "RIGHT"];
function onNoteHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
        case "GF Duet":
            dad.playAnim("sing" + singDir[note.direction], true);
            strumLines.members[3].characters[0].playAnim("sing" + singDir[note.direction] , true);
            note.cancelAnim();
    }
}