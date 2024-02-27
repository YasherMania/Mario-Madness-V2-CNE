function onNoteCreation(e) {
    e.noteSprite = FlxG.save.data.botplayOption ? "game/notes/Luigidefault" : "game/notes/Mariodefault";
}

function onStrumCreation(e) {
    e.sprite = FlxG.save.data.botplayOption ? "game/notes/Luigidefault" : "game/notes/Mariodefault";
}

function onSubstateClose() {
    if (FlxG.save.data.botplayOption) {
        changeStrumsTexture(player, "game/notes/Luigidefault");
        changeStrumsTexture(cpu, "game/notes/Luigidefault");
    } else {
        changeStrumsTexture(player, "game/notes/Mariodefault");
        changeStrumsTexture(cpu, "game/notes/Mariodefault");
    }
}

function changeStrumsTexture(strumline:StrumLine, texture:String) {
    for(strum in strumline.members) changeStrumTexture(strum, texture, strumline.strumAnimPrefix[strum.ID], strumline.strumScale);
}
var strumAnimPrefix = ["left", "down", "up", "right"];
function changeStrumTexture(strum:Strum, texture:String, animPrefix:String, strumScale:Float) {
    var oldAnimName:String = strum.animation.name;
    var oldAnimFrame:Int = strum.animation?.curAnim?.curFrame;
    strum.frames = Paths.getFrames(texture);

    strum.antialiasing = true;
    strum.scale.set(1, 1);
    strum.updateHitbox();
    strum.setGraphicSize(Std.int((strum.width * 0.7) * strumScale));

    strum.animation.addByPrefix('static', 'arrow' + animPrefix.toUpperCase());
    strum.animation.addByPrefix('pressed', animPrefix+' press', 24, false);
    strum.animation.addByPrefix('confirm', animPrefix+' confirm', 24, false);

    strum.animation.curAnim = null;

    strum.updateHitbox();

    strum.playAnim(oldAnimName, true);
    strum.animation?.curAnim?.curFrame = oldAnimFrame;
}