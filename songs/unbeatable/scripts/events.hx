// welcome to hell, i'll be your host

import flixel.text.FlxText.FlxTextAlign;
import flixel.addons.display.FlxBackdrop;

var camMovement:Bool = true;

introLength = 4;
function onCountdown(e)
    e.cancel();

public var dadChars:Map<String, Character> = [];
public var dadSingFocus:Array = [];

// public var bowserMainSinging:Bool = true;
// public var sysMainSinging:Bool = false;

function create() {
    camHUD.alpha = 0;
    for (i in cpuStrums.characters) i.visible = false;
    for (i in [boyfriend, gf]) i.visible = false;

    for (sL in strumLines)
        sL.onNoteUpdate.add(function(event) {
            event.note.alpha = event.strum.alpha;
            if (event.note.isSustainNote)
                event.note.alpha *= 0.6;
        });
}

public var beatText:FlxText;
public var beatText2:FlxText;

public var ycbuLightningL:FlxSprite;
public var ycbuLightningR:FlxSprite;
public var ycbuHeadL:FlxBackdrop;
public var ycbuHeadR:FlxBackdrop;

public var clownCar:FlxSprite;
public var estatica:FlxSprite;

public var ycbuWhite:FlxSprite;
public var lakitu:FlxSprite;
public var gyromite:FlxSprite;

function postCreate() {
    for (i in cpuStrums.characters)
        dadChars[i.curCharacter] = i;

    dadSingFocus = [dadChars["mrSYS"], dadChars["mrSYSwb"], dadChars["hunter"], dadChars["koopa"]];

    for (i in [beatText = new FlxText(-230, 150, 1818, '', 24), beatText2 = new FlxText(-230, 150, 1818, '', 24)]) {
        i.setFormat(Paths.font("mariones.ttf"), 130, FlxColor.WHITE, FlxTextAlign.CENTER);
        i.scrollFactor.set();
        i.scale.set(1, 1.5);
        i.updateHitbox();
        i.screenCenter();
        insert(members.indexOf(stage("blackBarThingie")) + 1, i);
    }

    for (i in [ycbuLightningL = new FlxSprite(), ycbuLightningR = new FlxSprite()]) {
        i.frames = Paths.getSparrowAtlas('stages/nesbeat/ycbu_lightning');
        i.animation.addByPrefix('idle', "lightning", 15, true);
        i.animation.play('idle', true);
        i.screenCenter(FlxAxes.XY);
        i.antialiasing = true;
        i.alpha = 0.0001;
        i.cameras = [camEst];
        add(i);
    }
    ycbuLightningL.x -= 440;
    ycbuLightningR.x += 455;

    for (i in [ycbuHeadL = new FlxBackdrop(Paths.image('stages/nesbeat/YouCannotBeatUS_Fellas_Assets'), FlxAxes.Y, 0, 0), ycbuHeadR = new FlxBackdrop(Paths.image('stages/nesbeat/YouCannotBeatUS_Fellas_Assets'), FlxAxes.Y, 0, 0)]) {
        i.frames = Paths.getSparrowAtlas('stages/nesbeat/YouCannotBeatUS_Fellas_Assets');
        i.animation.addByPrefix('LOL', "Rotat e", 24, true);
        i.animation.addByPrefix('gyromite', "Bird Up", 24, false);
        i.animation.addByPrefix('lakitu', "Lakitu", 24, false);
        i.animation.play('LOL', true);
        i.updateHitbox();
        i.scale.set(0.6, 0.6);
        i.screenCenter(FlxAxes.X);
        i.flipX = true;
        i.antialiasing = true;
        i.alpha = 0.0001;
        i.cameras = [camEst];
        add(i);
    }
    ycbuHeadL.x -= 450;
    ycbuHeadL.velocity.set(0, 600);
    ycbuHeadR.x += 445;
    ycbuHeadR.velocity.set(0, -600);

    estatica = new FlxSprite();
    estatica.frames = Paths.getSparrowAtlas('Mario_static');
    estatica.animation.addByPrefix('idle', "static play", 15);
    estatica.animation.play('idle');
    estatica.antialiasing = false;
    estatica.cameras = [camEst];
    estatica.alpha = 0.05;
    estatica.updateHitbox();
    estatica.screenCenter();
    add(estatica);

    clownCar = new FlxSprite();
    clownCar.frames = Paths.getSparrowAtlas("stages/nesbeat/Clown_Car");
    clownCar.animation.addByPrefix('idle', 'clown car anim', 24, true);
    clownCar.animation.play('idle');
    clownCar.scale.set(55, 55);
    clownCar.antialiasing = false;
    clownCar.alpha = 0.0001;
    insert(members.indexOf(gf) - 1, clownCar);

    ycbuWhite = new FlxSprite().makeGraphic(FlxG.width / 0.9, FlxG.height / 0.9, FlxColor.WHITE);
    ycbuWhite.scrollFactor.set();
    ycbuWhite.screenCenter();
    ycbuWhite.alpha = 0;
    insert(members.indexOf(beatText) - 1, ycbuWhite);

    lakitu = new FlxSprite(0, 1000);
    lakitu.frames = Paths.getSparrowAtlas("stages/nesbeat/YouCannotBeatUS_Fellas_Assets");
    lakitu.scrollFactor.set(1.1, 1.1);
    lakitu.animation.addByPrefix('idle', "Lakitu", 24, false);
    lakitu.animation.play('idle', true);
    lakitu.antialiasing = true;
    lakitu.visible = false;
    insert(members.indexOf(beatText2) + 3, lakitu);
    
    gyromite = new FlxSprite(0, 1000);
    gyromite.frames = Paths.getSparrowAtlas("stages/nesbeat/YouCannotBeatUS_Fellas_Assets");
    gyromite.scrollFactor.set(1.1, 1.1);
    gyromite.animation.addByPrefix('idle', "Bird Up", 24, false);
    gyromite.animation.play('idle', true);
    gyromite.antialiasing = true;
    gyromite.visible = false;
    insert(members.indexOf(beatText2) + 4, gyromite);
}

