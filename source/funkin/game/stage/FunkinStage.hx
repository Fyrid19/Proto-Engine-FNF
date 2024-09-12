package funkin.game.stage;

class FunkinStage {
    public var bgSprites:FlxTypedGroup<BGSprite>;
    public var fgSprites:FlxTypedGroup<BGSprite>;
    public var stageSounds:Array<String>;
    public var soundSuffix:String;

    public function new() {
        bgSprites = new FlxTypedGroup<BGSprite>();
        fgSprites = new FlxTypedGroup<BGSprite>();
    }
}