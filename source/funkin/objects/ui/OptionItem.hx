package funkin.objects.ui;

import flixel.group.FlxSpriteGroup;
import flixel.addons.display.FlxSliceSprite;
import flixel.math.FlxRect;

class OptionItem extends FlxSpriteGroup {
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
}