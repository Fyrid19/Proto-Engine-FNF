package backend.framerate;

import openfl.Assets;
import openfl.display.Sprite;

class FullFPS extends Sprite {
    public static var fpsFont:String;

    public function new() {
        super();

        fpsFont = Assets.getFont(Main.globalFont).fontName;
    }
}