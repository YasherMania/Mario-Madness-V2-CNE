function onPostNoteCreation(event) {
    if (curStage == "virtual")
        disableScript();
    var note = event.note;
    if (FlxG.save.data.Splashes == "splashDiamond")
        note.splash = "diamond";
    if (FlxG.save.data.Splashes == "splashPsych")
        note.splash = "vanilla";
    if (FlxG.save.data.Splashes == "splashSecret")
        note.splash = "secret";
}

function postCreate()
    if (FlxG.save.data.Splashes == "splashDisabled")
        splashHandler.visible = false;

    if (curStage == "virtual")
        disableScript();