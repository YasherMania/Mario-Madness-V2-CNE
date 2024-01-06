function new(){
    FlxG.camera.alpha = 0;
    FlxTween.tween(FlxG.camera, {alpha: 1}, 1, {ease: FlxEase.quintInOut});
}