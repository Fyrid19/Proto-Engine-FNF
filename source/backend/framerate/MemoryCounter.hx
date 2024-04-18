package backend.framerate;

import openfl.text.TextField;
import openfl.display.Sprite;
import openfl.text.TextFormat;

import openfl.system.System;

class MemoryCounter extends Sprite {
	public var memCountTxt:TextField;
	public var memPeakTxt:TextField;

    private var memPeak:Float = 0;

    public function new() {
        super();

		memCountTxt = new TextField();
        memPeakTxt = new TextField();

        for(text in [memCountTxt, memPeakTxt]) {
			text.x = 0;
			text.y = 0;
			text.text = "";
			text.autoSize = LEFT;
			text.multiline = false;
            text.defaultTextFormat = new TextFormat(FullFPS.fpsFont, 14, 0xFFFFFF);
			addChild(text);
		}
    }

	public override function __enterFrame(delta:Int) {
        var mem:Float = Math.round(System.totalMemory / 1024 / 1024 * 100)/100;
		if (mem > memPeak) memPeak = mem;

        memCountTxt.text = 'Memory: ' + FunkinUtil.formatMemory(mem);
        memPeakTxt.text = ' | Peak: ' + FunkinUtil.formatMemory(memPeak);

        memPeakTxt.y = memCountTxt.y;
        memPeakTxt.x = memCountTxt.width + memCountTxt.x;
    }
}