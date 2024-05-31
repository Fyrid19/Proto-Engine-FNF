// first state you should be loading into, anyone can change this
package funkin.states;

import flixel.FlxState;

class InitialState extends MusicBeatState {
    override function create() {
        #if MODS
		// ModUtil.init();
		#end

        FunkinData.initialize();
		Highscore.load();

        #if DISCORD
		DiscordRPC.initialize();

		Application.current.onExit.add(function(exitCode)
		{
			DiscordRPC.shutdown();
		});
		#end

        FunkinUtil.switchState(TitleState);

        super.create();
    }
}