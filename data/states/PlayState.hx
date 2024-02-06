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
	if (!FlxG.save.data.ShowPsychUI) {
		luigiLogo.visible = FlxG.save.data.botplayOption;
		player.cpu = FlxG.save.data.botplayOption;
		for (i in [missesTxt, accuracyTxt, scoreTxt]) {
			i.color = FlxG.save.data.botplayOption ? 0xFF25cd49 : 0xFFf42626;
		}
	}
}
if (!FlxG.save.data.ShowPsychUI) {
	var e:Float = 0;
	function update(elapsed:Float) {
		e += 180 * elapsed;
    	luigiLogo.angle = ((1 - Math.sin((Math.PI * e) / 180)) * 20) - 20;
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
			i.color = FlxG.save.data.botplayOption ? 0xFF25cd49 : 0xFFf42626;
			i.size = 10;
		}
		luigiLogo = new FlxSprite(400, 26.25 + 55);
		luigiLogo.loadGraphic(Paths.image("game/luigi"));
		luigiLogo.scrollFactor.set();
		luigiLogo.scale.set(0.3, 0.3);
		luigiLogo.updateHitbox();
		luigiLogo.screenCenter(FlxAxes.X);
		luigiLogo.y = 26.25 + ((!downscroll ? 40 : 40));
		luigiLogo.visible = FlxG.save.data.botplayOption;
		add(luigiLogo);
		luigiLogo.cameras = [camHUD];
	}
}