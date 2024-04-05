//
import flixel.addons.display.FlxBackdrop;
import flixel.input.mouse.FlxMouseEventManager;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.system.framerate.FramerateCategory;
import openfl.Lib;

public var topCam:FlxCamera;
public var botCam:FlxCamera;

public var titleGroup:FlxTypedGroup<FlxSprite>;

public var topChecker:FlxBackdrop;
public var botChecker:FlxBackdrop;

public var rulesGroup:FlxTypedGroup<FlxSprite>;

public var textGroup:FlxGroup;
public var logo:FlxSprite;

public var canStart:Bool = false;
public var canStart2:Bool = false;

public var textPlaces:Array<Int> = [
	15,
	50, // M
	37,
	51, // A
	68,
	49, // R
	89,
	49, // I
	101,
	56, // O
	130,
	49, // P
	142,
	51, // A
	172,
	49, // R
	189,
	52, // T
	211,
	48, // Y
	97,
	78, // D
	125,
	78 // S
];

function create(){
	if(FlxG.sound.music != null) FlxG.sound.music.stop();
	FlxG.mouse.visible = true;
	FlxG.sound.soundTrayEnabled = false;

	bgColor = 0xFF000000;

	for (i in [Framerate.fpsCounter, Framerate.memoryCounter, Framerate.codenameBuildField]) i.visible = false;

	topCam = new FlxCamera(0, -600, 256, 192, 2);
	topCam.bgColor = 0xFF000000;
	botCam = new FlxCamera(0, -216, 256, 192, 2);
	botCam.bgColor = 0xFF000000;

	FlxG.cameras.add(topCam);
	FlxG.cameras.add(botCam);

	Lib.current.scaleX = 2.5;
	Lib.current.scaleY = 2.5;
	window.move(window.x + Std.int((window.width - 512) / 2), window.y + Std.int((window.height - 768) / 2));
	FlxG.resizeWindow(512, 768);
	FlxG.resizeGame(512, 768);
	window.resizable = false;
	FlxG.sound.volume = 1;

	// top title screen

	// TODO: put all this shit into a function so i can replay it after demo sequence
	titleGroup = new FlxTypedGroup();
	add(titleGroup);

	topBg = new FlxSprite(0, 0).loadGraphic(Paths.image('game/mpds/topbg'));
	topBg.antialiasing = false;
	topBg.cameras = [topCam];
	titleGroup.add(topBg);

	topFlowers = new FlxSprite(0, 20).loadGraphic(Paths.image('game/mpds/topflowers'));
	topFlowers.antialiasing = false;
	topFlowers.cameras = [topCam];
	titleGroup.add(topFlowers);

	topCoinStatic = new FlxSprite(0, 35).loadGraphic(Paths.image('game/mpds/staticCoins'));
	topCoinStatic.antialiasing = false;
	topCoinStatic.cameras = [topCam];
	titleGroup.add(topCoinStatic);

	topCoinSmallLeft = new FlxSprite(0, 35);
	topCoinSmallLeft.frames = Paths.getSparrowAtlas('game/mpds/Coins');
	topCoinSmallLeft.animation.addByPrefix('idle', 'small coin left screen', 28, true);
	topCoinSmallLeft.antialiasing = false;
	topCoinSmallLeft.cameras = [topCam];
	titleGroup.add(topCoinSmallLeft);

	topCoinSmallRight = new FlxSprite(0, 35);
	topCoinSmallRight.frames = Paths.getSparrowAtlas('game/mpds/Coins');
	topCoinSmallRight.animation.addByPrefix('idle', 'small coin right screen', 20, true);
	topCoinSmallRight.antialiasing = false;
	topCoinSmallRight.cameras = [topCam];
	titleGroup.add(topCoinSmallRight);

	topCoinBigLeft = new FlxSprite(0, 35);
	topCoinBigLeft.frames = Paths.getSparrowAtlas('game/mpds/Coins');
	topCoinBigLeft.animation.addByPrefix('idle', 'big coin left screen', 20, true);
	topCoinBigLeft.antialiasing = false;
	topCoinBigLeft.cameras = [topCam];
	titleGroup.add(topCoinBigLeft);

	topCoinBigRight = new FlxSprite(0, 35);
	topCoinBigRight.frames = Paths.getSparrowAtlas('game/mpds/Coins');
	topCoinBigRight.animation.addByPrefix('idle', 'big coin right screen', 32, true);
	topCoinBigRight.antialiasing = false;
	topCoinBigRight.cameras = [topCam];
	titleGroup.add(topCoinBigRight);

	topStar = new FlxSprite(90, 175);
	topStar.frames = Paths.getSparrowAtlas('game/mpds/MPDS_Star');
	topStar.animation.addByPrefix('idle', 'star anim', 24, true);
	topStar.antialiasing = false;
	topStar.cameras = [topCam];
	titleGroup.add(topStar);

	topDice = new FlxSprite(22, 142);
	topDice.frames = Paths.getSparrowAtlas('game/mpds/MPDS_Star');
	topDice.animation.addByPrefix('idle', 'dice anim', 24, true);
	topDice.antialiasing = false;
	topDice.cameras = [topCam];
	titleGroup.add(topDice);

	//bottom title screen

	botBg = new FlxSprite(0, 0).loadGraphic(Paths.image('game/mpds/botbg'));
	botBg.antialiasing = false;
	botBg.cameras = [botCam];
	titleGroup.add(botBg);

	botFlowers = new FlxSprite(0, 20).loadGraphic(Paths.image('game/mpds/botflowers'));
	botFlowers.antialiasing = false;
	botFlowers.cameras = [botCam];
	titleGroup.add(botFlowers);

	sideChars = new FlxSprite(0, 20).loadGraphic(Paths.image('game/mpds/sidechars'));
	sideChars.antialiasing = false;
	sideChars.cameras = [botCam];
	titleGroup.add(sideChars);

	mainChars = new FlxSprite(0, 60).loadGraphic(Paths.image('game/mpds/mainchars'));
	mainChars.antialiasing = false;
	mainChars.cameras = [botCam];
	titleGroup.add(mainChars);

	touchStart = new FlxSprite(61, 159).loadGraphic(Paths.image('game/mpds/touchtostart'));
	touchStart.antialiasing = false;
	touchStart.cameras = [botCam];
	touchStart.visible = false;
	titleGroup.add(touchStart);

	titleTouch = new FlxSprite().makeGraphic(Std.int(256 * botCam.zoom), Std.int(192 * botCam.zoom), FlxColor.WHITE);
	// titleTouch.setGraphicSize(Std.int(titleTouch.width * botCam.zoom));
	titleTouch.setPosition(0, botCam.y);
	// titleTouch.cameras = [botCam];
	titleTouch.alpha = 0.0001;
	titleGroup.add(titleTouch);

	topChecker = new FlxBackdrop(Paths.image('game/mpds/rules/checkerboard'));
	topChecker.x = topChecker.y = 0;
	topChecker.velocity.set(24, 16);
	topChecker.antialiasing = false;
	topChecker.cameras = [topCam];
	topChecker.visible = false;
	topChecker.updateHitbox();
	add(topChecker);

	botChecker = new FlxBackdrop(Paths.image('game/mpds/rules/checkerboard'));
	botChecker.x = botChecker.y = 0;
	botChecker.velocity.set(24, 16);
	botChecker.antialiasing = false;
	botChecker.cameras = [botCam];
	botChecker.visible = false;
	botChecker.updateHitbox();
	add(botChecker);

	rulesGroup = new FlxTypedGroup();
	rulesGroup.visible = false;
	add(rulesGroup);

	topBorder = new FlxSprite(0, 0).loadGraphic(Paths.image('game/mpds/rules/topBorder'));
	topBorder.antialiasing = false;
	topBorder.cameras = [topCam];
	rulesGroup.add(topBorder);

	botBorder = new FlxSprite(0, 0).loadGraphic(Paths.image('game/mpds/rules/botBorder'));
	botBorder.antialiasing = false;
	botBorder.cameras = [botCam];
	rulesGroup.add(botBorder);

	leftTouch = new FlxSprite().makeSolid(Std.int(17 * botCam.zoom), Std.int(23 * botCam.zoom), FlxColor.BLACK);
	leftTouch.setGraphicSize(Std.int(leftTouch.width * botCam.zoom));
	leftTouch.setPosition(20 * botCam.zoom, botCam.y);
	leftTouch.alpha = 0.0001;
	// leftTouch.cameras = [botCam];

	rightTouch = new FlxSprite().makeSolid(Std.int(17 * botCam.zoom), Std.int(23 * botCam.zoom), FlxColor.WHITE);
	rightTouch.setGraphicSize(Std.int(rightTouch.width * botCam.zoom));
	rightTouch.setPosition(222 * botCam.zoom, botCam.y);
	rightTouch.alpha = 0.0001;
	// rightTouch.cameras = [botCam];

	tipsTouch = new FlxSprite().makeSolid(Std.int(92 * botCam.zoom), Std.int(23 * botCam.zoom), FlxColor.BLACK);
	tipsTouch.setGraphicSize(Std.int(tipsTouch.width * botCam.zoom));
	tipsTouch.setPosition(130 * botCam.zoom, botCam.y);
	tipsTouch.alpha = 0.0001;
	// tipsTouch.cameras = [botCam];

	rulesTouch = new FlxSprite().makeSolid(Std.int(92 * botCam.zoom), Std.int(23 * botCam.zoom), FlxColor.WHITE);
	rulesTouch.setPosition(38 * botCam.zoom, botCam.y);
	rulesTouch.alpha = 0.0001;
	// rulesTouch.cameras = [botCam];

	startTouch = new FlxSprite().makeSolid(Std.int(70 * botCam.zoom), Std.int(28 * botCam.zoom), FlxColor.WHITE);
	startTouch.setPosition(92 * botCam.zoom, botCam.y + (164 * botCam.zoom));
	trace(startTouch.y);
	startTouch.alpha = 0.0001;

	botTips = new FlxSprite(0, 0).loadGraphic(Paths.image('game/mpds/rules/tips'));
	botTips.antialiasing = false;
	botTips.cameras = [botCam];
	botTips.visible = false;
	rulesGroup.add(botTips);

	botRules = new FlxSprite(0, 0).loadGraphic(Paths.image('game/mpds/rules/rules'));
	botRules.antialiasing = false;
	botRules.cameras = [botCam];
	rulesGroup.add(botRules);

	botStart = new FlxSprite(0, 0).loadGraphic(Paths.image('game/mpds/rules/startbutton'));
	botStart.antialiasing = false;
	botStart.cameras = [botCam];
	rulesGroup.add(botStart);

	textGroup = new FlxGroup();
	add(textGroup);

	logo = new FlxSprite(0, 0).loadGraphic(Paths.image('game/mpds/textComplete'));
	logo.antialiasing = false;
	logo.cameras = [topCam];
	logo.alpha = 0.00001;
	titleGroup.add(logo);

	nintendo = new FlxSprite(0, 0).loadGraphic(Paths.image('game/mpds/nintendo'));
	nintendo.antialiasing = false;
	nintendo.cameras = [topCam];
	add(nintendo);

	hudson = new FlxSprite(0, 0).loadGraphic(Paths.image('game/mpds/hudson'));
	hudson.antialiasing = false;
	hudson.cameras = [botCam];
	add(hudson);

	hiderT = new FlxSprite(0, 0).makeSolid(256, 192, FlxColor.BLACK);
	hiderT.cameras = [topCam];
	add(hiderT);

	hiderB = new FlxSprite(0, 0).makeSolid(256, 192, FlxColor.BLACK);
	hiderB.cameras = [botCam];
	add(hiderB);

	FlxTween.tween(hiderT, {alpha: 0}, 1);
	FlxTween.tween(hiderB, {alpha: 0}, 1);

	// TODO: make skippable
	// TODO: floaty shit
	// TODO: other non floaty shit
	// I gotchu -- nate :dave:
	new FlxTimer().start(2.5, function(t:FlxTimer){
		FlxTween.tween(hiderT, {alpha: 1}, 1, {
			onComplete: function(t:FlxTween){
				nintendo.visible = false;
				FlxTween.tween(hiderT, {alpha: 0}, 1);
			}
		});
		FlxTween.tween(hiderB, {alpha: 1}, 1, {
			onComplete: function(t:FlxTween){
				hudson.visible = false;
				FlxG.sound.playMusic(Paths.sound('mpds/mpds-intro'), 0.7);
				FlxTween.tween(hiderB, {alpha: 0}, 1);
			}
		});
		FlxTween.tween(logo, {alpha: 1}, 0.15, {
			startDelay: 6.7,
			onComplete: function(t:FlxTween){
				textGroup.forEach(function(b:FlxBasic){
					b.destroy();
				});
				textGroup.destroy();
			}
		});
		new FlxTimer().start(8, function(tmr:FlxTimer){
			canStart = true;
			new FlxTimer().start(0.45, function(tmr:FlxTimer){
				touchStart.visible = !touchStart.visible;
			}, 0);
		});
		// wow
		for (i in [topFlowers, topCoinStatic, topCoinSmallLeft, topCoinSmallRight, topCoinBigLeft, topCoinBigRight, botFlowers, sideChars, mainChars]){
			FlxTween.tween(i, {y: 0}, 2.671, {startDelay: 1, ease: FlxEase.smoothStepOut});
		}
		FlxTween.tween(topStar, {y: 140}, 2.671, {startDelay: 1, ease: FlxEase.smoothStepOut});
		FlxTween.tween(topDice, {y: 107}, 2.671, {startDelay: 1, ease: FlxEase.smoothStepOut});

		for (i in [topStar, topDice, topCoinSmallLeft, topCoinSmallRight, topCoinBigLeft, topCoinBigRight]) {
			i.animation.play("idle", true);
			i.updateHitbox();
		}

		var textSpritesheet = Paths.getSparrowAtlas('game/mpds/title_text');

		var i:Int = 9;
		while (i >= 0){
			var temp:FlxSprite = new FlxSprite(textPlaces[i * 2], textPlaces[i * 2 + 1] - 100);
			temp.frames = textSpritesheet;
			temp.animation.addByPrefix('idle', 'text' + Std.string(i) + "_idle", 24, false);
			temp.animation.play("idle", true);
			temp.antialiasing = false;
			temp.cameras = [topCam];
			textGroup.add(temp);
			FlxTween.tween(temp, {y: textPlaces[i * 2 + 1] + 5}, 0.665, {startDelay: 1 + 2.671 + i * 0.14});
			FlxTween.tween(temp, {y: textPlaces[i * 2 + 1]}, 0.1, {startDelay: 1 + 2.671 + i * 0.14 + 0.665});
			i--;
		}
		for (i in 10...12){
			var temp:FlxSprite = new FlxSprite(textPlaces[i * 2], textPlaces[i * 2 + 1]);
			temp.frames = textSpritesheet;
			temp.animation.addByPrefix('idle', 'text' + Std.string(i) + "_idle", 24, false);
			temp.animation.play("idle", true);
			temp.antialiasing = false;
			temp.scale.set(0, 0);
			temp.cameras = [topCam];
			textGroup.add(temp);
			FlxTween.tween(temp.scale, {x: 1.2, y: 1.2}, 0.3, {startDelay: 1 + 4.625 + (i - 10) * 0.665});
			FlxTween.tween(temp.scale, {x: 1, y: 1}, 0.07, {startDelay: 1 + 4.625 + (i - 10) * 0.665 + 0.3});
		}
	});
}

