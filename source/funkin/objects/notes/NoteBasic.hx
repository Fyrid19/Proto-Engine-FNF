package funkin.objects.notes;

interface NoteBasic {
    public var strumTime:Float;
    public var noteType:String;
    public var noteTypeID:Int;
    public var noteDirection:Direction;
    public var strumLine:StrumLine;
    public var noteSkin:NoteSkin;
}