package funkin.options;

import flixel.addons.display.FlxBackdrop;
import funkin.options.objects.SectionName;

class OptionsStateNew extends MusicBeatState {
    public static var menuColor:FlxColor = 0xffc371fd;

    var curSelected:Int = 0;

    var menuItems:FlxTypedGroup<SectionName>;
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
		menuBG.color = menuColor;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.scrollFactor.set();
		add(menuBG);

        for (i in 0...optionsList.length) {
            // var newSection = Reflect.getProperty(funkin.options.sections, optionsList[i] + 'Section');
        }

        var section = new SectionName(0, 0, 'Gameplay');
        add(section);

        menuItems = new FlxTypedGroup<SectionName>();
        add(menuItems);

        changeSelection(0, false);

        super.create();
    }

    override function update(elapsed:Float) {
        if (controls.ACCEPT) {
            trace('accept');
        }

        if (controls.BACK) {
            FlxG.switchState(new MainMenuState());
        }

        if (controls.UI_LEFT_P) {
            changeSelection(-1);
        }

        if (controls.UI_RIGHT_P) {
            changeSelection(1);
        }

        super.update(elapsed);
    }

    function addSection(section:funkin.options.sections.OptionSection) {
        var section = new SectionName(0, 0, section.sectionName);
        add(section);
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
    }
}