package funkin.states;

import openfl.Lib;
import lime.system.System;

#if CRASH_HANDLER
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import sys.io.Process;
import sys.io.File;
import sys.FileSystem;
#end

/**
    Used for initializing utils and loading data preferences.
**/
class InitialState extends MusicBeatState {
    override function create() {
		FlxG.save.bind('prototype', EngineMain.savePath); // just a precaution
        FunkinData.initialize();
		Highscore.load();

		#if MOD_SUPPORT
		trace('the mod be supporting');
		#end

		#if CRASH_HANDLER
		trace('the crashes be handlin');
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end

		#if DISCORD_RPC
		trace('im discording out');
		DiscordRPC.init();
		#end

		#if VIDEO_PLAYBACK
		trace('videos allowed');
		#end

		FlxG.sound.muteKeys = [ZERO];

        if (FunkinData.save.data.volume != null)
			FlxG.sound.volume = FunkinData.save.data.volume;
		if (FunkinData.save.data.mute != null)
			FlxG.sound.muted = FunkinData.save.data.mute;

        FlxG.autoPause = FunkinData.save.data.unfocusPause;

		resetFramerate();

		Application.current.onExit.add(function(e) {
            FunkinData.save.data.volume = FlxG.sound.volume;
        });

        FlxG.game.focusLostFramerate = 30;
		FlxG.signals.focusLost.add(function() {
			// Main.lostFocus.visible = true;
			FlxG.drawFramerate = 30; // lower framerate for better performace
			// trace('focus lost');
		});

		FlxG.signals.focusGained.add(function() {
			// Main.lostFocus.visible = false;
			resetFramerate();
			// trace('focus gained');
		});

		var latestCommit = EngineMain.getLatestCommit();
		trace('- Github Info -');
		trace('Repo Name: ' + EngineMain.repository.name);
		trace('Repo Desc: ' + EngineMain.repository.description);
		trace('Current Commit: ' + Globals.COMMIT_NUMBER + '(${Globals.COMMIT_HASH})');

		FunkinAssets.init();
		
		if (FunkinData.initialized)
        	FlxG.switchState(new funkin.states.WarningState());

        super.create();
    }

	function resetFramerate() {
		FlxG.drawFramerate = FunkinData.save.data.maxFramerate;
		FlxG.updateFramerate = FunkinData.save.data.maxFramerate;
	}

	// base code by sqirra-rng
	#if CRASH_HANDLER
	function onCrash(e:UncaughtErrorEvent):Void {
		var errMsg:String = '';
		var errData:String = '';
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();
        var dateFormat = dateNow.replace(" ", "_").replace(":", "-");

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

		var appVer:String = '1.0';
        var crashLocation:String = "./crash/crashlog/";
        var fileName:String = 'ProtoCrashLog_' + dateFormat + '.txt';
        var normalFilePath:String = Path.normalize(crashLocation + fileName);
        final errCompact:String = 'Prototype Engine Crash Handler v' + appVer + '\n'
        + errMsg + '\n\n' 
        + errData + '\n\n' 
		+ 'Crash at $dateNow\n' 
        + 'Original code by sqirra-rng';
        if (!FileSystem.exists("./crash/")) {
            crashLocation = "./crashlog/";
            normalFilePath = Path.normalize(crashLocation + fileName);
        }

        if (!FileSystem.exists(crashLocation))
            FileSystem.createDirectory(crashLocation);

        if (!FileSystem.exists(crashLocation + fileName)) {
            File.saveContent(crashLocation + fileName, errCompact);
		}

		// new Process("./crash/ProtoCrash.exe", [errMsg, errData, dateNow]);

		// placeholder
		Lib.application.window.alert(errCompact, 'Prototype Engine Crash Handler');
		Sys.exit(0);
	}
	#end
}