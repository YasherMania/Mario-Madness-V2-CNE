import funkin.ui.FunkinText;
import flixel.text.FlxText;
import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxAxes;
import flixel.addons.display.FlxBackdrop;
import funkin.backend.scripting.events.MenuChangeEvent;
import funkin.backend.scripting.events.NameEvent;
import funkin.backend.scripting.EventManager;
import funkin.editors.charter.Charter;
import funkin.options.keybinds.KeybindsOptions;
import funkin.options.OptionsMenu;
import FlxG;
import PlayState;

var pauseCam = new FlxCamera();
var bg:FlxSprite;
var texts:Array<FlxText> = [];
var menuItems:Array<String> = ['Resume', 'Restart Song', 'Change Controls', 'Toggle Botplay' , 'Change Options', 'Exit to menu', "Exit to charter"];
var q = false;
var coolBackdrop = new FlxBackdrop(Paths.image('menus/titlescreen/backdrop'));
var funnibox = new FlxSprite().makeSolid(FlxG.width,FlxG.height, PlayState.SONG.meta.parsedColor);
var levelInfo:FlxText = new FlxText(20, 15, 0, PlayState.SONG.meta.displayName, 32);
var levelDifficulty:FlxText = new FlxText(20, 15 + 32, 0, PlayState.difficulty.toUpperCase(), 32);
var multiplayerText:FlxText = new FlxText(20, 15 + 32 + 32, 0, PlayState.opponentMode ? 'OPPONENT MODE' : (PlayState.coopMode ? 'CO-OP MODE' : ''), 32);
var blueballedText:FlxText = new FlxText(20, 15 + 32 + 32, 0, "Blueballed: " + blueballed, 32);

function create(event) {
    event.cancel();

	if (FlxG.save.data.PauseMusic) {
		event.music = "tea-time";
	} else if (!FlxG.save.data.PauseMusic) {
		event.music = "breakfast";
	}

	if (menuItems.contains("Exit to charter") && !PlayState.chartingMode) {
		menuItems.remove("Exit to charter");
	}
	if (menuItems.contains("Toggle Botplay") && !PlayState.chartingMode) {
		menuItems.remove("Toggle Botplay");
	}

    cameras = [];

    FlxG.cameras.add(pauseCam, false);

	pauseCam.bgColor = 0x88000000;
    pauseCam.alpha = 0;

	funnibox.screenCenter(FlxAxes.XY);
	funnibox.alpha = 0.5;
	funnibox.cameras = [pauseCam];
	add(funnibox);

    coolBackdrop.scale.set(0.7,0.7);
    coolBackdrop.alpha = 0;
    coolBackdrop.velocity.set(80, -80);
	coolBackdrop.cameras = [pauseCam];
	add(coolBackdrop);

	grpMenuShit = new FlxTypedGroup();
	add(grpMenuShit);

	for (i in 0...menuItems.length)
	{
		var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
		songText.isMenuItem = true;
		songText.targetY = i;
		grpMenuShit.add(songText);
	}

	FlxTween.tween(coolBackdrop, {alpha: 0.2}, 0.4, {ease: FlxEase.quartInOut});

	for(label in [levelInfo, levelDifficulty, blueballedText, multiplayerText]) {
		label.scrollFactor.set();
		label.setFormat(Paths.font('vcr.ttf'), 32);
		label.updateHitbox();
		label.alpha = 0;
		label.x = FlxG.width - (label.width + 20);
		FlxTween.tween(label, {alpha: 1, y: label.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3 * (label+1)});
		add(label);
	}


    cameras = [pauseCam];
    FlxG.sound.play(Paths.sound("menu/scroll"));
}

function destroy() {
	FlxG.cameras.remove(pauseCam);
}

var canDoShit = true;
var time:Float = 0;
function update(elapsed:Float) {
    pauseCam.alpha = lerp(pauseCam.alpha, 1, 0.25);
    time +- elapsed;
	
    var curText = texts[curSelected];

    if (!canDoShit) return;
	var oldSec = curSelected;
	if (controls.DOWN_P)
		changeSelection(1, false);
	if (controls.UP_P)
		changeSelection(-1);

	if (oldSec != curSelected) {
        FlxG.sound.play(Paths.sound("menu/scroll"));
	}

    if (controls.ACCEPT) {
        FlxG.sound.play(Paths.sound("menu/confirm"));
		var option = menuItems[curSelected];
		if (option == "Resume" || option == "Exit to menu") {
			canDoShit = false;
			FlxTween.tween(funnibox, {alpha:0}, 0.125, {ease:FlxEase.cubeOut});
			FlxTween.tween(coolBackdrop, {alpha: 0}, 0.125, {ease: FlxEase.cubeOut, onComplete: function() {
				selectOption();
			}});
		} else {
			selectOption();
		}
	}

}

function selectOption() {
	var event = EventManager.get(NameEvent).recycle(menuItems[curSelected]);
	pauseScript.call("onSelectOption", [event]);

	if (event.cancelled) return;

	var daSelected:String = event.name;

	switch (daSelected)
	{
		case "Resume":
			close();
		case "Restart Song":
			parentDisabler.reset();
			PlayState.instance.registerSmoothTransition();
			FlxG.resetState();
		case "Change Controls":
			persistentDraw = false;
			openSubState(new KeybindsOptions());
		case "Toggle Botplay":
			FlxG.save.data.botplayOption = !FlxG.save.data.botplayOption;
		trace(FlxG.save.data.botplayOption);
		case "Change Options":
			FlxG.switchState(new OptionsMenu());
		case "Exit to charter":
			FlxG.switchState(new Charter(PlayState.SONG.meta.name, PlayState.difficulty, false));
		case "Exit to menu":
			CoolUtil.playMenuSong();
			FlxG.switchState(PlayState.isStoryMode ? new StoryMenuState() : new ModState("FreeplayChooseState"));
			PlayState.blueballed = 0;
	}
}

function changeSelection(change:Int = 0):Void {
		var event = EventManager.get(MenuChangeEvent).recycle(curSelected, FlxMath.wrap(curSelected + change, 0, menuItems.length-1), change, change != 0);
		pauseScript.call("onChangeItem", [event]);
		if (event.cancelled) return;

		curSelected = event.value;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if (item.targetY == 0)
				item.alpha = 1;
			else
				item.alpha = 0.6;
		}
}