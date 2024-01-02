static var mycharIdleAlt = false;

function onPlayAnim(e) {
    if(mycharIdleAlt) {
        if(e.animName == "idle") e.animName = "idle-alt";
    }
}