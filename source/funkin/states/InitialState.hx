// first state you should be loading into, anyone can change this
package funkin.states;

class InitialState extends MusicBeatState {
    var nextState:Class<FlxState> = TitleState;
    override function create() {
        #if MODS
		ModUtil.init();
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

        switchState(nextState);

        super.create();
    }
}