package funkin.options;

import flixel.group.FlxSpriteGroup;

class OptionItem extends FlxSpriteGroup {
    var nameText:FlxText;
    var valueText:FlxText;

    var name:String;
    var value:String;

    public function new(x:Float, y:Float, name:String, startingValue:Dynamic) {
        super(x, y);

        nameText = new FlxText(x, y, FlxG.width * 0.8, '', 32);
        nameText.setFormat(Paths.font('vcr.ttf'), 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(nameText);

        valueText = new FlxText(x, y, FlxG.width * 0.8, '', 32);
        valueText.setFormat(Paths.font('vcr.ttf'), 32, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(valueText);
    }

    override function update(elapsed:Float) {
		super.update(elapsed);
    }
}