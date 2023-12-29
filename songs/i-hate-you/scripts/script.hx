function stepHit(){
    switch(curStep){
        case 1424: dad.playAnim("Knees");
        case 1448:
            boyfriend.playAnim("PreJump");
            FlxTween.tween(camHUD, {alpha: 0}, .25);
        case 1450:
            FlxTween.tween(boyfriend, {y: boyfriend.y - 100}, .5, {ease: FlxEase.cubeOut}).onComplete = function(){
                FlxTween.tween(boyfriend, {y: boyfriend.y + 100}, .5, {ease: FlxEase.cubeOut});
            };
            FlxTween.tween(boyfriend, {x: dad.x + 250}, 1, {ease: FlxEase.cubeOut});
            boyfriend.playAnim("Spin", true);
        case 1456:
            boyfriend.playAnim("Attack");
            dad.playAnim("Falling");
        case 1512: boyfriend.playAnim("YEAH");
    }
}