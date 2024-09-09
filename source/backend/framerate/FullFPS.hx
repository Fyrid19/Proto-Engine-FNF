package backend.framerate;

import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import backend.framerate.FPSCounter;
import backend.framerate.MemoryCounter;
import backend.framerate.EngineWatermark;

class FullFPS extends Sprite {
    public static var fpsFont:String;

    public var backGraphic:Bitmap;

    public var fpsCount:FPSCounter;
    public var memCount:MemoryCounter;
    public var watermark:EngineWatermark;

    var offset:Array<Float> = [2, 2];
    var boxBorder:Float = 2;

    public function new() {
        super();

        fpsFont = Assets.getFont(Paths.defaultFont).fontName;

        fpsCount = new FPSCounter();
        memCount = new MemoryCounter();
        watermark = new EngineWatermark();

        fpsCount.x = boxBorder;
        memCount.x = fpsCount.x;
        watermark.x = fpsCount.x;

        fpsCount.y = boxBorder;
        memCount.y = fpsCount.y + fpsCount.height + 2;
        watermark.y = memCount.y + memCount.height + fpsCount.height - 3;
        
        var _bitmap:BitmapData = new BitmapData(1, 1, false, 0x000000);
        backGraphic = new Bitmap(_bitmap);
        backGraphic.alpha = 0.6;

        addChild(backGraphic);
        addChild(fpsCount);
        addChild(memCount);
        addChild(watermark);

        x = offset[0];
        y = offset[1];
    }
    
	public override function __enterFrame(delta:Int) {
        fpsCount.__enterFrame(delta);
        memCount.__enterFrame(delta);

        backGraphic.scaleX = memCount.width + boxBorder + 4;
        backGraphic.scaleY = fpsCount.height + memCount.height + watermark.height + boxBorder + 4;
    }
}