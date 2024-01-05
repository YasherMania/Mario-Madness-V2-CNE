import funkin.backend.assets.ModsFolder;
import sys.io.FileSystem;
import openfl.display.BitmapData;
import flixel.graphics.FlxGraphic;

var dataShit:Array<{name:String, xml:String}> = [];

function preload(imagePath:String) {
    var graphic = FlxG.bitmap.add(Paths.image(imagePath));
    graphic.useCount++;
    graphic.destroyOnNoUse = false;
    graphicCache.cachedGraphics.push(graphic);
    graphicCache.nonRenderedCachedGraphics.push(graphic);
}

function postCreate() {
    for (event in events)
        if (event.name == 'Change Character') {
            var data = {
                name: Assets.exists(Paths.xml('characters/' + event.params[2])) ? event.params[2] : 'bf',
                preloadData: {
                    sprite: '',
                    icon: ''
                },
                xml: ''
            };
            data.preloadData.sprite = data.preloadData.icon = data.name;
            data.xml = Assets.getText(Paths.xml('characters/' + data.name));
            
            var stupidShit = [];
            for (i in ['sprite="', 'icon="']) {
                if (!StringTools.contains(data.xml, i)) continue;
                var index1 = data.xml.indexOf(i);
                var index2 = data.xml.indexOf('"', index1 + i.length);
                stupidShit.push(StringTools.replace(data.xml.substring(index1, index2), i, ''));
            }

            data.preloadData.sprite = stupidShit[0];
            data.preloadData.icon = Assets.exists(Paths.image('icons/' + stupidShit[1])) ? stupidShit[1] : 'face';

            if (FileSystem.isDirectory('mods/' + ModsFolder.currentModFolder + '/images/characters/' + data.preloadData.sprite))
                for (i in Paths.getFolderContent('characters/' + data.preloadData.sprite))
                    preload('characters/' + data.preloadData.sprite + '/' + i);
            else
                preload('characters/' + data.preloadData.sprite);

            preload('icons/' + data.preloadData.icon);

            dataShit.push(data);
        }
}

function onEvent(_)
    if (_.event.name == 'Change Character') {
        var data = dataShit.pop();
        var character:Character = strumLines.members[_.event.params[0]].characters[_.event.params[1]];
        var isPlayer:Bool = strumLines.members[_.event.params[0]].characters[0].isPlayer;
        
        strumLines.members[_.event.params[0]].characters.remove(character);
        remove(character);
        character = new Character(0, 0, data.name, isPlayer);
        stage.applyCharStuff(character, strumLines.members[_.event.params[0]].data.position, _.event.params[1]);
        strumLines.members[_.event.params[0]].characters.insert(_.event.params[1], character);

        if (_.event.params[1] == '0') {
            var icon:HealthIcon = isPlayer ? icoP1 : icoP2;
            if (icon.graphic != data.preloadData.icon) {
                remove(icon);
                icon = new HealthIcon(character.getIcon(), isPlayer);
                icon.cameras = [camHUD];
                icon.y = healthBar.y - (icon.height / 2);
                insert(members.indexOf(healthBar)+2, icon);
    
                if (isPlayer) {
                    icon.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 1, 0)) - 26);
                    icoP1 = icon;
                    icon.health = healthBar.percent;
                }
                else {
                    icon.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 1, 0))) - (icon.width - 26);
                    icoP2 = icon;
                    icon.health = healthBar.percent;
                }
    
                var leftColor:Int = dad.iconColor != null && Options.colorHealthBar ? dad.iconColor : 0xFFFF0000;
                var rightColor:Int = boyfriend.iconColor != null && Options.colorHealthBar ? boyfriend.iconColor : 0xFF66FF33;
                var colors = [leftColor, rightColor];
                healthBar.createFilledBar((PlayState.opponentMode ? colors[1] : colors[0]), (PlayState.opponentMode ? colors[0] : colors[1]));
                healthBar.updateBar();

                // this is such a shitty way for losing icon detection but whatever it works LOL - apurples
                health -= .001;
                new FlxTimer().start(.001, function(tmr:FlxTimer){
                    health += .001;
                });
            }
        }
    }