function stepHit(c) {
    switch (c) {
        // INTRO
        case 16:
            FlxTween.tween(stage("blackinfrontobowser"), {alpha: 0.3}, 10, {ease: FlxEase.quadInOut});
        case 104:
            FlxTween.tween(camHUD, {alpha: 1}, 5, {ease: FlxEase.quadInOut});
        case 128:
            stage("blackinfrontobowser").alpha = 0;
        case 256, 544, 864, 928, 992, 1056:
            cZoomingInterval = 1;
            // 162342.925479429/(((60 / 143) * (1000/4))) step == 1547
        case 505, 842, 896, 960, 1024, 1090: // fix the 1090 one
            cZoomingInterval = 4;

        case 1344: // we are nintendo
            for (i in 0...4)
                FlxTween.tween(cpuStrums.members[i], {alpha: 0}, cFloat(8), {ease: FlxEase.quadInOut});
        case 1360: // you cannot beat us
            for (i in 0...4)
                FlxTween.tween(playerStrums.members[i], {x: playerStrums.members[i].x - 320}, cFloat(16), {ease: FlxEase.cubeInOut});
            for (i in [healthBar, healthOverlay, iconP1, iconP2, accuracyTxt, scoreTxt, missesTxt])
                FlxTween.tween(i, {alpha: 0}, 1);
            noMiss = true;
        case 1376:
            angel.data.stronk.value[0] = 0.325;
            showHeads();
            cZoomingInterval = 1;
        case 1392, 1408, 1424, 1440, 1574, 1606, 1638, 1670:
            angel.data.stronk.value[0] = 0.1;
            swapHeads();
            skipHeads();
        case 1504, 1508, 1512, 1514, 1536, 1540, 1544, 1546:
            angel.data.stronk.value[0] = 0.1;
            reverseHeads();
        case 1516, 1548:
            swapHeads();
        case 1568, 1600, 1632, 1664:
            cZoomingInterval = 4; // i give up
            angel.data.stronk.value[0] = 0.1;
            stopHeads();
            skipHeads();
        case 1580, 1612, 1644, 1676:
            angel.data.stronk.value[0] = 0.1;
            skipHeads();
        case 1584, 1616, 1648, 1680:
            startHeads();
        case 1696:
            angel.data.stronk.value[0] = 0.325;
            ycbuLightningL.alpha = ycbuLightningR.alpha = ycbuHeadL.alpha = ycbuHeadR.alpha = 0.001;
            for (i in [healthBar, healthOverlay, iconP1, iconP2, accuracyTxt, scoreTxt, missesTxt])
                i.alpha = 1;
            for (i in 0...4) {
                cpuStrums.members[i].alpha = 1;
                playerStrums.members[i].x += 320;
            }
            noMiss = false;

        case 1711: // aim your zapper guns
            for (i in [dad, iconP2])
                FlxTween.tween(i, {alpha: 0}, 2, {ease: FlxEase.quadInOut});
        case 1728: // you cannot beat us
            var tempY:Float = dad.y;

            setDad("hunter", true);

            FlxTween.tween(iconP2, {alpha: 1}, 1, {ease: FlxEase.quadInOut});
            if (health > 1) FlxTween.num(health, 1, 1, {ease: FlxEase.quadOut}, (val) -> {
                health = val;
                healthBar.updateHitbox();
            });

            FlxTween.tween(stage("duckbg"), {alpha: 1}, 1, {ease: FlxEase.quadOut});
            FlxTween.tween(stage("duckfloor"), {alpha: 1}, 2, {ease: FlxEase.quadOut});
            stage("duckleafs").alpha = stage("ducktree").alpha = 1;
            FlxTween.tween(stage("duckleafs"), {x: 800}, 1, {startDelay: 1, ease: FlxEase.quadOut});
            FlxTween.tween(stage("ducktree"), {x: 0}, 1, {startDelay: 1, ease: FlxEase.quadOut});

            dad.y += 800;
            dad.x -= 75;
            dad.alpha = 1;
            FlxTween.tween(dad, {y: (tempY)}, 1, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween) {
                FlxTween.tween(dad, {y: (tempY + 100)}, 1, {ease: FlxEase.quadInOut});
            }});
        case 2362, 2364, 3020:
            dad.playAnim("singUP", true);
        case 2880, 2884, 2888, 2890, 2892, 2894: // crosshair
            stage("ycbuCrosshair").visible = true;
            stage("ycbuCrosshair").color = (stage("ycbuCrosshair").color == FlxColor.WHITE) ? FlxColor.RED : FlxColor.WHITE;
            camHUD.visible = false;
        case 2896:
            for (i in 0...4) {
                cpuStrums.members[i].alpha = 0;
                playerStrums.members[i].x -= 320;
            }
            stage("ycbuCrosshair").visible = false;
            camHUD.visible = true;
        case 3023:
            setHeads("gyromite");
        case 3024:
            angel.data.stronk.value[0] = 0.325;
            showHeads();
        case 3032, 3036, 3048, 3052, 3064, 3068, 3080, 3084, 3096, 3100, 3112, 3116, 3128, 3132, 3144, 3148:
            reverseHeads();
        case 3152:
            angel.data.stronk.value[0] = 0.325;
            ycbuLightningL.alpha = ycbuLightningR.alpha = ycbuHeadL.alpha = ycbuHeadR.alpha = 0.001;
            for (i in [dad, iconP2])
                FlxTween.tween(i, {alpha: 0.0001}, 2, {ease: FlxEase.quadInOut});
            for (i in 0...4) {
                cpuStrums.members[i].alpha = 1;
                playerStrums.members[i].x += 320;
            }

        case 3154: // discover new worlds
            FlxTween.tween(stage("duckleafs"), {y: stage("duckleafs").y + 1200}, 1.5, {ease: FlxEase.quadIn});
            FlxTween.tween(stage("ducktree"), {y: stage("ducktree").y + 1200}, 1.5, {ease: FlxEase.quadIn});
            FlxTween.tween(stage("duckfloor"), {y: stage("duckfloor").y + 1200}, 1.5, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween) {
                stage("duckleafs").visible = stage("ducktree").visible = stage("duckfloor").visible = false; // unload lol
            }});
            FlxTween.color(stage("duckbg"), 2, stage("duckbg").color, 0xFF000000, {ease: FlxEase.cubeInOut});
        case 3162:
            new FlxTimer().start(cFloat(0.5), function(timer:FlxTimer) {
                stage("bowbg").alpha = stage("bowbg2").alpha = stage("bowlava").alpha = stage("bowplat").alpha = 1;
                FlxTween.tween(stage("bowbg2"), {y: stage("bowbg2").y + 200}, 0.5, {ease: FlxEase.quadOut});
                if (health > 1) FlxTween.num(health, 1, 1, {ease: FlxEase.quadOut}, (val) -> {
                    health = val;
                    healthBar.updateHitbox();
                });
            }, 1);
        case 3165:
            new FlxTimer().start(cFloat(0.5), function(timer:FlxTimer) {
                FlxTween.tween(stage("bowbg"), {y: stage("bowbg").y - 1000}, 0.5, {ease: FlxEase.quadOut});
            });
        case 3168:
            new FlxTimer().start(cFloat(0.5), function(timer:FlxTimer) {
                FlxTween.tween(stage("bowplat"), {x: 800}, 0.5, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween) {
                    FlxTween.tween(stage("bowplat"), {x: 600}, 1.5, {type: FlxTween.PINGPONG, loopDelay: 0.5});
                }});
            });
        case 3184: // you cannot beat us

            dad.alpha = 1;
            setDad("koopa", true);
            var tempY:Float = dad.y;
            dad.y += 800;
            dad.x = dadChars["mrSYS"].x;
            
            FlxTween.tween(stage("bowlava"), {y: 550}, 1.5, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween) {
                FlxTween.tween(stage("bowlava"), {y: 775}, 1.25, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween) {
                    FlxTween.tween(stage("bowlava"), {y: 750}, 0.5, {ease: FlxEase.quadInOut});
                }});
            }});
            FlxTween.tween(iconP2, {alpha: 1}, 1.5, {ease: FlxEase.expoOut});
            FlxTween.tween(dad, {y: (tempY - 100)}, 1, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween) {
                FlxTween.tween(dad, {y: (tempY)}, 1, {ease: FlxEase.quadInOut});
            }});
        case 3216:
            stage("screencolor").alpha = 0.7;
            FlxTween.tween(stage("screencolor"), {alpha: 0}, (1 / (Conductor.bpm / 60)));
        case 3344: // firebar
            fireBar.visible = true;
            fireBar.angle = 180;
            fireBar.y = 750;
            FlxTween.tween(fireBar, {y: 450}, (2 / (Conductor.bpm / 60)), {ease: FlxEase.expoOut});
        case 3856: // bye firebar
            FlxTween.tween(fireBar, {y: 750}, (2 / (Conductor.bpm / 60)), {ease: FlxEase.backIn});
            new FlxTimer().start((2 / (Conductor.bpm / 60)), function(tmr:FlxTimer) {
                fireBar.visible = false;
            });
        case 3991: // moved it back a curstep just in case
            setHeads("lakitu");
        case 3992:
            angel.data.stronk.value[0] = 0.325;
            showHeads();
        case 3968:
            for (i in 0...4)
                FlxTween.tween(cpuStrums.members[i], {alpha: 0}, cFloat(16), {ease: FlxEase.quadInOut});
        case 3976:
            for (i in 0...4)
                FlxTween.tween(playerStrums.members[i], {x: playerStrums.members[i].x - 320}, cFloat(16), {ease: FlxEase.cubeInOut});
        case 4120:
            angel.data.stronk.value[0] = 0.325;
            ycbuLightningL.alpha = ycbuLightningR.alpha = ycbuHeadL.alpha = ycbuHeadR.alpha = 0.001;
        case 4246: // not needed but ima keep just in case
            setHeads("lakitu");
        case 4247: // note to self check why this number feels weird
            angel.data.stronk.value[0] = 0.325;
            showHeads();
        case 4256, 4260, 4272, 4276, 4288, 4292, 4304, 4308, 4376, 4394, 4408:
            reverseHeads();
        case 4312:
            FlxTween.tween(stage("blackinfrontobowser"), {alpha: 0.7}, 5, {ease: FlxEase.quadInOut});
            stopHeads();
            startHeads();
        case 4424: // clown car
            angel.data.stronk.value[0] = 0.325;
            ycbuLightningL.alpha = ycbuLightningR.alpha = ycbuHeadL.alpha = ycbuHeadR.alpha = 0.001;

            clownCar.alpha = 1;
            clownCar.screenCenter();
            clownCar.y += 175;
            clownCar.color = FlxColor.BLACK;

            setDad("mrSYS", true);

            for (i in [
                stage("duckleafs"), stage("ducktree"), stage("duckfloor"), stage("duckbg"),
                stage("bowbg"), stage("bowbg2"), stage("bowplat"), stage("bowlava")
            ]) i.visible = false;

            new FlxTimer().start(0.25, function(tmr:FlxTimer) {
                FlxTween.color(clownCar, 0.4, FlxColor.BLACK, FlxColor.WHITE);
                FlxTween.tween(clownCar, {y: -1100}, 2, {ease: FlxEase.quintIn});
                FlxTween.tween(clownCar.scale, {x: 4, y: 4}, 2, {ease: FlxEase.cubeOut});
            });
        case 4704:
            ycbuWhite.color = FlxColor.BLACK;
            FlxTween.tween(camHUD, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
            FlxTween.tween(camGame, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut}); // replace this with fade later
            FlxTween.tween(ycbuWhite, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut});

        case 4736: // lakitu chant
            camGame.alpha = 1;
            remove(lakitu);
            insert(members.indexOf(dadChars["hunter"]) + 1, lakitu); // TODO: do the math for this earlier
            camMovement = false;
            lakitu.setPosition(-600, FlxG.height);
            lakitu.visible = true;
            FlxTween.tween(lakitu, {x: -50}, 1, {ease: FlxEase.quadOut});
            FlxTween.tween(lakitu, {y: 400}, 1, {ease: FlxEase.quadIn});
            FlxTween.tween(camGame, {zoom: 1.4}, 5.9, {ease: FlxEase.quintIn});
        case 4752: // bowser chant (TODO: FIX POSITIONING)
            setDad("koopa", true);
            // dad = dadChars["koopa"];
            dad.setPosition(865, FlxG.height);
            dad.visible = true;
            FlxTween.tween(dad, {y: -54}, 1.5, {ease: FlxEase.backOut});
        case 4768: // gyromite chant
            remove(gyromite);
            insert(members.indexOf(dadChars["koopa"]) + 1, gyromite); // TODO: do the math for this earlier
            gyromite.setPosition(1300, FlxG.height);
            gyromite.visible = true;
            FlxTween.tween(gyromite, {x: 850}, 1, {ease: FlxEase.quadOut});
            FlxTween.tween(gyromite, {y: 400}, 1, {ease: FlxEase.quadIn});
        case 4784: // hunter chant
            var tempX = dadChars["mrSYS"].x; // TODO: do the math for this with traces
            var tempY = dadChars["mrSYS"].y;
            setDad("hunter", false);
            // dad = dadChars["hunter"];
            dad.setPosition(tempX - 470, FlxG.height);
            dad.visible = true;
            // dad.alpha = 1;
            FlxTween.tween(dad, {y: tempY - 180}, 1.5, {ease: FlxEase.backOut});
            dadSingFocus = [dadChars["hunter"]];
        case 4800:
            ycbuWhite.color = FlxColor.WHITE;
            lakitu.visible = gyromite.visible = dadChars["hunter"].visible = dadChars["koopa"].visible = false;
            defaultCamZoom = 0.9;
            camMovement = true;
        case 4812: // fade in sys wb
            dadSingFocus = [dadChars["mrSYS"], dadChars["mrSYSwb"], dadChars["hunter"], dadChars["koopa"]];
            setDad("mrSYSwb", true);
            dad.setPosition(dadChars["mrSYS"].x, dadChars["mrSYS"].y);
            dad.alpha = 0.0001;
            FlxTween.tween(dad, {alpha: 1}, 0.75, {ease: FlxEase.cubeOut});
        case 4816: // sys is back
            setDad("mrSYS", true);
            dad.alpha = 1;

            FlxTween.tween(stage("blackinfrontobowser"), {alpha: 0}, 0.7, {ease: FlxEase.quadInOut});
            FlxTween.tween(ycbuWhite, {alpha: 0}, 0.25, {ease: FlxEase.quadOut});
            FlxTween.tween(camHUD, {alpha: 1}, 0.25, {ease: FlxEase.quadOut});
            
            angel.data.stronk.value[0] = 0.325;
            if (health > 1)
                health = 1;

        case 4943:
            setHeads("you cannot beat us lololol");
        case 4944:
            angel.data.stronk.value[0] = 0.325;
            showHeads();
        case 5072:
            angel.data.stronk.value[0] = 0.325;
            ycbuLightningL.alpha = ycbuLightningR.alpha = ycbuHeadL.alpha = ycbuHeadR.alpha = 0.001;

            setDad("hunter", true);
            setIcon(["hunter", "mrSYS"]);
            dad.setPosition(345, 200);

            iconHunter.alpha = 0;
            FlxTween.tween(iconHunter, {alpha: 1}, 0.2, {ease: FlxEase.quadOut});
            
            angel.data.stronk.value[0] = 0.325;

            estatica.alpha = 0.6;
            FlxTween.tween(estatica, {alpha: 0.05}, 0.5, {ease: FlxEase.quadInOut});

            FlxTween.num(health, health - 0.5, 0.1, {ease: FlxEase.quadOut}, (val) -> {
                health = val;
                healthBar.updateHitbox();
            });

            cutbg.visible = cutstatic.visible = true;
            cutbg.animation.play('duck');
            cutskyline.visible = false;
        case 5199:
            setHeads("gyromite");
        case 5200:
            angel.data.stronk.value[0] = 0.325;
            showHeads();
        case 5328:
            angel.data.stronk.value[0] = 0.325;
            ycbuLightningL.alpha = ycbuLightningR.alpha = ycbuHeadL.alpha = ycbuHeadR.alpha = 0.001;

            setDad("koopa", true);
            setIcon(["koopa", "hunter", "mrSYS"]);
            dad.setPosition(345, 100); // TODO: the right thing

            iconBowser.alpha = 0;
            FlxTween.tween(iconBowser, {alpha: 1}, 0.2, {ease: FlxEase.quadOut});

            FlxTween.num(health, health - 0.5, 0.1, {ease: FlxEase.quadOut}, (val) -> {
                health = val;
                healthBar.updateHitbox();
            });

            cutskyline.animation.play('bowser');
            cutskyline.visible = true;
            
            estatica.alpha = 0.6;
            FlxTween.tween(estatica, {alpha: 0.05}, 0.5, {ease: FlxEase.quadInOut});
        case 5455:
            setHeads("lakitu");
        case 5456:
            angel.data.stronk.value[0] = 0.325;
            showHeads();
        case 5584:
            angel.data.stronk.value[0] = 0.325;
            ycbuLightningL.alpha = ycbuLightningR.alpha = ycbuHeadL.alpha = ycbuHeadR.alpha = 0.001;
            /* triggers universal 18 "0, 0"
                var split:Array<String> = value2.split(',');
                dupeTimer = Std.parseInt(split[1]);
                shit = Std.parseFloat(split[0]);
            */
            ycbuWhite.alpha = 1;
            FlxTween.tween(ycbuWhite, {alpha: 0}, 0.25, {ease: FlxEase.quadOut});

            stage("blackinfrontobowser").alpha = 0.85;
            cutbg.visible = cutskyline.visible = cutstatic.visible = false;
        case 5840:
            /* triggers universal 18 "0.03, 1"
                var split:Array<String> = value2.split(',');
                dupeTimer = Std.parseInt(split[1]);
                shit = Std.parseFloat(split[0]);
            */
            var tempX = dad.x;
            var tempY = dad.y;
            setDad("mrSYS", true);
            setIcon(["mrSYS", "hunter", "koopa"]);
            // dad.alpha = 0;
            // dad.visible = false;
            // dad = dadChars["mrSYS"];
            // healthBar.createFilledBar(dad.iconColor, 0xFF31b0d1);
        	// healthBar.updateBar();
            dad.setPosition(tempX, tempY); // TODO: the right thing
            // dad.visible = true;
            // dad.alpha = 1;
            
            estatica.alpha = 0.6;
            FlxTween.tween(estatica, {alpha: 0.05}, 0.5, {ease: FlxEase.quadInOut});

            for (i in [
                stage("duckleafs"), stage("ducktree"), stage("duckfloor"), stage("duckbg"),
                stage("bowbg"), stage("bowbg2"), stage("bowplat"), stage("bowlava")
            ]) i.visible = false;

            cutbg.visible = cutstatic.visible = cutskyline.visible = false;
            stage("blackinfrontobowser").alpha = 0;
            
            ycbuWhite.alpha = gyromite.alpha = lakitu.alpha = 1;
            FlxTween.tween(ycbuWhite, {alpha: 0}, 0.25, {ease: FlxEase.quadOut});
            
            lakitu.x = 0;
            gyromite.x = 800;
            gyromite.y = lakitu.y = 400;
            remove(gyromite);
            insert(members.indexOf(beatText) + 1, gyromite);

            var newhealth:Float = health - 1;
            if (newhealth < 0.2) newhealth = 0.2;
            FlxTween.num(health, newhealth, 0.1, {ease: FlxEase.quadOut}, (val) -> {
                health = val;
                healthBar.updateHitbox();
            });
        case 5904: // add hunter
            setDad("hunter", true);
            setIcon(["hunter", "koopa", "mrSYS"]);

            // iconOrder.push(iconOrder.shift());

            // dad.alpha = 0;
            // dad.visible = false;
            // var tempX = dad.x;
            // var tempY = dad.y;
            // dad = dadChars["hunter"];
            // healthBar.createFilledBar(dad.iconColor, 0xFF31b0d1);
        	// healthBar.updateBar();
            dad.setPosition(345, 200);
            // dad.visible = true;
            // dad.alpha = 1;
            
            FlxTween.num(health, health - 0.5, 0.1, {ease: FlxEase.quadOut}, (val) -> {
                health = val;
                healthBar.updateHitbox();
            });

            angel.data.stronk.value[0] = 0.325;

            estatica.alpha = 0.6;
            FlxTween.tween(estatica, {alpha: 0.05}, 0.5, {ease: FlxEase.quadInOut});

            cutbg.visible = cutstatic.visible = true;
            cutskyline.visible = false;
            cutbg.animation.play('duck');
        case 5968: // add sys
            setDad("mrSYS", false);
            setIcon(["mrSYS", "hunter", "koopa"]);
            // iconOrder.push(iconOrder.shift());
            // iconOrder.push(iconOrder.shift()); // move to sys, not bowser

            // dad = dadChars["mrSYS"];
            // healthBar.createFilledBar(dad.iconColor, 0xFF31b0d1);
        	// healthBar.updateBar();
            dad.setPosition(400, 100);
            // dad.visible = true;
            // dad.alpha = 1;

            dad.y += 1000;
			FlxTween.tween(dad, {y: dad.y - 1000}, 1.25, {ease: FlxEase.backOut});

            remove(dadChars["hunter"]);
            insert(members.indexOf(dadChars["mrSYS"]) - 1, dadChars["hunter"]);
            
            var newhealth:Float = health - 1;
            if (newhealth < 0.2) newhealth = 0.2;
            FlxTween.num(health, newhealth, 0.1, {ease: FlxEase.quadOut}, (val) -> {
                health = val;
                healthBar.updateHitbox();
            });
            
            FlxTween.tween(dadChars["hunter"], {x: dadChars["hunter"].x - 425, y: dadChars["hunter"].y + 50}, 0.75, {ease: FlxEase.cubeOut});
            // dad = dadChars["mrSYS"];
        case 6032: // add bowser
            angel.data.stronk.value[0] = 0.325;
            setDad("mrSYSwb", false);
            dadChars["mrSYS"].visible = false;
            setIcon(["koopa", "mrSYS", "hunter"]);

            // bowserMainSinging = false;
            dadSingFocus = [dadChars["mrSYS"], dadChars["mrSYSwb"], dadChars["hunter"]];
            
            // healthBar.createFilledBar(FlxColor.fromRGB(10, 255, 137),
                // FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
            
            healthBar.createFilledBar(FlxColor.fromRGB(10, 255, 137), 0xFF31b0d1);
            healthBar.updateBar();

            var newhealth:Float = health - 1;
            if (newhealth < 0.2) newhealth = 0.2;
            FlxTween.num(health, newhealth, 0.1, {ease: FlxEase.quadOut}, (val) -> {
                health = val;
                healthBar.updateHitbox();
            });

            cutskyline.visible = true;

            remove(dadChars["koopa"]);
            insert(members.indexOf(dad) - 1, dadChars["koopa"]);
            dadChars["koopa"].setPosition(1515, 846);
            dadChars["koopa"].visible = true;
            FlxTween.tween(dadChars["koopa"], {x: dadChars["koopa"].x - 700, y: dadChars["koopa"].y - 700}, 1.25, {ease: FlxEase.backOut});
        
            // angel.data.stronk.value[0] = 0.1;
        case 6096:
            setDad("mrSYS", true);
            setIcon(["mrSYS", "hunter", "koopa"]);

            estatica.alpha = 0.6;
            FlxTween.tween(estatica, {alpha: 0.05}, 0.5, {ease: FlxEase.quadInOut});

            // bowserMainSinging = true;
            dadSingFocus = [dadChars["mrSYS"], dadChars["mrSYSwb"], dadChars["hunter"], dadChars["koopa"]];

            stage("blackinfrontobowser").alpha = 0;
            ycbuWhite.alpha = gyromite.alpha = lakitu.alpha = 1;
            cutbg.visible = cutskyline.visible = cutstatic.visible = dadChars["koopa"].visible = dadChars["hunter"].visible = false;
            lakitu.x = 0;
            gyromite.x = 800;
            gyromite.y = lakitu.y = 400;
            remove(gyromite);
            insert(members.indexOf(beatText) + 1, gyromite);

            FlxTween.tween(ycbuWhite, {alpha: 0}, 0.25, {ease: FlxEase.quadOut});
        case 6112:
            setDad("hunter", true);
            setIcon(["hunter", "mrSYS", "koopa"]);
            dad.setPosition(345, 200);

            ycbuWhite.alpha = 1;
            ycbuWhite.visible = true;

            var tempY = dad.y;
            dad.y += 950;
            FlxTween.tween(dad, {y: tempY}, 1.25, {ease: FlxEase.backOut});
        case 6128:
            setDad("mrSYS", true);
            setIcon(["mrSYS", "hunter", "koopa"]);
            
            var newhealth:Float = health - 0.5;
            if (newhealth < 0.2) newhealth = 0.2;
            FlxTween.num(health, newhealth, 0.1, {ease: FlxEase.quadOut}, (val) -> {
                health = val;
            });
            
            ycbuWhite.alpha = 0;
            // FlxTween.tween(ycbuWhite, {alpha: 0}, 0.25, {ease: FlxEase.quadOut});
        case 6144:
            var newhealth:Float = health - 0.5;
            if (newhealth < 0.2) newhealth = 0.2;
            FlxTween.num(health, newhealth, 0.1, {ease: FlxEase.quadOut}, (val) -> {
                health = val;
            });

            dad.alpha = 0;
            ycbuWhite.alpha = 1;
            gyromite.screenCenter(FlxAxes.X);
            gyromite.alpha = 1;
            gyromite.visible = true;
            gyromite.y = FlxG.height;
            FlxTween.tween(gyromite, {y: 200}, 1.25, {ease: FlxEase.backOut});
            // remove(ycbuGyromite);
            // insert(members.indexOf(otherBeatText) + 1, ycbuGyromite);
        case 6160:
            gyromite.setPosition(800, 400);
            dad.alpha = 1;
            ycbuWhite.alpha = gyromite.alpha = lakitu.alpha = 1;
            FlxTween.tween(ycbuWhite, {alpha: 0}, 0.25, {ease: FlxEase.quadOut});

            estatica.alpha = 0.6;
            FlxTween.tween(estatica, {alpha: 0.05}, 0.5, {ease: FlxEase.quadInOut});
        case 6176:
            var newhealth:Float = health - 0.5;
            if (newhealth < 0.2) newhealth = 0.2;
            FlxTween.num(health, newhealth, 0.1, {ease: FlxEase.quadOut}, (val) -> {
                health = val;
            });

            dad.alpha = gyromite.alpha = 0;
            ycbuWhite.alpha = 1;
            lakitu.screenCenter(FlxAxes.X);
            lakitu.visible = true;
            lakitu.y = FlxG.height;
            FlxTween.tween(lakitu, {y: 200}, 1.25, {ease: FlxEase.backOut});
            lakitu.alpha = 1;
        case 6192:
            lakitu.alpha = 0;
        case 6196:
            FlxTween.num(0, 1000000, 0.75, {ease: FlxEase.cubeOut}, function(v) {
                executeEvent({
                    name: "YCBU Text",
                    time: Conductor.songPosition,
                    params: ['score;' + Math.floor(v), true, false, false]
                });
            });
        case 6208:
            var newhealth:Float = health - 0.5;
            if (newhealth < 0.2) newhealth = 0.2;
            FlxTween.num(health, newhealth, 0.1, {ease: FlxEase.quadOut}, (val) -> {
                health = val;
            });

            setDad("koopa", true);
            setIcon(["koopa", "mrSYS", "hunter"]);
            dad.setPosition(345, 100);

            var tY = dad.y;
            dad.y += 1000;
            dad.alpha = 1;
            FlxTween.tween(dad, {y: tY}, 1.25, {ease: FlxEase.backOut});
        case 6223:
            // sysMainSinging = true;
            dadSingFocus = [dadChars["mrSYS"], dadChars["mrSYSwb"]];
        case 6224:
            estatica.alpha = 0.6;
            FlxTween.tween(estatica, {alpha: 0.05}, 0.5, {ease: FlxEase.quadInOut});
            // dad.alpha = 1;
            setDad("mrSYSwb", true);
            setIcon(["koopa", "mrSYS", "hunter"]);
            stage("blackinfrontobowser").alpha = 0;

            healthBar.createFilledBar(0xFFadddff, 0xFF31b0d1);
            healthBar.updateBar();

            ycbuWhite.alpha = gyromite.alpha = lakitu.alpha = 1;
            lakitu.x = 0;
            gyromite.x = 800;
            gyromite.y = lakitu.y = 400;
            ycbuWhite.color = FlxColor.BLACK;
            ycbuWhite.alpha = 1;

            remove(ycbuWhite);      insert(members.indexOf(beatText) - 1, ycbuWhite);
            remove(beatText);       insert(members.indexOf(ycbuWhite) + 1, beatText);
            remove(gyromite);       insert(members.indexOf(beatText) + 1, gyromite);
            remove(dadChars["hunter"]);     insert(members.indexOf(lakitu) + 1, dadChars["hunter"]);
            remove(dadChars["koopa"]);      insert(members.indexOf(lakitu) + 1, dadChars["koopa"]);
            remove(dad);            insert(members.indexOf(dadChars["hunter"]) + 1, dad);
            remove(lakitu);         insert(members.indexOf(gyromite) + 1, lakitu);
            
            gyromite.y = lakitu.y -= 350;
            dadChars["hunter"].visible = dadChars["koopa"].visible = true;

            dadChars["hunter"].setPosition(-80, 250);
            dadChars["koopa"].setPosition(816, 146);

            dadChars["hunter"].animation.play("idle", true);
            dadChars["koopa"].animation.play("idle", true);
        case 6239:
            // sysMainSinging = false;
            dadSingFocus = [dadChars["mrSYS"], dadChars["mrSYSwb"], dadChars["hunter"], dadChars["koopa"]];
        case 6256:
            gyromite.alpha = lakitu.alpha = dadChars["hunter"].alpha = dadChars["koopa"].alpha = 0;

    }
}

