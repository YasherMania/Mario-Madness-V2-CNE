import funkin.backend.utils.NativeAPI;
import openfl.system.Capabilities;
import funkin.backend.utils.NdllUtil;

static var initialized:Bool = false;

static var prevHidden = [];
static var prevWallpaper = [];

// BIIIG thanks to ne_eo for programming all the functions for this ndll, this would not been possible without him <3
// code for the ndll: https://github.com/APurples/Mario-Madness-V2-CNE-ndlls
static var setTransparent = NdllUtil.getFunction('ndll-mario', 'set_transparent', 4);
static var removeTransparent = NdllUtil.getFunction('ndll-mario', 'remove_transparent', 0);

static var setWallpaper = NdllUtil.getFunction("ndll-mario", "change_wallpaper", 1);
static var getWallpaper = NdllUtil.getFunction('ndll-mario', 'get_wallpaper', 0);

static var hideWindows = NdllUtil.getFunction('ndll-mario', 'hide_windows', 1);
static var showWindows = NdllUtil.getFunction('ndll-mario', 'show_windows', 1);

static var hideTaskbar = NdllUtil.getFunction('ndll-mario', 'hide_taskbar', 0);
static var showTaskbar = NdllUtil.getFunction('ndll-mario', 'show_taskbar', 0);

static var hideIcon = NdllUtil.getFunction('ndll-mario', 'hide_window_icon', 0);
static var showIcon = NdllUtil.getFunction('ndll-mario', 'show_window_icon', 0);

// DEFAULT WINDOW POSITIONS
static var winX:Int = 325;
static var winY:Int = 185;

// MONITOR RESOLUTION
static var fsX:Int = Capabilities.screenResolutionX;
static var fsY:Int = Capabilities.screenResolutionY;

// WINDOW SIZE CHANGE VAR
static var resizex:Int = Capabilities.screenResolutionX / 1.5;
static var resizey:Int = Capabilities.screenResolutionY / 1.5;

function new(){
    // settings that get set to their default values on first launch
    if (FlxG.save.data.flashingLights == null) FlxG.save.data.flashingLights = true;
    if (FlxG.save.data.streamerMode == null) FlxG.save.data.streamerMode = false;
    if (FlxG.save.data.virtualWindow == null) FlxG.save.data.virtualWindow = true;
    if (FlxG.save.data.virtualTrans == null) FlxG.save.data.virtualTrans = true; // transgender mr virtual
    if (FlxG.save.data.virtualWallpaper == null) FlxG.save.data.virtualWallpaper = true;
    if (FlxG.save.data.virtualApps == null) FlxG.save.data.virtualApps = true;
    if (FlxG.save.data.virtualShaders == null) FlxG.save.data.virtualShaders = true;
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
    TitleState => "customStates/menus/MarioTitleState",
    MainMenuState => "customStates/menus/MarioMainMenuState",
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