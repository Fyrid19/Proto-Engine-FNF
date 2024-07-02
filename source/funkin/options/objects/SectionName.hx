package funkin.options.objects;

class SectionName extends FlxSpriteGroup {
    public var targetX:Float = 0;
    var text:FlxText;

    public function new(x:Float, y:Float, name:String) {
        super(x, y);
        text = new FlxText(x, y, FlxG.width, name, 64);
        text.setFormat(Paths.font('muff.ttf'), 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        x = FlxMath.lerp(x, (targetX * 120), 0.17);
    }
}