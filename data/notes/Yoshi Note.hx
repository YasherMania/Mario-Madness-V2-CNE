// may have to mess with this later

function onNoteHit(e)
    if (e.noteType == "Yoshi Note"){
        e.preventAnim();
        dadChars["koopa"].animation.play(["singLEFT", "singDOWN", "singUP", "singRIGHT"][e.direction], true);
    }