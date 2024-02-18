var followchars = false;

function onCameraMove(e) {
    if (!followchars) e.cancel();
}

function onCountdown(e) e.cancel(); // Removes the countdown (as in sprites and sounds as it doesn't skip it last time I tested)

function postCreate() {
    if (!followchars) grandDadIntro(); // Me when I don't use events
    GameOverSubstate.script = 'data/gameOverScripts/grandDad';
}

function grandDadIntro() {
    Conductor.songPosition = 0; // Skips countdown
    camHUD.alpha = 0;
    /** 
    The number of times the default camera zoom has been changed:
        * Right before the cutscene starts: 0.65 (default)
        * When the cutscene is playing: 0.5
        * Right after the cutscene is done (after Mario jumps off of the logo): 0.4
    **/
    FlxTween.tween(camGame, {zoom: 0.5}, (2 * (1 / (Conductor.bpm / 60))), {startDelay: 0.3, ease: FlxEase.expoOut});

    var gdtitleSpr = stage.getSprite("gdtitle"); // Takes gdtitle's name property from the xml stage
    snapCamTo(
        gdtitleSpr.x + (gdtitleSpr.width / 2),
        gdtitleSpr.y + (gdtitleSpr.height / 2)
    );
    camGame.fade(FlxColor.BLACK, Conductor.crochet / 1500, true, function() {
        defaultCamZoom = 0.4;
        trace("camGame faded in");
    });
}

function snapCamTo(x:Float, y:Float) {
    camFollow.setPosition(x, y);
    camGame.snapToTarget();
}

function beatHit() {
    if (healthBar.percent > 80) {
        FlxTween.angle(icoP2, -5, -15, (0.5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.backOut, type: FlxTween.BACKWARD});
    }

    switch (curBeat) {
        case 3:
            camHUD.alpha = FlxTween.tween(camHUD, {alpha: 1}, Conductor.crochet / 3000);
            var hamster = stage.getSprite("hamster");
            FlxTween.quadMotion(
                hamster, // sprite
                hamster.x, hamster.y, // starting positions
                hamster.x - dad.x - 900, hamster.y - 400, // Curve controls I'm having trouble with (kept playing with it until I got a result that looked like the og)
                dad.x - 300, dad.y - 600, // To positions
                Conductor.crochet / 1000, true, // Duration
                {onComplete: function() remove(hamster)} // Self explanatory, right?
            );

        case 4: followchars = true;
        case 68: defaultCamZoom = 0.65;
    }
if (curBeat >= 4 && curBeat <= 228) {
    camZoomingInterval = 1;
} else if (curBeat >= 244 && curBeat <= 359) {
    camZoomingInterval = 1;
} else if (curBeat >= 392 && curBeat <= 404) {
    camZoomingInterval = 1;
} else {
    camZoomingInterval = 4;
}

    if (curBeat >= 100 && curBeat < 132){
        if (curBeat % 2 == 0){
            FlxTween.tween(camHUD, {angle: -3}, (0.1 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.expoOut, onComplete: function(twn:FlxTween){
                FlxTween.tween(camHUD, {angle: 0}, (0.9 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.expoIn});
            }});
        } else {
            FlxTween.tween(camHUD, {angle: 3}, (0.1 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                FlxTween.tween(camHUD, {angle: 0}, (0.9 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.expoIn});
            }});
        }
    }
}