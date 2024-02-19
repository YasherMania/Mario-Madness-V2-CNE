import flx3d.Flx3DView;
import away3d.lights.DirectionalLight;
import away3d.materials.lightpickers.StaticLightPicker;
import away3d.materials.methods.OutlineMethod;
import away3d.animators.transitions.CrossfadeTransition;
import away3d.events.AnimationStateEvent;
import flx3d.Flx3DUtil;
import openfl.system.System;
import away3d.core.base.Geometry;

import flixel.FlxCamera;

import flx3d.Flx3DCamera;
import flixel.FlxCamera;

public var light:DirectionalLight;
public var lightPicker:StaticLightPicker;

var stageFront:Mesh;
var opponent:Mesh;

var xOff:Int = 0;
var yOff:Int = 0;

var timer:Int = 0;
var timerMax:Int = 50;

var LEFT:Bool = false;
var DOWN:Bool = false;
var UP:Bool = false;
var RIGHT:Bool = false;

var turnSpd:Int = 5;
var moveSpd:Int = 10;

var xOppOff:Int = 0;
var yOppOff:Int = 0;

var ONE24TH_FRAME = 1/24;

// BF
var bfMesh;
// BF ANIMS
var bfAnimator;
var bfCurAnim:String;

// BF FINISH ANIM SHIT
var __bfTimer:Int = 0;

var bfFinished:Bool = true;
var bfFinishCallback = function () {};
var bfAnimLengths:Map<String, Float> = [ // TRUE LENGTH OF THE ANIMATION
        "idle" => ONE24TH_FRAME,
        "left" => ONE24TH_FRAME,
        "down" => ONE24TH_FRAME,
        "up" => ONE24TH_FRAME,
        "right" => ONE24TH_FRAME
];
var bfAnimsExtraTime:Map<String, Float> = [ // HOW LONG EXTRA YOU WANT THE ANIMATION TO STAY
        "idle" => 0,
        "left" => 0,
        "right" => 0,
        "up" => 0,
        "down" => 0
];
var bfGeometrys:Map<String, Geometry> = [
        "null" => null
];

var bfLastPlayedTimer:Int = 0;

// SHIT TO DEAL WITH THE DELAY OF THE UPDATE SEQEUNCES AND WHEN THE FUNCTION GETS CALLED
var bfDelay:Int = 0;
var bfTimerJustSet:Bool = false;

public var view:Flx3DView;
function postCreate() {
	dad.x -= 600;
	dad.cameraOffset.x += 200;
	dad.cameraOffset.y += 100;
        boyfriend.scale.x -= 0.4;
        boyfriend.scale.y -= 0.4;
        dad.scale.x -= 0.4;
        dad.scale.y -= 0.4;
	Flx3DUtil.is3DAvailable();
	view = new Flx3DView(0, 0, FlxG.width * 1, FlxG.height * 1);
	view.screenCenter();
	view.scrollFactor.set();
	view.antialiasing = true;
	//insert(members.indexOf(dad), view);
	insert(members.indexOf(dad), view);
	insert(members.indexOf(boyfriend), view);
        insert(members.indexOf(gf), view);


	view.addModel(Paths.obj("virtual"), function(model) {
		if (Std.string(model.asset.assetType) == "mesh") {
			model.asset.scale(150);
			model.asset.y -= 400;
			model.asset.rotationY = 180;
		}
	}, Paths.image("textures/virtual"), false);

}

function beatHit(curBeat){
        if (curBeat % 2 == 0)
                bfPlayAnim("idle", bfCurAnim == "idle" ? true : false);
}

function bfPlayAnim(anim, force) {
        if (bfAnimator != null && bfAnimator.animationSet.animationNames.indexOf(anim) != -1) {
                if (!bfFinished && !force) 
                        return;

                bfCurAnim = anim;
                bfAnimator.play(anim);

                // Update the Mesh
                if (bfGeometrys[anim] != null)
                        bfMesh.geometry = bfGeometrys[anim];

                bfLastPlayedTimer = __bfTimer;
                bfTimerJustSet = true;

                bfFinished = false;
        }
}


function onGamePause(event) {
        view.dirty3D = false;
}

function onSubstateClose(event) {
        view.dirty3D = true;
        if (bfAnimator != null)
                bfAnimator.time = __bfTimer;
}

public var lerpVal:Float = 0.04;
function update(elapsed:Float) {
	xOff = -200 -FlxG.camera.scroll.x;
        view.view.camera.x = FlxG.camera.scroll.x + 300;
        view.view.camera.y = -FlxG.camera.scroll.y + 100;
        view.view.camera.z = -2000 + (FlxG.camera.zoom * 1000);

        if (bfAnimator != null && !PlayState.paused) {
                __bfTimer += elapsed * 1000;
                bfAnimator.time = Math.round(__bfTimer);

                if (bfTimerJustSet) {
                        bfDelay = __bfTimer - bfLastPlayedTimer;
                        bfTimerJustSet = false;
                }

                var time = (Math.abs(__bfTimer - (bfLastPlayedTimer - bfDelay))) / 1000;

                if (!bfFinished) {
                        if (time > bfAnimLengths[bfCurAnim]) {
                                bfAnimator.stop();

                                if (time > bfAnimLengths[bfCurAnim] + bfAnimsExtraTime[bfCurAnim]) {
                                        bfFinished = true;
                                        bfFinishCallback();  
                                }
                
                        }   
                }  
        }

}
function destroy() {
    view.destroy();
}