package backend;

import flixel.util.FlxGradient;

class StateTransition extends MusicBeatSubstate {
	public static var transitionCallback:Void->Void = null;
	public var transTime:Float;
	public var transIn:Bool;
	public var nextState:FlxState = null;
	var gradient:FlxSprite;
	var graphic:FlxSprite;

	public function new(transTime:Float, transIn:Bool, ?nextState:FlxState = null) {
		this.transTime = transTime;
		this.transIn = transIn;
		this.nextState = nextState;
		super();
	}

	override function create() {
		gradient = new FlxGradient().createGradientFlxSprite(FlxG.width, FlxG.height, (transIn ? [0x0, FlxColor.BLACK] : [FlxColor.BLACK, 0x0]));
		gradient.y = -gradient.height;
		add(gradient);

		graphic = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height * 2, FlxColor.BLACK);
		graphic.y = -graphic.height - gradient.height;
		add(graphic);

		if (transIn) {
			graphic.y = -FlxG.height;
			gradient.y = -gradient.height - graphic.height;
		}

		startTransition();
	}

	public function startTransition() {
		if (transIn) {
			FlxTween.tween(graphic, {y: FlxG.height - graphic.height}, transTime);
			FlxTween.tween(gradient, {y: FlxG.height}, transTime, {onComplete: function(t) {
				if (transitionCallback != null) transitionCallback();
				if (nextState != null) FlxG.switchState(nextState);
			}});
		} else {
			FlxTween.tween(graphic, {y: FlxG.height}, transTime);
			FlxTween.tween(gradient, {y: -gradient.height}, transTime, {onComplete: function(t) {
				if (transitionCallback != null) transitionCallback();
				if (nextState != null) FlxG.switchState(nextState);
			}});
		}
	}
}