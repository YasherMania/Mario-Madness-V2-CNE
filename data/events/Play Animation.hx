
function onEvent(_) {
	if (_.event.name == "Play Animation")
		_.event.params[0].animation.play(_.event.params[1], _.event.params[2]);
}