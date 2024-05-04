package backend.framerate;

import openfl.Assets;
import openfl.display.Sprite;
import backend.framerate.FPSCounter;
import backend.framerate.MemoryCounter;

class FullFPS extends Sprite {
    public var fpsFont:String = Assets.getFont('assets/fonts/vcr.ttf').fontName;

    public var fpsCount:FPSCounter;
    public var memCount:MemoryCounter;

    var offset:Array<Float> = [10, 10];

    public function new() {
        super();

        fpsCount = new FPSCounter();
        memCount = new MemoryCounter();

        fpsCount.y = memCount.y + memCount.height + 5;

        addChild(fpsCount);
        addChild(memCount);

        x = offset[0];
        y = offset[1];
    }
}