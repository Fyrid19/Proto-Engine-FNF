package backend.framerate;

import openfl.Assets;
import openfl.display.Sprite;
import openfl.utils.ByteArray;
import backend.framerate.FPSCounter;
import backend.framerate.MemoryCounter;
import backend.framerate.EngineWatermark;

class FullFPS extends Sprite {
    public static var fpsFont:String;
    public static var fpsFontBytes:ByteArray;
    
    public static var fpsColors:Array<UInt> = [0xFFFFFF, 0xFFFFFF];

    public var fpsCount:FPSCounter;
    public var memCount:MemoryCounter;
    public var watermark:EngineWatermark;

    var offset:Array<Float> = [2, 2];

    public function new() {
        super();

        fpsFont = Assets.getFont(Paths.font('nokia.ttf')).fontName;
        fpsFontBytes = Assets.getBytes(Paths.font('nokia.ttf'));

        fpsCount = new FPSCounter();
        memCount = new MemoryCounter();
        watermark = new EngineWatermark();

        memCount.y = fpsCount.y + fpsCount.height + 2;
        watermark.y = memCount.y + memCount.height + fpsCount.height - 3;

        addChild(fpsCount);
        addChild(memCount);
        addChild(watermark);

        x = offset[0];
        y = offset[1];
    }
}