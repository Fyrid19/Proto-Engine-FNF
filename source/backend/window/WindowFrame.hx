package backend.window;

import openfl.Lib;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.text.TextField;
import openfl.display.Sprite;
import openfl.text.TextFormat;

class WindowFrame extends Sprite { // might not even do this but we'll see
    public var tabGraphic:Bitmap;

    public function new() {
        super();

        var _bitmap:BitmapData = new BitmapData(Lib.current.stage.stageWidth, 32, false, 0x333333);
        tabGraphic = new Bitmap(_bitmap);
    }
}