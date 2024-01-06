import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormat;

var healthOverlay:FlxSprite;
var titleText:FlxText;
var autorText:FlxText;
var line1:FlxSprite;
var line2:FlxSprite;
var gbcolor:FlxColor = 0xFFF42626;
var newName = PlayState.SONG.meta.displayName;
var autor:String = "";

function create() {
    titleText = new FlxText(400, 304.5, 0, newName, 42);
    titleText.setFormat(Paths.font("marioNES.ttf"), 42, FlxColor.BLACK, "CENTER", FlxTextBorderStyle.OUTLINE, gbcolor);
    titleText.borderSize = 3;
    titleText.cameras = [camHUD];
    titleText.screenCenter(FlxAxes.X);
    titleText.alpha = 0;
    add(titleText);

    switch (curSong) {
        case 'its-a-me':
				autor = '      TheWAHbox\n ft. Sandi and Comodo_';

		case 'Starman Slaughter':
			autor = 'Sandi ft. RedTV53\n FriedFrick and theWAHbox';

		case 'i-hate-you':
			autor = 'iKenny';
		case 'Powerdown':
				autor = 'iKenny ft. TaeSkull';
		case 'Demise':
			autor = 'iKenny';
		case 'Alone':
			autor = 'RedTV53';
		case 'Apparition':
			autor = 'FriedFrick';

		// Extra songs
		case 'Racetraitors':
			autor = 'iKenny';
		case 'Dark Forest':
			autor = 'iKenny';
		case 'Bad Day':
			autor = 'RedTV53';
		case 'So Cool':
			autor = 'FriedFrick ft. TheWAHBox';
		case 'Nourishing Blood':
			autor = 'iKenny';
		case 'Unbeatable':
			autor = 'RedTV53\n ft. theWAHbox and scrumbo_';
		case 'Paranoia':
			autor = 'Sandi ft. iKenny';
		case 'Day Out':
			autor = 'TheWAHBox';
		case 'Thalassophobia':
			autor = 'Hazy ft. TaeSkull';
		case 'Promotion':
			autor = 'Sandi';
		case 'Dictator':
			autor = 'iKenny';
		case 'Last Course':
			autor = 'FriedFrick ft. Sandi';
		case 'No Hope':
			autor = 'FriedFrick';
		case 'The End':
			autor = 'iKenny';
		case 'MARIO SING AND GAME RYTHM 9':
			autor = 'TaeSkull';
		case 'Overdue':
			autor = 'FriedFrick ft. Sandi';
		case 'Abandoned':
			autor = 'TheWAHBox ft. FriedFrick';
		case 'No Party':
			autor = 'iKenny';
    }

    var format = new FlxTextFormat(0x000000, false, false, gbcolor);
    format.leading = -5;

    autorText = new FlxText(400, titleText.y + 70, 0, autor, 35);
    autorText.setFormat(Paths.font("marioNES.ttf"), 35, FlxColor.BLACK, "CENTER", FlxTextBorderStyle.OUTLINE, gbcolor);
    autorText.borderSize += 2;
    autorText.cameras = [camHUD];
    autorText.screenCenter(FlxAxes.X);
    autorText.alpha = 0;
    add(autorText);
    autorText.addFormat(format);

    var checkwidth:Float = autorText.width;

    if (titleText.width >= autorText.width)
    {
        checkwidth = titleText.width;
    }

    line2 = new FlxSprite(566, titleText.y + 57).makeGraphic(Std.int(checkwidth), 5, FlxColor.BLACK);
    line2.cameras = [camHUD];
    line2.screenCenter(FlxAxes.X);
    line2.alpha = 0;

    line1 = new FlxSprite(line2.x - 5, line2.y - 2).makeGraphic(Std.int(checkwidth + 10), 8, gbcolor);
    line1.cameras = [camHUD];
    line1.alpha = 0;
    add(line1);
    add(line2);
}

function beatHit(curBeat) {
    switch (curBeat) {
        case 35:
            FlxTween.tween(titleText, {alpha: 1, y: titleText.y + 30}, 0.5, {ease: FlxEase.cubeOut});
            FlxTween.tween(autorText, {alpha: 1, y: autorText.y + 30}, 0.5, {ease: FlxEase.cubeOut});
            FlxTween.tween(line1, {alpha: 1, y: line1.y + 30}, 0.5, {ease: FlxEase.cubeOut});
            FlxTween.tween(line2, {alpha: 1, y: line2.y + 30}, 0.5, {ease: FlxEase.cubeOut});
            new FlxTimer().start(1, disappear, 1);
    }
}

function disappear() {
    for (i in [titleText,autorText,line1,line2]) {
        FlxTween.tween(i, {alpha:0.0001}, 1, {ease:FlxEase.cubeIn});
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