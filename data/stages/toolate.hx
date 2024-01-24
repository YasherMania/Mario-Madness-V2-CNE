var revealed = false;

function update(elapsed) {
	switch(curCameraTarget) {
		case 0:
			if (!revealed) defaultCamZoom = 0.8;
			if (revealed) defaultCamZoom = 0.55;
		case 1:
			if (!revealed) defaultCamZoom = 0.7;
			if (revealed) defaultCamZoom = 0.55;
	}
}

function reveal() {
	revealed = true;
	camZoomingInterval = 2;
}

function dialog1() {
	strumLines.members[1].characters[0].danceOnBeat = false;
	strumLines.members[1].characters[0].animation.play('dialog1', true);
}
function normal() {
	strumLines.members[1].characters[0].danceOnBeat = true;
}