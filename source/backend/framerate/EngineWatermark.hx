package backend.framerate;

import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;

class EngineWatermark extends Sprite {
    var watermarkTxt:StrokedTextField;
    var commitTxt:StrokedTextField;
    public function new() {
        super();

        watermarkTxt = new StrokedTextField(FullFPS.fpsFontBytes);
        commitTxt = new StrokedTextField(FullFPS.fpsFontBytes);

        var col:Array<UInt> = FullFPS.fpsColors;
		var alp:Array<Float> = [1, 1];
		var rat:Array<Int> = [255, 255];
		var mtx:Matrix = new Matrix();
		mtx.createGradientBox(400, 125, Math.PI / 2, 0, 0);

		for(text in [watermarkTxt, commitTxt]) {
            addChild(text);
			text.lineStyle(4, 0x000000);
			text.gradientFill(GradientType.LINEAR, col, alp, rat, mtx, SpreadMethod.PAD);
			text.fontSize = 14;
            // text.update();
		}

        watermarkTxt.text = 'Prototype Engine ' + EngineMain.engineVer;
        commitTxt.text = 'Commit ' + EngineMain.getRepoCommits();
        commitTxt.y = watermarkTxt.y + watermarkTxt.height;
    }
}