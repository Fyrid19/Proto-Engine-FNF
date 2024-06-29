package funkin.states;

import funkin.states.options.OptionsState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.ui.FlxButton;
import lime.app.Application;

class MainMenuState extends MusicBeatState { // i hate how main menu is coded so why not do it myself
    var engineVer = 'v' + Application.current.meta.get('version');
    var funkinVer = 'v0.2.8';

    var loadedMenuItems:FlxTypedGroup<MenuItem>;
    var menuItems:Array<String> = [
        'Story Mode',
        'Freeplay',
        'Credits',
        'Options'
        // 'Mods'
    ];

    var curSelected:Int;

    var magentaBG:FlxSprite;

    var itemSize:Float = 1;
    var yFactor:Float;

    override function create() {
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}
        
        #if discord_rpc
		DiscordClient.changePresence("In the Menus", null);
		#end

        var bgGraphicPath:String = 'menuBG';
        var magentaBgGraphicPath:String = 'menuDesat';

        var menuBG = new FlxSprite(Paths.image(bgGraphicPath));
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.2));
        menuBG.scrollFactor.set(0, yFactor);
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
        // menuBG.color = 0xF5CF3B;
		add(menuBG);

        magentaBG = new FlxSprite(Paths.image(magentaBgGraphicPath));
		magentaBG.setGraphicSize(Std.int(menuBG.width));
        magentaBG.scrollFactor.set(0, yFactor);
		magentaBG.updateHitbox();
		magentaBG.screenCenter();
		magentaBG.antialiasing = true;
        magentaBG.color = 0xfd719b;
        magentaBG.visible = false;
	    add(magentaBG);

        var offset:Array<Float> = [2, 2];

        var funkinVerText:FlxText = new FlxText(0, 0, 0, "Friday Night Funkin' " + funkinVer, 16);
		funkinVerText.setFormat(Paths.font('vcr.ttf'), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        funkinVerText.scrollFactor.set();
        funkinVerText.x = offset[0];
        funkinVerText.y = FlxG.height - funkinVerText.height - offset[1];
        add(funkinVerText);
        var engineVerText:FlxText = new FlxText(0, 0, 0, "Prototype Engine " + engineVer, 16);
		engineVerText.setFormat(Paths.font('vcr.ttf'), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        engineVerText.scrollFactor.set();
        engineVerText.x = offset[0];
        engineVerText.y = funkinVerText.y - engineVerText.height - offset[1];
        add(engineVerText);

        loadedMenuItems = new FlxTypedGroup<MenuItem>();
        add(loadedMenuItems);

        for (i in 0...menuItems.length) {
            addMenuItem(menuItems[i]);
        }

        yFactor = (loadedMenuItems.length - 4) * 0.15;
        if (loadedMenuItems.length < 4) yFactor = 0;

        var itemSpacing:Float = 170;
        for (item in loadedMenuItems) {
            item.y = 50 + itemSpacing*item.ID;
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
                        FlxG.switchState(new funkin.states.options.OptionsStateNew());
                    }
                default:
                    item.acceptMenu = () -> {
                        trace('"acceptMenu" pointer function isnt set!');
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
    function addMenuItem(name:String) {
        var item:MenuItem;
        item = new MenuItem(0, 0, name.toLowerCase());
        item.setGraphicSize(Std.int(item.width*itemSize));
        item.scrollFactor.set(0, yFactor);
        item.screenCenter(X);
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

		for (item in loadedMenuItems.members)
		{
			if (item.ID == curSelected) {
                item.animation.play('selected');
                item.centerOffsets();
                item.screenCenter(X);
            } else {
                item.animation.play('idle');
                item.centerOffsets();
                item.screenCenter(X);
            }
        }
    }
}