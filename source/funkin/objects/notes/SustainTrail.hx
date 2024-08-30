package funkin.objects.notes;

import flixel.graphics.tile.FlxDrawTrianglesItem.DrawData;
import flixel.FlxStrip;

// somewhat based off base fnf sustain trail
class SustainTrail extends FlxStrip implements NoteBasic {
    public var strumTime:Float = 0; // The time the note will appear on the strum line

    public var noteType:String = ''; // The name of the note type (Nothing for default)
    public var noteTypeID:Int = 0; // The ID of the note type (0 is default)
    public var noteSkin:NoteSkin; // Self explanatory, note type skin overrides this
    public var noteData:Direction = 0; // 0 = Left, 1 = Down, 2 = Up, 3 = Right, can add more in NoteData
    public var strumLine:StrumLine; // The strum line the note is assigned to
    public var parentNote:NoteNew; // The note the sustain trail belongs to

    public var sustainLength(default, set):Float = 0; // The length of the sustain
    
    // loadGraphic(Paths.image(noteSkin.extraPaths[0]), true, noteSkin.extraData[2], noteSkin.extraData[3]);

    public function new(strumLine:StrumLine, noteData:Int, sustainLength:Float) {
        super();

        this.strumLine = strumLine;
        this.noteData = noteData;
        this.sustainLength = sustainLength;

		alpha = FunkinData.data.get('sustainAlpha');
    }

    function set_sustainLength(s:Float):Float {
        if (s < 0.0) s = 0.0;

        if (sustainLength == s) return s;
        this.sustainLength = s;
        refresh();
        return this.sustainLength;
    }

    public static inline function susHeight(length:Float, scroll:Float)
        return (length * 0.45 * scroll);

    function refresh() {
        var scroll:Float = strumLine.scrollSpeed;
        height = susHeight(sustainLength, scroll != null ? scroll : 1.0);
    }

    function updateClipping() {

    }
}