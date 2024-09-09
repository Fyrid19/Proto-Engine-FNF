package backend.framerate;

import openfl.text.TextField;
import openfl.display.Sprite;
import openfl.text.TextFormat;
import openfl.system.System;

class MemoryCounter extends Sprite {
	public var memText:TextField;
    public function new() {
        super();

		memText = new TextField();
        memText.text = "";
        memText.autoSize = LEFT;
        memText.multiline = false;
        memText.defaultTextFormat = new TextFormat(FullFPS.fpsFont, 10, 0xFFFFFF);
        addChild(memText);
    }

    private var memPeak:Float = 0;
	public override function __enterFrame(delta:Int) {
        var mem:Float = cpp.vm.Gc.memInfo64(cpp.vm.Gc.MEM_INFO_USAGE);
        if (mem > memPeak) memPeak = mem;

        memText.text = 'Memory: ' + FunkinUtil.formatMemory(mem) + ' / ' + FunkinUtil.formatMemory(memPeak);
    }
}