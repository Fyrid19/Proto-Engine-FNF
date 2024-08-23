package funkin.objects.notes;

interface NoteBasic {
    public var strumTime:Float; 
    public var noteType:String; 
    public var noteTypeID:Int; 
    public var noteSkin:NoteSkin; 
    public var noteData:Direction; 
    public var strumLine:StrumLine; 
}