/*
modManager.queueSet(4736, "opponentSwap", 0);
modManager.queueSet(4736, "alpha", 0);

modManager.queueSet(4815, "opponentSwap", 0.5);
modManager.queueSet(4815, "alpha", 1, 1);

var bumpSteps = [5776, 5792, 5808, 5816, 5824, 5832, 5834, 5836, 5838];
modManager.queueEase(5582, 5586, "opponentSwap", 0.5, 'bounceOut');
modManager.queueEase(5582, 5586, "alpha", 1, 'bounceOut', 1);
// modManager.queueSet(5586, "transformY", 400, 1);
for(step in bumpSteps){
    modManager.queueSet(step, "transformZ", 0.125);
    modManager.queueEase(step, step+8, "transformZ", 0, 'quadOut');
}

modManager.queueEase(5712, 5840, "tipsy", 1, 'quadInOut');
modManager.queueEase(5712, 5840, "flip", -1, 'quadInOut', 1);
// modManager.queueEase(5712, 5840, "transformY", 0, 'quadInOut', 1);
modManager.queueEase(5712, 5840, "transform1X", (-342) + 112, 'quadInOut', 1);
modManager.queueEase(5712, 5840, "transform2X", 342 - 112, 'quadInOut', 1);
modManager.queueEase(5712, 5840, "alpha", 0.5, 'quadInOut', 1);
modManager.queueEase(5712, 5840, "sudden", 2, 'quadInOut', 1);
modManager.queueEase(5712, 5840, "stealth", 0.5, 'quadInOut', 1);

modManager.queueEase(5840, 5844, "tipsy", 0.25, 'quadInOut');
modManager.queueEase(5840, 5844, "beat", 0.5, 'quadInOut');
var strum = 0;
numericForInterval(5840, 6096, 4, function(step){
    if(step >= 5961) strum = 1;
    modManager.queueSet(step, "flip", -0.125, strum);
        modManager.queueEase(step, step+4, "flip", 0, 'quartOut', strum);
});

modManager.queueEase(5964, 5968, "transform1X", 0, 'bounceOut', 1);
modManager.queueEase(5964, 5968, "transform2X", 0, 'bounceOut', 1);
modManager.queueEase(5964, 5968, "transform1X", (-342) + 112, 'bounceOut', 0);
modManager.queueEase(5964, 5968, "transform2X", 342 - 112, 'bounceOut', 0);
modManager.queueEase(5964, 5968, "flip", -1, 'bounceOut', 0);
modManager.queueEase(5964, 5968, "flip", 0, 'bounceOut', 1);

modManager.queueEase(6096, 6104, "alpha", 1, 'quadOut', 0);
modManager.queueEase(6096, 6104, "alpha", 0, 'quadOut', 1);
modManager.queueEase(6096, 6104, "stealth", 0, 'quadOut', 1);
modManager.queueEase(6096, 6104, "sudden", 0, 'quadOut', 1);
modManager.queueEase(6096, 6104, "beat", 0, 'quadOut');

modManager.queueEase(6224, 6228, "alpha", 1, 'quadOut', 1);

modManager.queueSet(6228, "mini", -.625, 0);
modManager.queueSet(6228, "tipsy", 0);
modManager.queueSet(6228, "alpha", 0, 0);
for(i in 0...4){
    modManager.queueSet(6228, "alpha" + i, 1, 0);
}
modManager.queueSet(6228, "transform1X", 0, 0);
modManager.queueSet(6228, "transform2X", 0, 0);
modManager.queueSet(6228, "flip", 0, 0);
modManager.queueSet(6228, "centered", 1, 0);
modManager.queueSet(6228, "split", 1, 0);
modManager.queueEase(6248, 6254, "alpha0", 0, 'quadOut');
modManager.queueEase(6248, 6254, "alpha2", 0, 'quadOut');

modManager.queueEase(6272, 6280, "alpha0", 1, 'quadOut');
modManager.queueEase(6272, 6280, "alpha2", 1, 'quadOut');
*/

