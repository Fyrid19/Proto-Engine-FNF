package backend.music;

import flixel.FlxSubState;
import backend.interfaces.IMusicBeat;

/**
 * FlxSubState with Music Beat properties.
 */
class MusicBeatSubState extends FlxSubState implements IMusicBeat {
    public var curStep:Int = 0;
    public var curBeat:Int = 0;
    public var curMeasure:Int = 0;

    public var pauseState:Bool;

    public function new(?pauseState:Bool = false) {
        super();
        this.pauseState = pauseState;
    }
    
    override function create() {
        super.create();
        
        Conductor.onStepHit.add(stepHit);
        Conductor.onBeatHit.add(beatHit);
        Conductor.onMeasureHit.add(measureHit);

        if (pauseState)
            FlxG.camera.followLerp = 0;
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        curStep = Conductor.curStep;
        curBeat = Conductor.curBeat;
        curMeasure = Conductor.curMeasure;
    }

    override function close() {
        super.close();

        if (pauseState)
            FlxG.camera.followLerp = Globals.CAMERA_LERP;
    }

    public function stepHit() {}
    public function beatHit() {}
    public function measureHit() {}
}