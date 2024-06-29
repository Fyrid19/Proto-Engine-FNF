package funkin;

import flixel.util.FlxArrayUtil;
import flixel.FlxGame;

// mainly used for debug keybinds
class FNFGame extends FlxGame {
    override function update() {
		super.update();
        debugKeys();
    }

    function debugKeys() {
        if (FlxG.keys.pressed.SHIFT && FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.R) {
            FlxG.resetGame();
            trace('reset');
        }
    }
}