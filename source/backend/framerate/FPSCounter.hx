package backend.framerate;

import openfl.text.TextField;
import openfl.display.Sprite;
import openfl.text.TextFormat;

import flixel.system.debug.Stats;

class FPSCounter extends Sprite {
	public var fpsCounter:TextField;
	public var fpsLabel:TextField;

    public function new() {
        super();

		fpsCounter = new TextField();
		fpsLabel = new TextField();

		fpsCounter.text = "";
		fpsLabel.text = "FPS:";
    }

	public override function __enterFrame(delta:Int) {
		var curFPS:Float = Stats.currentFps(); // i do not know if this actually works because vshaxe is being stupid
		fpsCounter.text = curFPS;
	}
}