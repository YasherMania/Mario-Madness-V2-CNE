var game:Float;
var hud:Float;

function onEvent(eventEvent) {
    if (eventEvent.event.name == "Add Camera Zoom") zoom(eventEvent);
}

function zoom(eventEvent){
    if (camGame.zoom < 1.35){
    	game = Std.parseFloat(eventEvent.event.params[0]);
		hud = Std.parseFloat(eventEvent.event.params[1]);

		camGame.zoom += game;
		camHUD.zoom += hud;
    }
}