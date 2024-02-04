static var icoP1:HealthIcon;
static var icoP2:HealthIcon;

static var flipIcoBop:Bool = false; // use this for when bf is on the other side!! (like for day out for example)

function postCreate() {
    icoP1 = new HealthIcon(boyfriend != null ? boyfriend.getIcon() : "face", true);
    icoP2 = new HealthIcon(dad != null ? dad.getIcon() : "face", false);
    for(ico in [icoP1, icoP2]) {
        ico.y = healthBar.y - (ico.height / 2);
        ico.cameras = [camHUD];
        insert(members.indexOf(healthBar) + 2, ico);
    }

    for (i in [iconP1, iconP2]) remove(i); // fuck you og icons
}

function update(elapsed:Float){
    icoP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 1, 0)) - 26);
	icoP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 1, 0))) - (icoP2.width - 26);

    icoP1.health = healthBar.percent / 100;
    icoP2.health = 1 - (healthBar.percent / 100);
}

function beatHit(){
    for (i in [icoP1, icoP2]){
        i.scale.set(1.1, 1.1);
        FlxTween.tween(i.scale, {x: 1, y: 1}, (0.5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.cubeOut});
    }
    if (!flipIcoBop) icoP2.origin.set(175, 77.5);
    else icoP1.origin.set(-20, 77.5);
}