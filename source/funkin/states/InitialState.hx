package funkin.states;

import openfl.Lib;
import lime.system.System;

#if CRASH_HANDLER
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import sys.io.Process;
#end

/**
    Used for initializing utils and loading data preferences.
**/
class InitialState extends MusicBeatState {
    override function create() {
        #if MOD_SUPPORT
		trace('the mod be supporting');
		#end

		FlxG.save.bind('prototype', EngineMain.savePath); // just a precaution
        FunkinData.initialize();
		Highscore.load();

		#if CRASH_HANDLER
		trace('the crashes be handlin');
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end

        FlxG.game.focusLostFramerate = 60;

		FlxG.sound.muteKeys = [ZERO];

        FlxG.drawFramerate = FunkinData.data.get('maxFramerate');
		FlxG.updateFramerate = FunkinData.data.get('maxFramerate');

        if (FunkinData.save.data.volume != null)
			FlxG.sound.volume = FunkinData.save.data.volume;
		if (FunkinData.save.data.mute != null)
			FlxG.sound.muted = FunkinData.save.data.mute;

        FlxG.autoPause = FunkinData.save.data.unfocusPause;

        #if discord_rpc
		Discord.initialize();

		Application.current.onExit.add(function(exitCode)
		{
			Discord.shutdown();
		});
		#end

		if (FunkinData.initialized)
        	FlxG.switchState(new funkin.states.TitleState());

		FlxG.signals.focusLost.add(function() {
			Main.lostFocus.visible = true;
			// trace('focus lost');
		});

		FlxG.signals.focusGained.add(function() {
			Main.lostFocus.visible = false;
			// trace('focus gained');
		});

		#if VIDEO_PLAYBACK
		trace('videos allowed');
		#end

		// trace(EngineMain.repository.name);
		// trace(EngineMain.repository.description);
		// trace(EngineMain.getRepoCommits());

        super.create();
    }

	// base code by sqirra-rng
	#if CRASH_HANDLER
	function onCrash(e:UncaughtErrorEvent):Void {
		var errMsg:String = '';
		var errData:String = '';

		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		errMsg = e.error;
		errData = '';

		// ughhh.. i wanna sleep
		for (stackItem in callStack) {
			switch (stackItem) {
				case FilePos(s, file, line, column):
					errData += file + " (line " + line + ")\n";
				case Module(m):
					errData += 'Module ' + m + '\n';
				case CFunction:
					errData += 'C Function\n';
				case Method(name, method):
					errData += 'Class method: ' + name + '.' + method + '\n';
				case LocalFunction(v):
					errData += 'Local function #' + v + '\n';
			}
		}

		new Process("./crash/ProtoCrash.exe", [errMsg, errData, dateNow]);
		Sys.exit(1);
	}
	#end
}