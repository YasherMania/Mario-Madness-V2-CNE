import flixel.addons.display.FlxBackdrop;
var act2_scroll1:FlxBackdrop;

function postUpdate(elapsed:Float){

switch(curCameraTarget) {
  case 0:
        
        defaultCamZoom = 0.4;
  case 1:

        defaultCamZoom = 0.6;
 case 2:
        
        defaultCamZoom = 0.5;
  case 3:

        defaultCamZoom = 0.6;
  case 4:

        defaultCamZoom = 0.5;
   }
}           

function create(){
strumLines.members[3].characters[0].x = -600;
strumLines.members[3].characters[0].y = 700;
strumLines.members[3].characters[0].alpha = 0.000;
strumLines.members[4].characters[0].alpha = 0.000;
strumLines.members[4].characters[0].y = 550;
strumLines.members[4].characters[0].x = 800;
strumLines.members[5].characters[0].x = boyfriend.x;
strumLines.members[5].characters[0].y = boyfriend.y;
strumLines.members[5].characters[0].alpha = 0.000;
defaultCamZoom = 1.1;
camHUD.alpha = 0.000;
spotlight.alpha = 0.000;
act1_sky.alpha = 0.000;
act1_skyline.alpha = 0.000;
act1_bgbuildings.alpha = 0.000;
act1_floor.alpha = 0.000;
act1_fg.alpha = 0.000;
gf.alpha = 0.000;
boyfriend.alpha = 0.0000;
act2_scroll1.alpha = 0.000;
act2_pipes_far.alpha = 0.000;
act2_pipes_middle.alpha = 0.000;
act2_abyss_gradient.alpha = 0.000;
act2_pipes_close.alpha = 0.000;
act2_pipes_lgbf.alpha = 0.000;
act2_pipes_L.alpha = 0.000;
act2_static.alpha = 0.000;
Act3_Ultra_Pupils.alpha = 0.000;
act3.alpha = 0.000;
act3Spotlight.alpha = 0.000;
Act3_bfpipe.alpha = 0.000;
Act3_Ultra_M.alpha = 0.000;
Act3_Hills.alpha = 0.000;
}

function stepHit(){
if (curStep == 31){
camHUD.alpha = 1;
act1_sky.alpha = 1;
act1_skyline.alpha = 1;
act1_bgbuildings.alpha = 1;
act1_floor.alpha = 1;
act1_fg.alpha = 1;
gf.alpha = 1;
boyfriend.alpha = 1;
defaultCamZoom = .4;
   }
if (curStep == 1055){
camHUD.alpha = 0.000;
act1_sky.alpha = 0.000;
act1_skyline.alpha = 0.000;
act1_bgbuildings.alpha = 0.000;
act1_floor.alpha = 0.000;
act1_fg.alpha = 0.000;
gf.alpha = 0.000;
boyfriend.alpha = 0.000;
defaultCamZoom = .1;
FlxTween.tween(dad, {alpha: 0}, .5, {ease: FlxEase.quadInOut});
   }
if (curStep == 1067){

dad.alpha = 1;

   }

if (curStep == 1072){
camHUD.alpha = 1;
boyfriend.x = act2_pipes_lgbf.x;
act2_scroll1.alpha = 1;
act2_pipes_far.alpha = 1;
act2_pipes_middle.alpha = 1;
act2_abyss_gradient.alpha = 1;
act2_pipes_close.alpha = 1;
act2_pipes_lgbf.alpha = 1;
act2_pipes_L.alpha = 1;
act2_static.alpha = 1;
boyfriend.alpha = 1;
defaultCamZoom = .3;
gf.y = -654;
gf.x = 0;
gf.alpha = 1;
defaultCamZoom = .9;
 }
if (curStep == 1582){
FlxTween.tween(act2_pipes_L, {y: -654}, 4, {ease: FlxEase.quadInOut});
FlxTween.tween(gf, {y: -454}, 4, {ease: FlxEase.quadInOut});
gf.alpha = 1;
dad.alpha = 0.000;
 }
if (curStep == 1648){
FlxTween.tween(act2_pipes_war, {y: -554}, 4, {ease: FlxEase.quadInOut});
FlxTween.tween(strumLines.members[3].characters[0], {y: -100}, 4, {ease: FlxEase.quadInOut});
strumLines.members[3].characters[0].alpha = 1;
dad.alpha = 0.000;
act2_pipes_war.alpha = 1;

 }

if (curStep == 1712){
FlxTween.tween(act2_pipes_yosh, {y: -654}, 4, {ease: FlxEase.quadInOut});
FlxTween.tween(strumLines.members[4].characters[0], {y: -50}, 3.6, {ease: FlxEase.quadInOut});
strumLines.members[4].characters[0].alpha = 1;
dad.alpha = 0.000;
act2_pipes_yosh.alpha = 1;
  }
if (curStep == 2229){
FlxTween.tween(camHUD, {alpha: 0}, .1, {ease: FlxEase.quadInOut});
FlxTween.tween(camGame, {alpha: 0}, .1, {ease: FlxEase.quadInOut});
act2_scroll1.alpha = 0.000;
act2_pipes_far.alpha = 0.000;
act2_pipes_middle.alpha = 0.000;
act2_abyss_gradient.alpha = 0.000;
act2_pipes_close.alpha = 0.000;
act2_pipes_lgbf.alpha = 0.000;
act2_pipes_L.alpha = 0.000;
act2_pipes_L.alpha = 0.000;
act2_pipes_L.alpha = 0.000;
act2_static.alpha = 0.000;
act2_pipes_war.alpha = 0.000;
act2_pipes_yosh.alpha = 0.000;
dad.alpha = 1;
  }
if (curStep == 2255){
FlxTween.tween(camHUD, {alpha: 1}, 1, {ease: FlxEase.quadInOut});
FlxTween.tween(camGame, {alpha: 1}, .1, {ease: FlxEase.quadInOut});
FlxTween.tween(act3Spotlight, {alpha: 0}, 2, {ease: FlxEase.quadInOut});
boyfriend.alpha = 1;
Act3_Ultra_Pupils.alpha =  1;
act3.alpha =  1;
act3Spotlight.alpha =  1;
Act3_bfpipe.alpha =  1;
Act3_Ultra_M.alpha =  1;
Act3_Hills.alpha =  1;
gf.alpha = 1;
gf.x = -200;
gf.y = 400;
strumLines.members[3].characters[0].alpha = 0.000;
strumLines.members[4].characters[0].alpha = 0.000;

 }

if (curStep == 3504){
camHUD.alpha = 0.000;
defaultCamZoom = 1.1;
 }
if (curStep == 3620){
camHUD.alpha = 1.;
defaultCamZoom = .6; 
 }
}