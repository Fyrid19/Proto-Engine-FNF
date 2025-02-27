package funkin.game.objects;

import flixel.math.FlxPoint;

class Character extends FlxSprite {
    public var animOffsets:Map<String, FlxPoint>;
    public var debugMode:Bool = false;

    public var isPlayer:Bool = false;
    public var curCharacter:String = 'bf';

    public var dancingChar:Bool = false;
    public var danced:Bool = false;

    public function new(x:Float, y:Float, charName:String = 'bf', ?isPlayer:Bool = false) {
        
    }

    public function addAnim(animName:String, animPrefix:String, ?fps:Int = 24, ?looped:Bool = false) {
		animation.addByPrefix(animName, animPrefix, fps, looped);
    }

    public function playAnim(name:String, force:Bool = false, reversed:Bool = false, frame:Int = 0) {
        animation.play(name, force, reversed, frame);

        var daOffset = animOffsets.get(name);
        if (animOffsets.exists(name)) {
            offset.set(daOffset.x, daOffset.y);
        } else offset.set(0, 0);
    }

    public function dance() {
        danced = !danced;
    }
}

typedef CharacterFile = {
    var name:String;
    var spritesheets:Array<String>;
    var animations:Array<Dynamic>;
}