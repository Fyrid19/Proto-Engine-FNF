package backend.framerate;

import openfl.text.TextField;
import openfl.text.TextFormat;

class EngineWatermark extends TextField {
    public function new() {
        super();
        autoSize = LEFT;
        multiline = false;
        defaultTextFormat = new TextFormat(FullFPS.fpsFont, 14, 0xFFFFFF);
        text = 'Prototype Engine INDEV ALPHA';
    }
}