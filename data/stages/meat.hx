var __timer:Float = 0;
import flixel.addons.display.FlxBackdrop; 

function create(){
defaultCamZoom = 0.6;
strumLines.members[2].characters[0].alpha = 0.000;
strumLines.members[3].characters[0].alpha = 0.000;
strumLines.members[4].characters[0].alpha = 0.000;
strumLines.members[5].characters[0].alpha = 0.000;
strumLines.members[6].characters[0].alpha = 1;
TL_Meat_FG_bottomteeth.alpha = 0.000;
TL_Meat_CloseFG.alpha = 0.000;
TL_Meat_Pupil.alpha = 0.000;
TL_Meat_Fog.alpha = 0.000;
TL_Meat_FarBG.alpha = 0.000;
TL_Meat_FG_topteeth.alpha = 0.000;
TL_Meat_MedBG.alpha = 0.000;
TL_Meat_Ground.alpha = 0.000;
Overdue_Final_BG_topfixed.alpha = 0.000;
Overdue_Final_BG_floorfixed.alpha = 0.000;
TL_Meat_FG_string.alpha = 0.000;
TL_Meat_BG.alpha = 0.000;
TL_Meat_Sky.alpha = 0.000;

strumLines.members[3].characters[0].x = boyfriend.x;
strumLines.members[3].characters[0].y = boyfriend.y;
strumLines.members[5].characters[0].x = gf.x;
strumLines.members[5].characters[0].y = gf.y;
strumLines.members[4].characters[0].x = boyfriend.x + 20;
strumLines.members[4].characters[0].y = boyfriend.y - -390;
strumLines.members[6].characters[0].velocity.set(-290, 0);
strumLines.members[6].characters[0].FlxBackdrop;
//run

}

function update(elapsed:Float) {
     __timer += elapsed;
    strumLines.members[2].characters[0].y = (-650+-50*Math.cos(__timer));
}

function postUpdate(elapsed:Float){

switch(curCameraTarget) {
  case 0:
        
        defaultCamZoom = 0.4;
  case 1:

        defaultCamZoom = 0.6;
   }
}           
function stepHit(){
    if (curStep == 284){
boyfriend.alpha = 0.000;
strumLines.members[3].characters[0].alpha = 1;
}
  if (curStep == 304){
boyfriend.alpha = 1;
strumLines.members[3].characters[0].alpha = 0.000;
defaultCamZoom = 0.4;
}
      if (curStep == 544){
boyfriend.alpha = 0.000;
strumLines.members[3].characters[0].alpha = 1;
}
  if (curStep == 561){
boyfriend.alpha = 1;
strumLines.members[3].characters[0].alpha = 0.000;
  }
  if (curStep == 1072){
TL_Meat_FG_bottomteeth.alpha = 1;
TL_Meat_CloseFG.alpha = 1;
TL_Meat_Pupil.alpha = 1;
TL_Meat_Fog.alpha = 1;
TL_Meat_FarBG.alpha = 1;
TL_Meat_FG_topteeth.alpha = 1;
TL_Meat_MedBG.alpha = 1;
TL_Meat_Ground.alpha = 1;
Overdue_Final_BG_topfixed.alpha = 1;
Overdue_Final_BG_floorfixed.alpha = 1;
TL_Meat_FG_string.alpha = 1;
TL_Meat_BG.alpha = 1;
TL_Meat_Sky.alpha = 1;
BackTrees.alpha = 0.000;
FrontTrees.alpha = 0.000;
Road.alpha = 0.000;
car.alpha = 0.000;
ForegroundTrees.alpha = 0.000;
boyfriend.y = -130;
boyfriend.x = 330;
  }
  if (curStep == 1728){
  FlxTween.tween(strumLines.members[2].characters[0], {alpha: .8},7); 

   }
 if (curStep == 2160){
  FlxTween.tween(strumLines.members[2].characters[0], {alpha: 0},.1); 
  FlxTween.tween(strumLines.members[5].characters[0], {alpha: 0}, .5); 
   }
 if (curStep == 2161){
   strumLines.members[3].characters[0].alpha = 1;
   boyfriend.alpha = 0.000;
  
   }
if (curStep == 2068){
     FlxTween.tween(TL_Meat_FG_bottomteeth, {alpha: 0},8); 
     FlxTween.tween(TL_Meat_CloseFG, {alpha: 0},8); 
     FlxTween.tween(TL_Meat_Pupil, {alpha: 0},8); 
     FlxTween.tween(TL_Meat_Fog, {alpha: 0},8); 
     FlxTween.tween(TL_Meat_FG_topteeth, {alpha: 0},8); 
     FlxTween.tween(TL_Meat_MedBG, {alpha: 0},8); 
     FlxTween.tween(TL_Meat_Ground, {alpha: 0},8); 
     FlxTween.tween(TL_Meat_FG_string, {alpha: 0},8); 
     FlxTween.tween(TL_Meat_BG, {alpha: 0},8); 
     FlxTween.tween(TL_Meat_Sky, {alpha: 0},8); 
   }
 if (curStep == 2172){
   strumLines.members[3].characters[0].alpha = 0.000;
   strumLines.members[4].characters[0].alpha = 1;
   boyfriend.alpha = 1;
   remove(boyfriend);
   remove(strumLines.members[4].characters[0]);
   add(strumLines.members[4].characters[0]);
   add(boyfriend);
   }

}