package funkin.objects;

import flixel.FlxG;
import flixel.FlxSprite;

using StringTools;

class MenuItem extends FlxSprite {
    public var targetY:Float = 0;
    var imageName:String;

    public function new(x:Float, y:Float, name:String) {
        super(x, y);
        imageName = StringTools.replace(name, ' ', '-');
        loadGraphic(Paths.image('mainmenu/' + imageName));

        animation.addByPrefix('idle', imageName + " idle", 24);
        animation.addByPrefix('selected', imageName + " selected", 24);
        animation.play('idle');
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        y = CoolUtil.coolLerp(y, (targetY * 120), 0.17);
    }
}