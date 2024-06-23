package backend.framerate;

import openfl.Assets;
import openfl.display.Sprite;
import backend.framerate.FPSCounter;
import backend.framerate.MemoryCounter;
import backend.framerate.EngineWatermark;

class FullFPS extends Sprite {
    public static var fpsFont:String;

    public var fpsCount:FPSCounter;
    public var memCount:MemoryCounter;
    public var watermark:EngineWatermark;

    var offset:Array<Float> = [2, 2];

    public function new() {
        super();

        fpsFont = Assets.getFont('assets/fonts/vcr.ttf').fontName;

        fpsCount = new FPSCounter();
        memCount = new MemoryCounter();
        watermark = new EngineWatermark();

        memCount.y = fpsCount.y + fpsCount.height + 2;
        watermark.y = fpsCount.y + fpsCount.height + memCount.height + watermark.height;

        addChild(fpsCount);
        addChild(memCount);
        addChild(watermark);

        x = offset[0];
        y = offset[1];
    }
}