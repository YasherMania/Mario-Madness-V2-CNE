var healthOverlay:FlxSprite;

function new() {     
    PauseSubState.script = 'data/scripts/funnypause';
}

function postUpdate() {
	if (FlxG.save.data.botplayOption) {
        if (FlxG.save.data.ShowPsychUI) {
            healthOverlay.loadGraphic(Paths.image("game/healthBarBGLuigi"));
        }
        healthBarBG.loadGraphic(Paths.image("game/healthBarBGLuigi"));
	} else {
        if (FlxG.save.data.ShowPsychUI) {
		    healthOverlay.loadGraphic(Paths.image("game/healthBarBG"));
        }
        healthBarBG.loadGraphic(Paths.image("game/healthBarBG"));
	}
}

function postCreate() {
	if (FlxG.save.data.ShowPsychUI) {
    	healthOverlay = new FlxSprite(healthBarBG.x - 41, healthBarBG.y - 17).loadGraphic(Paths.image("game/healthBarBG"));
    	healthOverlay.cameras = [camHUD];
    	insert(members.indexOf(iconP1), healthOverlay);
    	healthBarBG.visible = false;
	} else {
		remove(healthBarBG);
		insert(members.indexOf(iconP1), healthBarBG);
		healthBarBG.loadGraphic(Paths.image("game/healthBarBG"));
		healthBarBG.x = 295;
		healthBarBG.y = 642;
		for (i in [scoreTxt, missesTxt, accuracyTxt]) {
			i.font = Paths.font("Mario2.ttf");
			i.color = 0xFFf42626;
			i.size = 10;
		}
	}
}