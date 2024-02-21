// no miss + hunter glitch + bowser firebar (not yet)

public var fireBar:FlxSprite;

var iconGlitch:FlxSprite;
function postCreate() {
    iconGlitch = new FlxSprite().makeGraphic(Std.int(iconP1.width / 2), Std.int(iconP1.height / 2), FlxColor.WHITE);
    iconGlitch.cameras = [camHUD];
    iconGlitch.visible = false;
    insert(members.indexOf(iconP1) + 1, iconGlitch);

    fireBar = new FlxSprite(80, 750);
    fireBar.frames = Paths.getSparrowAtlas('stages/nesbeat/firebar');
    fireBar.animation.addByPrefix('loop', "firebar loop", 10, false);
    fireBar.scrollFactor.set(1.1, 1.1);
    fireBar.setGraphicSize(Std.int(fireBar.width * 6));
    fireBar.updateHitbox();
    fireBar.antialiasing = false;
    fireBar.visible = false;
    fireBar.animation.play('loop');
    fireBar.cameras = [camHUD];
    insert(members.indexOf(scoreTxt) - 1, fireBar);
}

function onEvent(_) {
    if (_.event.name == "Hunter Glitch") {
        iconGlitch.setPosition(icoP1.x + 60, icoP1.y + 30);
        iconGlitch.visible = true;
        new FlxTimer().start(0.05, function() {
            icoP1.color = 0x000000;
            iconGlitch.visible = false;
        });

        new FlxTimer().start(0.1, function() {
            icoP1.color = 0xFFFFFF;
        });

        FlxTween.num(health, health - 0.1, 0.1, {ease: FlxEase.quadOut}, (val) -> {
            health = val;
            healthBar.updateHitbox();
        });

        stage.getSprite("duckbg").color = 0xFFDAAFA9;
        new FlxTimer().start(0.2, function(tmr:FlxTimer) {
            stage.getSprite("duckbg").color = 0xFF5595DA;
        });

        FlxG.camera.zoom += 0.010;
        camHUD.zoom += 0.03;

        for (i in [camGame, camHUD, camEst]) {
            i.shake(0.007, 0.05);
            i.shake(0.003, 0.05);
        }
    }
}

function update(elapsed:Float) {
    if (fireBar.animation.finished) {
        fireBar.animation.play('loop');
        if (fireBar.angle >= (90 * 3))
            fireBar.angle = 0;
        else
            fireBar.angle += 90;
    }

    if (fireBar.visible) {
        var placeVals:Array<Dynamic> = [
            [270, 2, 7, 1.9],
            [0, 0, 2, 1.7],
            [0, 3, 4, 1.5],
            [0, 5, 7, 1],
            [90, 0, 3, 1.3]]
            ;

        for (i in 0... placeVals.length) {
            if (fireBar.angle == placeVals[i][0] && fireBar.animation.frameIndex >= placeVals[i][1] && fireBar.animation.frameIndex <= placeVals[i][2]) {
                if (health > placeVals[i][3]) {
                    health -= elapsed * 2;
                    FlxTween.angle(icoP1, FlxG.random.float(-20, 20), 0, ((1 / (Conductor.bpm / 60))), {ease: FlxEase.backOut});
                    FlxTween.color(icoP1, (1 / (Conductor.bpm / 60)), 0xFF3B3B3B, FlxColor.WHITE, {ease: FlxEase.circOut});
                }
            }
        }
    }
}

public var noMiss = false;
function onPlayerMiss() {
    if (noMiss)
        gameOver(boyfriend);
}