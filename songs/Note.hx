function onNoteCreation(event) {
    event.noteSprite = 'game/notes/Mariodefault';
    if (FlxG.save.data.botplayOption) {
        event.noteSprite = 'game/notes/Luigidefault';
    }
}

function onStrumCreation(event) {
    event.sprite = 'game/notes/Mariodefault';
    if (FlxG.save.data.botplayOption) {
        event.sprite = 'game/notes/Luigidefault';
    }
}