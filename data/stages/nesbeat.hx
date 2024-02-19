// silly

import flixel.addons.display.FlxBackdrop;

public var duckbg:FlxSprite;

var nesTweens:Array<FlxTween> = [];
var nesTimers:Array<FlxTimer> = [];

public var cutbg:FlxSprite;
public var cutskyline:FlxSprite;
public var cutstatic:FlxSprite;

function postCreate() {
	lofiTweensToBeCreepyTo(bg);
	new FlxTimer().start(21.5, function(timer:FlxTimer) {
		lofiTweensToBeCreepyTo(bg);
	}, 0);

	blackBarThingie.alpha = 0;
	duckbg.color = 0xFF5595DA;

	for (i in [blackinfrontobowser, blackBarThingie, duckbg]) {
		i.scrollFactor.set();
		i.screenCenter();
	}

	for (i in [duckbg, ducktree, duckleafs, duckfloor]) {
		i.scale.set(6.5, 6.5);
		i.updateHitbox();
		i.antialiasing = false;
		i.alpha = 0.001;
	}
	
	duckfloor.screenCenter(FlxAxes.X);
	
	ycbuCrosshair.screenCenter();
	ycbuCrosshair.cameras = [camEst];
	ycbuCrosshair.visible = false;

	for (i in [bowbg, bowbg2, bowplat, bowlava]) {
		i.alpha = 0.0001;
	}

	screencolor.scrollFactor.set();
	screencolor.screenCenter();
	screencolor.alpha = 0.0001;

	for (i in [cutbg = new FlxSprite(800, 300), cutskyline = new FlxSprite(800, 300)]) {
		i.frames = Paths.getSparrowAtlas("stages/nesbeat/staticbg");
		i.scrollFactor.set(0.2, 0.2);
		i.scale.set(2.61, 2.61);
		i.updateHitbox();
		i.animation.addByPrefix('duck', "staticbg duck", 15, true);
		i.animation.addByPrefix('bowser', "staticbg castle", 15, true);
		i.visible = false;
		i.screenCenter(FlxAxes.XY);
		i.antialiasing = true;
		insert(members.indexOf(screencolor) + 1, i);
	}

	cutstatic = new FlxSprite(800, 300);
	cutstatic.frames = Paths.getSparrowAtlas("stages/nesbeat/static");
	cutstatic.animation.addByPrefix('idle', "static idle", 15, true);
	cutstatic.animation.play('idle');
	cutstatic.scrollFactor.set(0.2, 0.2);
	cutstatic.scale.set(1.3, 1.3);
	cutstatic.updateHitbox();
	cutstatic.visible = false;
	cutstatic.screenCenter(FlxAxes.XY);
	cutstatic.antialiasing = true;
	insert(members.indexOf(screencolor) + 3, cutstatic);
}

function lofiTweensToBeCreepyTo(sprite:FlxSprite) {
	var tempx = sprite.x;

	var twn = FlxTween.tween(sprite, {x: tempx + 420, angle: -35}, 4.0);

	function tww(tween:FlxTween) {
		return twn.then(tween);
	}

	twn = tww(FlxTween.tween(sprite, {angle: 20}, 2.0));
	twn = tww(FlxTween.tween(sprite, {x: tempx + 400, angle: 30}, 2.0));
	twn = tww(FlxTween.tween(sprite, {x: tempx + 420, angle: 0}, 2.0));
	twn = tww(FlxTween.tween(sprite, {x: tempx + 520, angle: -15}, 3.0));
	twn = tww(FlxTween.tween(sprite, {angle: 10}, 1.5));
	twn = tww(FlxTween.tween(sprite, {x: tempx - 50, angle: -40}, 5.5));
	twn = tww(FlxTween.tween(sprite, {x: tempx, angle: 0}, 1.5));

	/*FlxTween.tween(sprite, {x: tempx + 420, angle: -35}, 4.0, {onComplete: function(tween:FlxTween) {
		FlxTween.tween(sprite, {angle: 20}, 2.0, {onComplete: function(tween:FlxTween) {
			FlxTween.tween(sprite, {x: tempx + 400, angle: 30}, 2.0, {onComplete: function(tween:FlxTween) {
				FlxTween.tween(sprite, {x: tempx + 420, angle: 0}, 2.0, {onComplete: function(tween:FlxTween) {
					FlxTween.tween(sprite, {x: tempx + 520, angle: -15}, 3.0, {onComplete: function(tween:FlxTween) {
						FlxTween.tween(sprite, {angle: 10}, 1.5, {onComplete: function(tween:FlxTween) {
							FlxTween.tween(sprite, {x: tempx - 50, angle: -40}, 5.5, {onComplete: function(tween:FlxTween) {
								FlxTween.tween(sprite, {x: tempx, angle: 0}, 1.5);
							}});
						}});
					}});
				}});
			}});
		}});
	}});*/
}