package funkin.sound;

import flixel.sound.FlxSound;

@:structInit
class SoundParams {
    // Parameters
    var looped:Bool;
    var forceRestart:Bool;
    var partialParams:Array<Float>;
    var autoDestroy:Bool;
    var persist:Bool;

    // Callbacks
    var onComplete:Void->Void;
    var onStart:Void->Void;
    var onPause:Void->Void;
    var onResume:Void->Void;
}

/**
 * FlxSound with some extra features
 */
@:access(flixel.sound.FlxSound)
class FunkinSound {
    var _sound:FlxSound;

    public function play(path:String, params:SoundParams) {
        _sound = new FlxSound();
        _sound.play(params.forceRestart);
    }
}