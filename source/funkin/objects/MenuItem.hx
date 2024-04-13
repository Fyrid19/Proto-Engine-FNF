package funkin.objects;

class MenuItem extends FlxSprite {
    public var acceptMenu:Void->Void = null;
    public var targetY:Float = 0;
    public var imageName:String;
    public var realName:String;

    public function new(x:Float, y:Float, name:String) {
        super(x, y);
        realName = name;
        imageName = StringTools.replace(name, ' ', '-');
        frames = Paths.getSparrowAtlas('mainmenu/' + imageName + '_menu');

        antialiasing = true;

        animation.addByPrefix('idle', imageName + " idle", 24);
        animation.addByPrefix('selected', imageName + " selected", 24);
        animation.play('idle');
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        y = FlxMath.lerp((targetY * 160) + 240, y, Math.exp(-elapsed * 10.2));
    }
}