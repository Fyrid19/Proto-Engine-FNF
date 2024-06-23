package funkin.states.options;

import flixel.addons.display.FlxBackdrop;
import funkin.objects.ui.OptionItem;

class OptionsStateNew extends MusicBeatState {
    var curSelected:Int = 0;

    var selectorLeft:Alphabet;
    var selectorRight:Alphabet;

    var menuItems:FlxTypedGroup<Alphabet>;
    var optionsList:Array<String> = [
        'Gameplay',
        'Controls',
        'Graphics'
    ];

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

        // selectorLeft = new Alphabet(0, 0, '>');
        // add(selectorLeft);
        // selectorRight = new Alphabet(0, 0, '<');
        // add(selectorRight);

        menuItems = new FlxTypedGroup<Alphabet>();
        add(menuItems);

        var spacing:Float = 100;
        for (i in 0...optionsList.length) {
            var menuItem:Alphabet = new Alphabet(0, 100+(i*spacing), optionsList[i], true);
            menuItem.screenCenter(X);
            menuItem.ID = i;
            menuItems.add(menuItem);
        }

        changeSelection(0, false);

        super.create();
    }

    override function update(elapsed:Float) {
        if (controls.BACK) {
            FlxG.switchState(new MainMenuState());
        }

        if (controls.UI_UP_P) {
            changeSelection(-1);
        }

        if (controls.UI_DOWN_P) {
            changeSelection(1);
        }

        super.update(elapsed);
    }

    function changeSelection(change:Int = 0, playSound:Bool = true) {
        if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'));

        curSelected += change;

        if (curSelected < 0)
            curSelected = optionsList.length - 1;
        if (curSelected > optionsList.length - 1)
            curSelected = 0;

        for (item in menuItems) {
            if (item.ID == curSelected)
                item.alpha = 1;
            else
                item.alpha = 0.6;
        }

        // will do later
        // FlxTween.cancelTweensOf(selectorLeft);
        // FlxTween.cancelTweensOf(selectorRight);
        // FlxTween.tween(selectorLeft, {x: item.x - selectorLeft.width - 10, y: item.y}, 0.6, {ease: FlxEase.circOut});
        // FlxTween.tween(selectorRight, {x: item.x + item.width + selectorRight.width + 10, y: item.y}, 0.6, {ease: FlxEase.circOut});
    }
}