package funkin.states.options;

import flixel.addons.display.FlxBackdrop;

class OptionsStateNew extends MusicBeatState
{
    override function create() {
        #if discord_rpc
        Discord.changePresence('Changing Preferences');
        #end

        var menuBG = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBG.color = 0xffc371fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.scrollFactor.set(0, 0);
		add(menuBG);

        var bfGrid = new FlxBackdrop(Paths.image('options/bgGrid'));
        bfGrid.velocity.set(0.2, 0.2);
        bfGrid.color = menuBG.color;
        bfGrid.alpha = 0.6;
        add(bfGrid);

        super.create();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}