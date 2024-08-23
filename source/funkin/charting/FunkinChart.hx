package funkin.charting;

typedef ChartData = {
    public var playerChar:String;
    public var opponentChar:String;
    public var events:Array<DebugNote>; // placeholder, no events yet
    public var notes:Array<DebugNote>;
    public var stage:String;
    public var scrollSpeed:Float;
    public var meta:ChartMetaData;
    public var protoChart:Bool;
}

typedef ChartMetaData = {
    public var name:String;
    public var songName:String;
    public var bpm:Float;
    public var needsVoices:Bool;
    public var icon:String;
    public var freeplayColor:String;
    public var difficulties:Array<String>;
}

typedef ChartNote = {
    public var time:Float; // note time
    public var data:Int; // note direction (0-3)
    public var type:Int; // note type id
    public var sustain:Float; // sustain length
}