var timer:FlxTimer = null;
function onEvent(_) {
    switch (_.event.name) {
        case "Camera Movement":
            dad.visible = _.event.params[0] == 0;
            boyfriend.visible = gf.visible = _.event.params[0] == 1;
            stage("blackBarThingie").alpha = _.event.params[0] == 1 ? 0.3 : 0;
            estatica.alpha = 0.6;
            FlxTween.tween(estatica, {alpha: 0.05}, 0.5, {ease: FlxEase.quadInOut});
        case "YCBU Text":
            beatText.color = 0xFFF87858;
            beatText.text = StringTools.replace(_.event.params[0], ";", "\n");
            beatText2.text = "";
            beatText.updateHitbox();
            beatText.screenCenter();

            for (i in [ycbuHeadL, ycbuHeadR])
                if (i.animation.name != "LOL") i.animation.play(i.animation.name, true);

            if (_.event.params[2]) gyromite.animation.play(gyromite.animation.name, true);
            if (_.event.params[3]) lakitu.animation.play(lakitu.animation.name, true);
    
            var isBlack = _.event.params[1];
    
            timer?.cancel();
            timer = new FlxTimer().start(0.1, function(tmr:FlxTimer) {
                beatText.color = isBlack ? 0xFF000000 : 0xFFFFFFFF;
            });

        case "Hunter Duck":
            var elpato:Int = FlxG.random.int(0, 2);
            var track:Int = FlxG.random.int(0, 4);
            var timeDuck:Float = 1;

            var duck:FlxSprite = new FlxSprite(250, 650).loadGraphic(Paths.image("stages/nesbeat/duck" + elpato));
            duck.frames = Paths.getSparrowAtlas("stages/nesbeat/duck" + elpato);
            duck.animation.addByPrefix('upB', "duck up", 12, true);
            duck.animation.addByPrefix('idleB', "duck fly", 12, true);
            duck.scrollFactor.set(0.7, 0.7);
            duck.scale.set(6.5, 6.5);
            duck.updateHitbox();
            duck.antialiasing = false;
            duck.animation.play('upB');
            insert(members.indexOf(stage("duckfloor")) - 1, duck);

            switch (track) {
                case 0:
                    timeDuck = 3;
                    duck.y = -200;
                    duck.x = 1500;
                    duck.animation.play('idleB');
                    duck.flipX = true;
                    FlxTween.tween(duck, {x: -400, y: 300}, timeDuck);
                case 1:
                    timeDuck = 3.5;
                    duck.y = 800;
                    duck.x = 100;
                    FlxTween.tween(duck, {x: 600, y: -500}, timeDuck);
                case 2:
                    timeDuck = 3;
                    duck.animation.play('idleB');
                    duck.y = 0;
                    duck.x = -300;
                    FlxTween.tween(duck, {x: 1600, y: 300}, timeDuck);
                case 3:
                    timeDuck = 3;
                    duck.y = 200;
                    duck.x = 1500;
                    duck.flipX = true;
                    FlxTween.tween(duck, {x: 200, y: -300}, timeDuck);
                case 4:
                    timeDuck = 3;
                    duck.y = 0;
                    duck.x = 100;
                    FlxTween.tween(duck, {x: 1600, y: -500}, timeDuck);
            }

            new FlxTimer().start(timeDuck, function(tmr:FlxTimer) {
                duck.destroy();
            });
        case "Bowser Podoboo":
            var podoboo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('stages/nesbeat/fire'));
            podoboo.scale.set(6, 6);
            podoboo.updateHitbox();
            podoboo.antialiasing = false;
            podoboo.angle = 0;
            insert(members.indexOf(stage("bowlava")) - 1, podoboo);

            var onlyLeft = _.event.params[0];
            var onlyRight = _.event.params[1];

            if (!onlyLeft && !onlyRight) {
                podoboo.setPosition(FlxG.random.int(125, 275), 900);
                stage("duckbg").color = FlxColor.RED;
                FlxTween.color(stage("duckbg"), 0.25, stage("duckbg").color, FlxColor.BLACK, {ease: FlxEase.quadOut});

                executeEvent({
                    name: "Bowser Podoboo",
                    time: Conductor.songPosition,
                    params: [false, true]
                });
            } else if (onlyLeft) {
                podoboo.setPosition(FlxG.random.int(25, 350), 900);
            } else if (onlyRight) {
                podoboo.setPosition(FlxG.random.int(775, 1100), 900);
            }

            FlxTween.tween(podoboo, {angle: FlxG.random.bool(50) ? 180 : -180}, (0.5 / (Conductor.bpm / 60)), {startDelay: (0.75 / (Conductor.bpm / 60)), ease: FlxEase.quadInOut});
            FlxTween.tween(podoboo, {y: 300}, (1 / (Conductor.bpm / 60)), {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                FlxTween.tween(podoboo, {y: 900}, (1 / (Conductor.bpm / 60)), {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween){
                    podoboo.kill();
                }});
            }});
        case "Bowser Bullet":
            var bullet:FlxSprite = new FlxSprite().loadGraphic(Paths.image('stages/nesbeat/bullet'));
            bullet.scale.set(7, 7);
            bullet.cameras = [camHUD];
            bullet.y = FlxG.random.int(40, 680);
            bullet.antialiasing = false;
            add(bullet);

            var bulletX:Int;
            if (_.event.params[0]) { // "From Left?"
                bullet.x = -60;
                bullet.flipX = true;
                bulletX = 1320;
            } else {
                bullet.x = 1320;
                bulletX = -60;
            }

            FlxTween.tween(bullet, {x: bulletX}, 1.5, {onComplete: function(twn:FlxTween){
                bullet.kill();
            }});
    }
}

