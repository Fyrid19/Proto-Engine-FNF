package backend.interfaces;

/**
 * Interface that has functions related to the BPM.
 */
interface IMusicBeat {
    public function stepHit():Void;
    public function beatHit():Void;
    public function measureHit():Void;
}