function create(){
defaultCamZoom = 0.6;
smoke.alpha = 0.000;
Starman_BG_Fire_Assets2.flipX = true;
remove(strumLines.members[3].characters[0]);
remove(strumLines.members[1].characters[0]);
add(strumLines.members[3].characters[0]);
add(strumLines.members[1].characters[0]);
}
function stepHit(){
    if (curStep == 1362){
    dad.playAnim("laugh");
    camHUD.alpha = 0.000;
    defaultCamZoom = 0.7;
  } 
    if (curStep == 1423){
    camHUD.alpha = 1;
    defaultCamZoom = 0.6;
   } 
   if (curStep == 2064){
    dad.playAnim("laugh");
    FlxTween.tween(Starman_BG_Fire_Assets, {y: -500}, 10, {ease: FlxEase.quadInOut});
    FlxTween.tween(Starman_BG_Fire_Assets2, {y: -500}, 10, {ease: FlxEase.quadInOut});
    FlxTween.tween(smoke, {alpha: 1}, 10);
}
  if (curStep == 2336){
       FlxTween.tween(camGame, {alpha: 0}, 3.9);
       FlxTween.tween(camHUD, {alpha: 0},5);
  }
}
