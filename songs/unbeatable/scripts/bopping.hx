public var cZoomingInterval:Int = 4;
public var cZoomingBumpGame:Int = 0.03;
public var cZoomingBumpHud:Int = 0.09;

function beatHit(b) {
    if(cZoomingInterval != 4 && b % cZoomingInterval == 0) {
        camGame.zoom += cZoomingBumpGame;
        camHUD.zoom += cZoomingBumpHud;
    }
}