static var skipTransition:Bool = false;

function create() {
	if (skipTransition) {
		transitionTween.cancel();

		remove(blackSpr);
		remove(transitionSprite);

		finish();
	}
}