function onNoteHit(e:NoteHitEvent) {
    if (e.note.strumLine == cpuStrums)
        e.characters = dadSingFocus;
        // if (sysMainSinging)
        //     e.characters = [dadChars["mrSYS"], dadChars["mrSYSwb"]];
        // else if (bowserMainSinging)
        //     e.characters = [dadChars["mrSYS"], dadChars["mrSYSwb"], dadChars["hunter"], dadChars["koopa"]];
        // else
        //     e.characters = [dadChars["mrSYS"], dadChars["mrSYSwb"], dadChars["hunter"]];

    switch (e.note.noteType) {
        case "Alt Animation":
            e.animSuffix = '-alt';
        case "No Animation":
            e.preventAnim();
        case "Hey!":
            e.preventAnim();
            boyfriend.playAnim("hey", true);
            gf.playAnim("hey", true);
        case "Yoshi Note": // used for bowser at end chant
            //e.cancel();
            e.preventAnim();
            dadChars["koopa"].animation.play(["singLEFT", "singDOWN", "singUP", "singRIGHT"][e.direction], true);
    }
}

function postUpdate() {
    camFollow.setPosition(620, 450);
    if (camMovement)
        switch (strumLines.members[curCameraTarget].characters[0].getAnimName()) {
            case "singLEFT", "singLEFT-alt": camFollow.x -= 20;
            case "singDOWN", "singDOWN-alt": camFollow.y += 20;
            case "singUP", "singUP-alt": camFollow.y -= 20;
            case "singRIGHT", "singRIGHT-alt": camFollow.x += 20;
        }
}

