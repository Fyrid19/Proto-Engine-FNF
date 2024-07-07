package funkin.states;

import openfl.Lib;

#if CRASH_HANDLER
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
#end

/**
    Used for initializing utils and loading data preferences.
**/
class InitialState extends MusicBeatState {
    override function create() {
        #if MODS
		ModUtil.init();
		#end

        FunkinData.initialize();
		Highscore.load();

		#if CRASH_HANDLER
		crashInit();
		#end

        FlxG.game.focusLostFramerate = 60;

		FlxG.sound.muteKeys = [ZERO];

        FlxG.drawFramerate = FunkinData.data.get('maxFramerate');
		FlxG.updateFramerate = FunkinData.data.get('maxFramerate');

        if (FunkinData.save.data.volume != null)
			FlxG.sound.volume = FunkinData.save.data.volume;
		if (FunkinData.save.data.mute != null)
			FlxG.sound.muted = FunkinData.save.data.mute;

        // FlxG.autoPause = FunkinData.save.data.unfocusPause;

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

        super.create();
    }

	function crashInit() {
		#if CRASH_HANDLER
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end
	}

	// referenced from psych engine, which in turn is from "Izzy Engine" and made by sqirra-rng
	#if CRASH_HANDLER
	function onCrash(e:UncaughtErrorEvent):Void {
		var msg:String = "";
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);

		msg += 'Game crash!\n' + e.error + '\n';

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					msg += file + " at line " + line + "\n";
				default:
					Sys.println(stackItem);
			}
		}

		msg += '\nPlease report this error to the GitHub page! \nhttps://github.com/Fyrid19/Proto-Engine-FNF';

		Application.current.window.alert(msg, "Game Crash");
		Sys.exit(1);
	}
	#end
}