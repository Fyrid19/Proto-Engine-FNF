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

    // FlxStrip triangle shit
    private static final noteUV:Array<Float> = [
        0,0, //top left
        1,0, //top right
        0,0.5, //half left
        1,0.5, //half right    
        0,1, //bottom left
        1,1, //bottom right 
    ];
    private static final noteIndices:Array<Int> = [
        0,1,2,1,3,2, 2,3,4,3,4,5
        //makes 4 triangles
    ];

    public function new(strumLine:StrumLine, noteData:Int, sustainLength:Float) {
        super();

        this.strumLine = strumLine;
        this.noteData = noteData;
        this.sustainLength = sustainLength;

		alpha = FunkinData.data.get('sustainAlpha');

        for (uv in noteUV) {
            uvtData.push(uv);
            vertices.push(0);
        }
        for (ind in noteIndices)
            indices.push(ind);
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