function cFloat(s:Float) {
    return (Conductor.stepCrochet * s) / 1000;
}

function stage(spr:String) {
    return PlayState.instance.stage.getSprite(spr);
}

function showHeads() {
    ycbuHeadL.velocity.y = 600;
    ycbuHeadR.velocity.y = -600;
    ycbuLightningL.screenCenter(FlxAxes.X);
    ycbuLightningR.screenCenter(FlxAxes.X);
    ycbuLightningL.x -= 440;
    ycbuLightningR.x += 455;
    ycbuLightningL.alpha = ycbuLightningR.alpha = ycbuHeadL.alpha = ycbuHeadR.alpha = 1;
}

function swapHeads() {
    var tempX = ycbuHeadL.x;
    FlxTween.tween(ycbuHeadL, {x: ycbuHeadR.x}, 0.2, {ease: FlxEase.quadOut});
    FlxTween.tween(ycbuHeadR, {x: tempX}, 0.2, {ease: FlxEase.quadOut});

    tempX = ycbuLightningL.x;
    FlxTween.tween(ycbuLightningL, {x: ycbuLightningR.x}, 0.2, {ease: FlxEase.quadOut});
    FlxTween.tween(ycbuLightningR, {x: tempX}, 0.2, {ease: FlxEase.quadOut});
}

