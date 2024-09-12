package funkin.game.stage;

class BGSprite extends FlxSprite {
    public var assetPath:String;
    public var animated:Bool;
    
    public function new(Asset:String, X:Float, Y:Float, ?Animated:Bool, ?ScrollX:Float, ?ScrollY:Float) {
        super(X, Y);
        
        if (!Asset.startsWith('assets/')) {
            
        }
    }
}