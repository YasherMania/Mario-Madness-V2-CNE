// Psych Event Loader by Frakits and bctix

import flixel.util.FlxSort;
import StringTools;
function create() {
	var chart = Json.parse(Assets.getText(Paths.chart(curSong, PlayState.difficulty)));
	for (i in chart.song.events) {
		var functionName = i[1][0][0];
		functionName = StringTools.replace(functionName," ", "").toLowerCase();
		var curEvent = {
			time: i[0],
			type: -1,
			params: [functionName,i[1][0][1],i[1][0][2]]
			};
		for (j in 1...events.length){ 
			if (events[j-1].time >= curEvent.time && events[j].time <= curEvent.time)
			if (!events.contains(curEvent)) events.insert(j, curEvent);
		}
	}
	trace(StringTools.replace(events.toString(),"},","}\n"));

}
function flashcamera(d,i) {
	trace(i);
	camGame.flash();
}