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

	// referenced from psych engine, which in turn is from "Izzy Engine" and made by sqirra-rng
	#if CRASH_HANDLER
	function onCrash(e:UncaughtErrorEvent):Void {
		var errorData:Array<String> = [''];
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();
		var dateFormat:String = dateNow.replace(" ", "_").replace(":", "'");

		errorData[0] = e.error;
		errorData[1] = '';
		errorData[2] = dateNow;

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errorData[1] += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		new Process("./crash/ProtoCrash.exe", errorData[0], errorData[1], errorData[2]);
		Sys.exit(1);
	}
	#end
}