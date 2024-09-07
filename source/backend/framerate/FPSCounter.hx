package backend.framerate;

import haxe.Timer;
import openfl.text.TextField;
import openfl.display.Sprite;
import openfl.text.TextFormat;
import backend.framerate.FullFPS;

import openfl.system.System;

class FPSCounter extends Sprite {
	public var fpsCountTxt:StrokedTextField;
	public var fpsLabelTxt:StrokedTextField;

	private var times:Array<Float>;

    public function new() {
        super();

		fpsCountTxt = new StrokedTextField(FullFPS.fpsFontBytes);
		fpsLabelTxt = new StrokedTextField(FullFPS.fpsFontBytes);

        var col:Array<UInt> = FullFPS.fpsColors;
		var alp:Array<Float> = [1, 1];
		var rat:Array<Int> = [255, 255];
		var mtx:Matrix = new Matrix();
		mtx.createGradientBox(400, 125, Math.PI / 2, 0, 0);

		for(text in [fpsCountTxt, fpsLabelTxt]) {
            addChild(text);
			text.lineStyle(4, 0x000000);
			text.gradientFill(GradientType.LINEAR, col, alp, rat, mtx, SpreadMethod.PAD);
			text.fontSize = 14;
            // text.update();
		}

		fpsCountTxt.fontSize = 18;
		fpsLabelTxt.fontSize = 14;
		fpsLabelTxt.text = "FPS";

		fpsCountTxt.update();
		fpsLabelTxt.update();

		times = [];
    }

	public override function __enterFrame(delta:Int) {
		var now = Timer.stamp();
		times.push(now);

		while (times[0] < now - 1)
			times.shift();

		var curFPS:Float;
		curFPS = times.length;

		fpsCountTxt.text = Std.string(curFPS);
		fpsLabelTxt.x = fpsCountTxt.x + fpsCountTxt.width;
		fpsLabelTxt.y = fpsCountTxt.y + fpsCountTxt.height - fpsLabelTxt.height;
	}
}