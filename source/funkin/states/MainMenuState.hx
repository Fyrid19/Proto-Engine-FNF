package funkin.states;

import funkin.states.options.OptionsState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.ui.FlxButton;
import lime.app.Application;

class MainMenuState extends MusicBeatState { // i hate how main menu is coded so why not do it myself
    var menuItems:Array<String> = [
        'Story Mode',
        'Freeplay',
        'Options'
        // 'Mods'
    ];

    var loadedMenuItems:FlxTypedGroup<MenuItem>;

    var curSelected:Int;

    var background:FlxSprite;
    var magentaBG:FlxSprite;

    override function create() {
        transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}
        
        #if discord_rpc
		DiscordClient.changePresence("In the Menus", null);
		#end

        var bgGraphicPath:String = 'menuDesat';

        background = new FlxSprite(Paths.image(bgGraphicPath));
		background.setGraphicSize(Std.int(background.width * 1.2));
		background.updateHitbox();
		background.screenCenter();
		background.antialiasing = true;
        background.color = 0xF2D45E;
		add(background);

        magentaBG = new FlxSprite(Paths.image(bgGraphicPath));
		magentaBG.setGraphicSize(Std.int(background.width));
		magentaBG.updateHitbox();
		magentaBG.screenCenter();
		magentaBG.antialiasing = true;
        magentaBG.color = 0xfd719b;
        magentaBG.visible = false;
	    add(magentaBG);

        loadedMenuItems = new FlxTypedGroup<MenuItem>();
        add(loadedMenuItems);

        for (i in 0...menuItems.length) {
            addMenuItem(menuItems[i]);
        }

        for (item in loadedMenuItems) {
            switch item.realName {
                case 'story mode':
                    item.acceptMenu = () -> {
                        FlxG.switchState(new StoryMenuState());
                    }
                case 'freeplay':
                    item.acceptMenu = () -> {
                        FlxG.switchState(new FreeplayState());
                    }
                case 'options':
                    item.acceptMenu = () -> {
                        FlxG.switchState(new OptionsState());
                    }
                default:
                    trace('"acceptMenu" pointer function isnt set!')
                    item.acceptMenu = () -> {
                        FlxG.switchState(new MainMenuState());
                    }
            }
        }

        changeSelection(0, false);

        super.create();
    }

    override function update(elapsed:Float) {
        if (controls.UI_UP_P) {
            changeSelection(-1);
        }

        if (controls.UI_DOWN_P) {
            changeSelection(1);
        }

        if (controls.ACCEPT) {
            FlxG.sound.play(Paths.sound('confirmMenu'));

            for (item in loadedMenuItems) {
                if (item.ID == curSelected) {
                    item.acceptMenu();
                }
            }
        }

        super.update(elapsed);
    }

    var id:Int = 0;
    var itemSize:Float = 1;
    function addMenuItem(name:String) {
        var item:MenuItem;
        item = new MenuItem(0, 0, name.toLowerCase());
        item.setGraphicSize(Std.int(item.width*itemSize));
        item.screenCenter();
        item.targetY = id;
        item.ID = id;

        loadedMenuItems.add(item);
        id++;
    }

    function changeSelection(change:Int = 0, playSound:Bool = true) {
        if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'));

        curSelected += change;

        if (curSelected < 0)
            curSelected = menuItems.length - 1;
        if (curSelected > menuItems.length - 1)
            curSelected = 0;

        var bullShit:Int = 0;

		for (item in loadedMenuItems.members)
		{
			item.targetY = bullShit - curSelected;
			if (item.ID == curSelected)
                item.animation.play('selected');
            else
                item.animation.play('idle');
			bullShit++;
		}
    }
}