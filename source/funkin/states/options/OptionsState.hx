package funkin.states.options;

import flixel.addons.display.FlxBackdrop;

class OptionsState extends MusicBeatState {
    override function create() {
        #if DISCORD
        DiscordRPC.changePresence('Changing Preferences');
        #end

        var menuBG = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBG.color = 0xff6a8dc2;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.scrollFactor.set(0, 0);
		add(menuBG);

        var bgScroll = new FlxBackdrop(Paths.image('options/bgGrid'));
        bgScroll.velocity.set(0.2, 0.2);
        bgScroll.color = menuBG.color;
        bgScroll.alpha = 0.6;
        add(bgScroll);

        super.create();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}