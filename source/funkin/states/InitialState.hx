package funkin.states;

import flixel.util.FlxTimer;

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

        FlxG.game.focusLostFramerate = 60;

        FlxG.drawFramerate = FunkinData.save.data.maxFramerate;
		FlxG.updateFramerate = FunkinData.save.data.maxFramerate;

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

        super.create();
    }
}