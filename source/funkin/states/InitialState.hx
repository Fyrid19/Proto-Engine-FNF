package funkin.states;

class InitialState extends MusicBeatState {
    override function create() {
        #if MODS
		ModUtil.init();
		#end

        FunkinData.initialize();
		Highscore.load();

        #if discord_rpc
		Discord.initialize();

		Application.current.onExit.add(function(exitCode)
		{
			Discord.shutdown();
		});
		#end

        super.create();
    }
    
    override function update(elapsed:Float) {
        FlxG.switchState(new TitleState());
    }
}