package;

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

    var loadedMenuItems:Array<MenuItem> = [];

    var curSelected:Int;

    var background:FlxSprite;
    var magentaBG:FlxSprite;

    override function create() {
        #if discord_rpc
		DiscordClient.changePresence("In the Menus", null);
		#end

        var bgGraphicPath:String = 'menuDesat';

        background = new FlxSprite(Paths.image(bgGraphicPath));
		background.setGraphicSize(Std.int(bg.width * 1.2));
		background.updateHitbox();
		background.screenCenter();
		background.antialiasing = true;
        background.color = 0xFAD649;
		add(background);

        magentaBG = new FlxSprite(Paths.image(bgGraphicPath));
		magentaBG.setGraphicSize(Std.int(bg.width));
		magentaBG.updateHitbox();
		magentaBG.screenCenter();
		magentaBG.antialiasing = true;
        magentaBG.color = 0xfd719b;
        magentaBG.visible = false;
	    add(magentaBG);

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
        var item:MenuItem;
        item = new MenuItem(0, 0, name);
        item.screenCenter(X);
        item.animation.play('idle');
        loadedMenuItems.push();
    }

    function changeSelection(change:Int = 0, playSound:Bool = false) {
        if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'));

        curSelected += change;

        if (curSelected < 0)
            curSelected = menuItems.length - 1;
        if (curSelected > menuItems.length - 1)
            curSelected = 0;
    }
}