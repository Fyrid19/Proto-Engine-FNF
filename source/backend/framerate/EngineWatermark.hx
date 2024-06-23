package backend.framerate;

import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;

class EngineWatermark extends Sprite {
    var _text:TextField;
    public function new() {
        super();

        _text = new TextField();
        _text.autoSize = LEFT;
        _text.multiline = false;
        _text.defaultTextFormat = new TextFormat(FullFPS.fpsFont, 14, 0xFFFFFF);
        _text.text = 'Prototype Engine ' + Main.engineVersion;
        addChild(_text);
    }
}