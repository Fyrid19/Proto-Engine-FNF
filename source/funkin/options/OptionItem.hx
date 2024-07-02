package funkin.options;

import flixel.group.FlxSpriteGroup;

class OptionItem extends FlxSpriteGroup {
    var nameText:FlxText;
    var valueText:FlxText;

    public function new(x:Float, y:Float, text:String) {
        super(x, y);

        nameText = new FlxText(x, y, FlxG.width, '', 32);
        nameText.setFormat(Paths.font('vcr.ttf'), 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

        valueText = new FlxText(x, y, FlxG.width, '', 32);
        valueText.setFormat(Paths.font('vcr.ttf'), 32, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    }

    override function update(elapsed:Float) {
		super.update(elapsed);
    }
}