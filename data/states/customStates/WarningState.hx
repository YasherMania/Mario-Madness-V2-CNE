import funkin.options.OptionsMenu;
import funkin.backend.utils.ShaderResizeFix;
import funkin.backend.system.framerate.Framerate;

var canDoShit:Bool = false;
var optionsPressed:Bool = false;

window.x = winX;
window.y = winY;
window.resizable = false;
ShaderResizeFix.doResizeFix = false;

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
	canDoShit = false;
    FlxG.sound.play(Paths.sound("warpzone/accept"));
    FlxTween.tween(warning, {y: 750}, 1, {
        ease: FlxEase.cubeIn,
        onComplete: function(twn:FlxTween){
            for (i in [Framerate.fpsCounter, Framerate.memoryCounter, Framerate.codenameBuildField]) FlxTween.tween(i, {alpha: .6}, 1.5, {ease: FlxEase.circInOut});
            FlxTween.tween(window, {x: winX + 180, y: winY + 15, width: fsX / 2.084691, height: fsY / 1.562952}, 1.5, {
                ease: FlxEase.circInOut,
                onComplete: function(twn:FlxTween){
                    FlxG.resizeWindow(fsX / 2.084691, fsY / 1.562952);
                    FlxG.resizeGame(fsX / 2.084691, fsY / 1.562952);
                    FlxG.scaleMode.width = fsX / 2.084691;
                    FlxG.scaleMode.height = fsY / 1.562952;
                    ShaderResizeFix.doResizeFix = true;
                    ShaderResizeFix.fixSpritesShadersSizes();
                    FlxG.switchState(new TitleState());
                }
            });
        }
    });
}