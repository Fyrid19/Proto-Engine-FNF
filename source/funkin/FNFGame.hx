package funkin;

import flixel.util.FlxArrayUtil;
import flixel.FlxGame;

// mainly used for debug keybinds
class FNFGame extends FlxGame {
    override function update() {
        if (!_state.active || !_state.exists)
			return;

		if (_state != _requestedState)
			switchState();

		#if FLX_DEBUG
		if (FlxG.debugger.visible)
			ticks = getTicks();
		#end

		updateElapsed();

		FlxG.signals.preUpdate.dispatch();

		updateInput();

		#if FLX_POST_PROCESS
		if (postProcesses[0] != null)
			postProcesses[0].update(FlxG.elapsed);
		#end

		#if FLX_SOUND_SYSTEM
		FlxG.sound.update(FlxG.elapsed);
		#end
		FlxG.plugins.update(FlxG.elapsed);

		_state.tryUpdate(FlxG.elapsed);

		FlxG.cameras.update(FlxG.elapsed);
		FlxG.signals.postUpdate.dispatch();

		#if FLX_DEBUG
		debugger.stats.flixelUpdate(getTicks() - ticks);
		#end

		#if FLX_POINTER_INPUT
		FlxArrayUtil.clearArray(FlxG.swipes);
		#end

		filters = filtersEnabled ? _filters : null;

        debugKeys();
    }

    function debugKeys() {
        if (FlxG.keys.pressed.SHIFT && FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.R) {
            FlxG.resetGame();
            trace('reset');
        }
    }
}