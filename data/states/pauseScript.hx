function create(e) {
    e.music = switch(game.curStage) {
        case 'bootleg': 'breakfast music/GD_breakfast1';
        /* 
        Uncomment if the stage is ported 
        case 'warioworld': 'breakfast music/wario_breakfast1';
        */
        default: 'breakfast music/breakfast' + FlxG.random.int(1,3);
    }
}