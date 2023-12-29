import funkin.backend.utils.NativeAPI;

static var initialized:Bool = false;

function new(){
    // settings that get set to true on first launch
    if (FlxG.save.data.flashingLights == null) FlxG.save.data.flashingLights = true;
    if (FlxG.save.data.streamerMode == null) FlxG.save.data.streamerMode = false;
    if (FlxG.save.data.transparency_value == null) FlxG.save.data.transparency_value = 0;

    // Psych Options
    if (FlxG.save.data.Splashes == null) FlxG.save.data.Splashes = 0;
    if (FlxG.save.data.PauseMusic == null) FlxG.save.data.PauseMusic = 0;
    if (FlxG.save.data.botplayOption == null) FlxG.save.data.botplayOption = false;
    if (FlxG.save.data.colouredBar == null) FlxG.save.data.colouredBar = false;
    if (FlxG.save.data.showBar == null) FlxG.save.data.showBar = false;
    if (FlxG.save.data.showTxt == null) FlxG.save.data.showTxt = false;
}

static var redirectStates:Map<FlxState, String> = [
    TitleState => "customStates/MarioTitleState",
    MainMenuState => "customStates/MarioMainMenuState",
];

function update(elapsed) {
    if (FlxG.keys.justPressed.F6)
        NativeAPI.allocConsole();
    if (FlxG.keys.justPressed.F5)
        FlxG.resetState();
}

function preStateSwitch() {
    FlxG.camera.bgColor = 0xFF000000;

	if (!initialized){
		initialized = true;
		FlxG.game._requestedState = new ModState('customStates/WarningState');
    }else
		for (redirectState in redirectStates.keys())
			if (FlxG.game._requestedState is redirectState)
				FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}