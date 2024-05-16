package;

import flixel.FlxGame;

class FNFGame extends FlxGame {
    public function switchState(next:FlxState = null) {
		if (next == null) {
			refreshState();
			return;
		}
		FlxG.switchState(next);
    }

    public function refreshState() {
		FlxG.resetState();
	}
}