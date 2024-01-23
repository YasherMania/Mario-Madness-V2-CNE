import funkin.options.OptionsMenu;

var canDoShit:Bool = false;
var optionsPressed:Bool = false;

function create(){
    window.title = "Friday Night Funkin': Mario's Madness";
    
    warning = new FlxSprite(0, 750).loadGraphic(Paths.image('menus/warningscreen'));
    warning.screenCenter(FlxAxes.X);
    FlxTween.tween(warning, {y: 75}, .75, {ease: FlxEase.cubeOut}).onComplete = function() {canDoShit = true;}
    add(warning);

    FlxG.sound.play(Paths.sound("menu/warningMenu"));
}

function update(){
    new FlxTimer().start(.2, function(){FlxTween.tween(warning, {alpha: 1}, .75);});

    if (FlxG.keys.justPressed.ENTER && canDoShit) pressedEnter();
}

function pressedEnter(){
	canDoShit = window.resizable = false;
    FlxG.sound.play(Paths.sound("warpzone/accept"));
    FlxTween.tween(warning, {y: 750}, 1, {
        ease: FlxEase.cubeIn,
        onComplete: function(twn:FlxTween){
            FlxTween.tween(window, {x: 500, y: 175, width: fsX / 2, height: fsY / 1.5}, 1.5, {
                ease: FlxEase.cubeInOut,
                onComplete: function(twn:FlxTween){
                    FlxG.switchState(new TitleState());
                }
            });
        }
    });
}