package backend.music;

import flixel.addons.transition.FlxTransitionableState;
import backend.interfaces.IMusicBeat;

/**
 * FlxTransitionableState with Music Beat properties.
 */
class MusicBeatState extends FlxTransitionableState implements IMusicBeat {
    public var curStep:Int = 0;
    public var curBeat:Int = 0;
    public var curMeasure:Int = 0;

    public function new() {
        super();
    }
    
    override function create() {
        super.create();
        
        Conductor.onStepHit.add(stepHit);
        Conductor.onBeatHit.add(beatHit);
        Conductor.onMeasureHit.add(measureHit);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        curStep = Conductor.curStep;
        curBeat = Conductor.curBeat;
        curMeasure = Conductor.curMeasure;
    }

    public function stepHit() {}
    public function beatHit() {}
    public function measureHit() {}
}