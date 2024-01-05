import hxvlc.flixel.FlxVideo;

var curVideo:FlxVideo;
function postCreate()
{
	inst.time = 0;
    inst.volume = 0;
	inCutscene = true;
    trace("uh oh you died!!");
    curVideo = new FlxVideo();
	curVideo.onEndReached.add(curVideo.dispose);
    var path = Paths.file("videos/Itsame_cutscene.mp4");
	if(Reflect.hasField(curVideo, "load")) {
		curVideo.load(Assets.getPath(path));
        curVideo.play();
	} else {
    	curVideo.play(Assets.getPath(path));
	}
        
    trace("video played!");
	if (curVideo == null) trace("video did not play! did you check if the video name is spelled correctly?");
}

function onEnd():Void
{
	curVideo.dispose();
	inCutscene = false;
	startCountdown();
}