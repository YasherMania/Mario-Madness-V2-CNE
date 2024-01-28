
function onEvent(_) {
	if (_.event.name == "Play Animation")
		for (char in strumLines.members[_.event.params[0]].characters)
            char.playAnim(_.event.params[1], _.event.params[2]);
}