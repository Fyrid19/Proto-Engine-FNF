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
		bfGrid.setGraphicSize(Std.int(bfGrid.width * 0.5));
        bfGrid.velocity.set(50, 50);
        bfGrid.color = menuBG.color;
		bfGrid.updateHitbox();
		bfGrid.screenCenter(X);
		bfGrid.scrollFactor.set(0, 0);
        bfGrid.alpha = 0.4;
        add(bfGrid);

        super.create();
    }

    override function update(elapsed:Float) {
        if (controls.BACK) {
            FlxG.switchState(new MainMenuState());
        }

        super.update(elapsed);
    }
}