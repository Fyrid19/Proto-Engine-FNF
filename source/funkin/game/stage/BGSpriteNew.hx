package funkin.game.stage;

class BGSprite extends FlxSprite {
    public var key:String;
    public var animated:Bool;
    
    public function new(key:String, x:Float, y:Float, ?animations:Array<String>, ?scrollX:Float, ?scrollY:Float) {
        super(x, y);

        this.animated = animated;
        this.key = key;
        
        if (animations != null) {
            
        } else {
            loadGraphic(Paths.image(key));
        }
    }
}