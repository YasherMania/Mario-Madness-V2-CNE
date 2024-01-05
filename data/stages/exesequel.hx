var dadCamZoom:Int = 0.6;
var bfCamZoom:Int = 0.5;
var __timer:Float = 0;
function update(elapsed:Float) {
    __timer += elapsed;
    strumLines.members[2].characters[0].x = (-100+350*Math.sin(__timer));
    strumLines.members[2].characters[0].y = (1500+450*Math.cos(__timer));
}

function create(){
defaultCamZoom = 0.60;
remove(strumLines.members[0].characters[0]);
remove(strumLines.members[3].characters[0]);
remove(strumLines.members[2].characters[0]);
add(strumLines.members[3].characters[0]);
add(strumLines.members[2].characters[0]);
add(strumLines.members[0].characters[0]);
strumLines.members[3].characters[0].alpha = 0.000;
strumLines.members[2].characters[0].alpha = 0.000;
}

function stepHit(){
if (curStep == 528){
strumLines.members[2].characters[0].alpha = 1;
FlxTween.tween(strumLines.members[2].characters[0], {y: -1100}, 2, {ease: FlxEase.quadInOut});
} 
if (curStep == 1042){
     FlxTween.tween(strumLines.members[2].characters[0].alpha = 0.000);
} 
if (curStep == 1042){
       FlxTween.tween(camHUD, {alpha: 0},.1);
} 
  if (curStep == 1048){
     dad.playAnim("xd");
    FlxTween.tween(dad, {y: 1500}, 1, {ease: FlxEase.quadInOut});
    SS_POWblock.alpha = 0.000;
} 
 if (curStep == 1050){
centerCams = true;
strumLines.members[3].characters[0].alpha = 1;
FlxTween.tween(dad, {y: 1500}, 1, {ease: FlxEase.quadInOut});
camHUD.alpha = 1;
} 
if (curStep == 1600){
   dad.alpha = 0.000;
 }
if (curStep == 1615){
    defaultCamZoom = 0.5;
strumLines.members[3].characters[0].alpha = 0.000;
dad.x = -3000;
dad.y = -3000;
 }

 if (curStep == 1623){
 dad.alpha = 1;
 FlxTween.tween(dad, {x: 0}, 2, {ease: FlxEase.quadInOut});
 FlxTween.tween(dad, {y: 0}, 2, {ease: FlxEase.quadInOut});

 }

if (curStep == 2056){
    defaultCamZoom = 0.7;
       SS_sky.alpha = 0.000;
       SS_castle.alpha = 0.000;
       Starman_BG_Fire_Assets.alpha = 0.000;
       Starman_BG_Fire.alpha = 0.000;
       SS_farplatforms.alpha = 0.000;
       SS_midplatforms.alpha = 0.000;
       SS_floor.alpha = 0.000;
       SS_foreground.alpha = 0.000;
  } 
if (curStep == 2075){
       FlxTween.tween(camHUD, {alpha: 0},1);
       FlxTween.tween(camGame, {alpha: 0},1);
  } 

}