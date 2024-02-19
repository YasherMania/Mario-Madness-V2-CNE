public var healthOverlay:FlxSprite;

function postCreate() {
    healthOverlay = new FlxSprite(healthBarBG.x - 41, healthBarBG.y - 17).loadGraphic(Paths.image("game/healthbars/healthBarBG"));
    healthOverlay.cameras = [camHUD];
    insert(members.indexOf(iconP1), healthOverlay);
    healthBarBG.visible = false;

    disableScript();
}