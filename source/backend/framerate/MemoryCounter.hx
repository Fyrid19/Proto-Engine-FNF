package backend.framerate;

import openfl.text.TextField;
import openfl.display.Sprite;
import openfl.text.TextFormat;
import openfl.system.System;

class MemoryCounter extends Sprite {
	public var memText:StrokedTextField;
    public function new() {
        super();

        memText = new StrokedTextField(FullFPS.fpsFontBytes);
		addChild(memText);
		memText.lineStyle(4, 0x000000);

		var col:Array<UInt> = FullFPS.fpsColors;
		var alp:Array<Float> = [1, 1];
		var rat:Array<Int> = [255, 255];
		var mtx:Matrix = new Matrix();
		mtx.createGradientBox(400, 125, Math.PI / 2, 0, 0);

		memText.gradientFill(GradientType.LINEAR, col, alp, rat, mtx, SpreadMethod.PAD);

		memText.fontSize = 14;
		memText.mode = "outline";
    }

    private var memPeak:Float = 0;
	public override function __enterFrame(delta:Int) {
        var mem:Float = cpp.vm.Gc.memInfo64(cpp.vm.Gc.MEM_INFO_USAGE);
        if (mem > memPeak) memPeak = mem;

        memText.text = 'Memory: ' + FunkinUtil.formatMemory(mem) + ' / ' + FunkinUtil.formatMemory(memPeak);
    }
}