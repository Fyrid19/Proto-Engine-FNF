package funkin.states.options;

import flixel.group.FlxSpriteGroup;
import flixel.addons.display.FlxSliceSprite;
import flixel.math.FlxRect;

class OptionItem extends FlxSpriteGroup {
    public var option:Option;
    
	public var targetY:Float = 0;
	public var isMenuItem:Bool = false;

    var alphabet:Alphabet;
    var background:FlxSliceSprite;

    public function new(x:Float, y:Float, text:String) {
        super(x, y);

        alphabet = new Alphabet(0, 0, text, true);
        background = new FlxSliceSprite(Paths.image('options/optionbg'), new FlxRect(37, 1, 1, 37), alphabet.width, 75);

        alphabet.x = this.x;
        alphabet.y = this.y;

        background.x = alphabet.x - 20;
        background.y = alphabet.y + 20;
        
        add(background);
        add(alphabet);
    }

    override function update(elapsed:Float) {
        if (isMenuItem)
		{
			var scaledY = FlxMath.remapToRange(targetY, 0, 1, 0, 1.3);

			y = FlxMath.lerp(y, (scaledY * 120) + (FlxG.height * 0.60), 0.16);
			x = FlxMath.lerp(x, (targetY * 200) + 90, 0.16);
		}

		super.update(elapsed);
    }
}

class Option {
    var name:String;
    var description:String;
    var variable:String;
    var type:String; // String, Bool, Array, Dynamic

    public function new(name:String, description:String, variable:String, type:String) {
        this.name = name;
        this.description = description;
        this.variable = variable;
        this.type = type;
    }

    public function setVar(value:Dynamic) {
        FunkinData.data.set(variable, value);
    }
}