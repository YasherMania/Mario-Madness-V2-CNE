import funkin.options.OptionsMenu;

var canDoShit:Bool = true;
var optionsPressed:Bool = false;

function create(){
    window.title = "Friday Night Funkin': Mario's Madness";
    
    warning = new FlxSprite(0, 750).loadGraphic(Paths.image('menus/warningscreen'));
    warning.screenCenter(FlxAxes.X);
    FlxTween.tween(warning, {y: 75}, .75, {ease: FlxEase.cubeOut}).onComplete = function() {canDoShit = true;}
    add(warning);
}

function update(){
    new FlxTimer().start(.2, function() {FlxTween.tween(warningTxt, {alpha: 1}, .75);});

    if (FlxG.keys.justPressed.ENTER && canDoShit) pressedEnter();
    else if (FlxG.keys.justPressed.ESCAPE) pressedEscape();
}

function pressedEnter(){
	canDoShit = false;
    FlxTween.tween(FlxG.camera, {alpha: 0}, .75, {ease: FlxEase.quintOut});
	CoolUtil.playMenuSFX(1);
    FlxTween.tween(window, {x: 650, y: 325, width: 640, height: 360}, 1, {ease: FlxEase.sineOut});
	new FlxTimer().start(2, function() {
		FlxG.switchState(new TitleState());
	});
}

function pressedEscape(){
	FlxG.switchState(new OptionsMenu());
	optionsPressed = true;
}