function update(elapsed:Float){
	if (canStart2 && (FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.RIGHT))
		clickAction(2);
	if (FlxG.keys.justPressed.A){
		if (canStart)
			clickAction(4);
		if (canStart2)
			clickAction(3);
	}

	if (FlxG.mouse.justPressed){
		if (canStart2){
			if (FlxG.mouse.overlaps(rulesTouch))
				clickAction(0);
			else if (FlxG.mouse.overlaps(tipsTouch))
				clickAction(1);
			else if (FlxG.mouse.overlaps(leftTouch))
				clickAction(2);
			else if (FlxG.mouse.overlaps(rightTouch))
				clickAction(2);
			else if (FlxG.mouse.overlaps(startTouch))
				clickAction(3);
		}
		if (canStart && FlxG.mouse.overlaps(titleTouch))
			clickAction(4);
	}
}

function clickAction(num:Int){
	switch(num){
		case 0:
			//clicked rules button
			if (!botRules.visible){
				FlxG.sound.play(Paths.sound('mpds/mpds-switch'), 0.3);
				botRules.visible = true;
				botTips.visible = false;
			}
		case 1:
			//clicked tips button
			if (!botTips.visible){
				FlxG.sound.play(Paths.sound('mpds/mpds-switch'), 0.3);
				botRules.visible = false;
				botTips.visible = true;
			}
		case 2:
			//clicked either arrow
			FlxG.sound.play(Paths.sound('mpds/mpds-switch'), 0.3);
			botRules.visible = !botRules.visible;
			botTips.visible = !botTips.visible;
		case 3:
			//clicked start button
			canStart2 = false;
			FlxG.sound.play(Paths.sound('mpds/mpds-confirm'), 0.3);
			//FlxTween.tween(FlxG.sound, {volume: 0}, 1);
			FlxTween.tween(botStart, {y: 5}, 0.125, {
				onComplete: function(t:FlxTween){
					FlxTween.tween(botStart, {y: 0}, 0.125, {
						onComplete: function(t:FlxTween){
							//whatever needs to be done here to make the song start dewott help pls
							// :dave:
							// you guys fucking suck at coding - syrup
							botStart.visible = false;
							FlxTween.tween(hiderT, {alpha: 1}, 1);
							FlxTween.tween(hiderB, {alpha: 1}, 1, {
								onComplete: function(t:FlxTween){
									//whatever needs to be done here to make the song start dewott help pls
									// :dave:
									// why is this here again - syrup
									var thesong:String = "bopeebo"; // replace this with no party when thats fully ported!
									PlayState.loadSong(thesong, "hard");
									FlxG.switchState(new PlayState());
									FlxG.sound.music.stop();
								}});
						}});
				}});
		case 4:
			//clicked touch screen on title
			canStart = false;
			touchStart.destroy();
			titleTouch.destroy();
			FlxG.sound.play(Paths.sound('mpds/mpds-start'), 0.6);
			FlxTween.tween(hiderT, {alpha: 1}, 1);
			FlxTween.tween(hiderB, {alpha: 1}, 1);
			FlxTween.tween(FlxG.sound, {volume: 0}, 1, {
				onComplete: function(t:FlxTween){
					FlxG.sound.music.stop();
					titleGroup.visible = false;
					rulesGroup.visible = true;
					// insert(members.indexOf(botBorder) - 1, botChecker);
					// insert(members.indexOf(topBorder) - 1, topChecker);
					botChecker.visible = true;
					topChecker.visible = true;
					FlxG.sound.playMusic(Paths.sound('mpds/mpds-minigame'), 0.5);
					FlxTween.tween(hiderT, {alpha: 0}, 1);
					FlxTween.tween(hiderB, {alpha: 0}, 1);
					FlxTween.tween(FlxG.sound, {volume: 1}, 1, {
						onComplete: function(t:FlxTween){
							canStart2 = true;
							rulesGroup.add(rulesTouch);
							rulesGroup.add(tipsTouch);
							rulesGroup.add(leftTouch);
							rulesGroup.add(rightTouch);
							rulesGroup.add(startTouch);
						}});
				}
			});
	}
}