function skipHeads() {
    FlxTween.tween(ycbuHeadL, {y: ycbuHeadL.y + (250 * (ycbuHeadL.velocity.y / Math.abs(ycbuHeadL.velocity.y)))}, 0.25, {ease: FlxEase.quadOut});
    FlxTween.tween(ycbuHeadR, {y: ycbuHeadR.y + (250 * (ycbuHeadR.velocity.y / Math.abs(ycbuHeadR.velocity.y)))}, 0.25, {ease: FlxEase.quadOut});
}

function reverseHeads() {
    FlxTween.tween(ycbuHeadL, {y: ycbuHeadL.y + (ycbuHeadL.velocity.y)}, 0.1, {ease: FlxEase.quadOut});
    FlxTween.tween(ycbuHeadR, {y: ycbuHeadR.y + (ycbuHeadR.velocity.y)}, 0.1, {ease: FlxEase.quadOut});
    FlxTween.tween(ycbuHeadL.velocity, {y: ycbuHeadL.velocity.y * -1}, 0.1, {ease: FlxEase.quadOut});
    FlxTween.tween(ycbuHeadR.velocity, {y: ycbuHeadR.velocity.y * -1}, 0.1, {ease: FlxEase.quadOut});
}

function stopHeads() {
    ycbuHeadL.velocity.y /= Math.abs(ycbuHeadL.velocity.y);
    ycbuHeadR.velocity.y /= Math.abs(ycbuHeadR.velocity.y);
}

