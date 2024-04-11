package funkin.states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

using StringTools;

#if discord_rpc
import Discord.DiscordClient;
#end

class MainMenuStateNew extends MusicBeatState {
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
        #if discord_rpc
		DiscordClient.changePresence("In the Menus", null);
		#end

        var bgGraphicPath:String = 'menuDesat';

        background = new FlxSprite(Paths.image(bgGraphicPath));
		background.setGraphicSize(Std.int(background.width * 1.2));
		background.updateHitbox();
		background.screenCenter();
		background.antialiasing = true;
        background.color = 0xF3DA77;
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

        super.create();
    }

    override function update(elapsed:Float) {
        if (controls.UI_UP_P) {
            changeSelection(1);
        }

        if (controls.UI_DOWN_P) {
            changeSelection(-1);
        }

        super.update(elapsed);
    }

    function addMenuItem(name:String) {
        var curItemID:Int;
        curItemID = loadedMenuItems.length; // this might not work but idk

        var item:MenuItem;
        item = new MenuItem(0, 0, name);
        item.screenCenter();
        item.ID = curItemID;
        item.y += ((item.height + 20) * curItemID);
        item.targetY = curItemID;
        item.animation.play('idle');
        item.antialiasing = true;
        loadedMenuItems.add(item);
    }

    function changeSelection(change:Int = 0, playSound:Bool = false) {
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
			if (item.ID == curSelected) {
                item.animation.play('selected');
				item.alpha = 1;
            } else {
                item.animation.play('idle');
				item.alpha = 0.6;
            }
			bullShit++;
		}
    }
}