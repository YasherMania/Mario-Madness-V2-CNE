var random = FlxG.random.int(1, 24);
/* 
    This map is only here to try out maps
    as I've never used them before lmao
    - MAZ
*/

var bpmValues = [
    1 => 150, 2 => 184, 3 => 154, 4 => 110, 5 => 195, 6 => 144, 7 => 200, 8 => 153, 9 => 175, 10 => 155,
    11 => 199, 12 => 145, 13 => 130, 14 => 135, 15 => 135, 16 => 120, 17 => 120, 18 => 120, 19 => 165,
    20 => 153.35, 21 => 120, 22 => 135.01, 23 => 182.22, 24 => 131
];
function create(e) {
    e.lossSFX = 'game/grandDad/lossSFX';
    e.character = "bfGDDIES";
    e.gameOverSong = "gameOverMusic/grandDad/ghost_" + random;
    e.bpm = bpmValues[random];
}