function startHeads() {
    ycbuHeadL.velocity.y *= 420;
    ycbuHeadR.velocity.y *= 420;
}

function setHeads(type:String) {
    switch (type) {
        case "gyromite":
            ycbuHeadL.animation.play('gyromite', true);
            ycbuHeadR.animation.play('gyromite', true);
            ycbuHeadL.spacing.y = 150;
            ycbuHeadR.spacing.y = 150;
            ycbuHeadL.flipX = false;
            ycbuHeadR.flipX = true;
            ycbuHeadL.x = -50;
            ycbuHeadR.x = 830;
        case "lakitu":
            ycbuHeadL.animation.play('lakitu', true);
            ycbuHeadR.animation.play('lakitu', true);
            ycbuHeadL.spacing.y = 150;
            ycbuHeadR.spacing.y = 150;
            ycbuHeadL.flipX = true;
            ycbuHeadR.flipX = false;
            ycbuHeadL.x = -50;
            ycbuHeadR.x = 840;
        default:
            ycbuHeadL.animation.play('LOL', true);
            ycbuHeadR.animation.play('LOL', true);
            ycbuHeadL.spacing.y = 0;
            ycbuHeadR.spacing.y = 0;
            ycbuHeadL.flipX = true;
            ycbuHeadR.flipX = false;
            ycbuHeadL.screenCenter(FlxAxes.X);
            ycbuHeadL.x -= 450;
            ycbuHeadR.screenCenter(FlxAxes.X);
            ycbuHeadR.x += 445;
    }
}

function setDad(c:String, hidePrev:Bool = true) {
    if (hidePrev)
        dad.visible = false;
    dad = dadChars[c];
    healthBar.createFilledBar(dad.iconColor, 0xFF31b0d1);
    healthBar.updateBar();
    dad.visible = true;
    setIcon([c]);
}

function setIcon(people:Array<String>) {
    for (name => icon in ["mrSYS" => iconSys, "hunter" => iconHunter, "koopa" => iconBowser])
        icon.visible = people.contains(name);

    if (people[0] == "mrSYS") iconOrder = [iconSys, iconHunter, iconBowser];
    if (people[0] == "hunter") iconOrder = [iconHunter, iconBowser, iconSys];
    if (people[0] == "koopa") iconOrder = [iconBowser, iconSys, iconHunter];
}