function exit(){
    if (WarningState.optionsPressed){
        FlxG.switchState(new ModState('customStates/WarningState'));
        WarningState.optionsPressed = false;
    }
}