static var bfexeidleAlt = false;

function onPlayAnim(e) {
    if(bfexeidleAlt) {
        if(e.animName == "idle") e.animName = "idle-alt";
    }
}