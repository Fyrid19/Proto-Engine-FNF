package funkin.game.notes;

class NoteNew extends FlxSprite {
    public var strumTime:Float = 0; // The time the note will appear on the strum line

    public var noteType:String = ''; // The name of the note type (Nothing for default)
    public var noteTypeID:Int = 0; // The ID of the note type (0 is default)
    public var noteSkin:NoteSkin; // Self explanatory, note type skin overrides this
    public var noteDirection:Direction = 0; // 0 = Left, 1 = Down, 2 = Up, 3 = Right, can add more in NoteData
    public var strumLine:StrumLine; // The strum line the note is assigned to

    public var hasSustain:Bool; // If the note has a sustain trail or not
    public var sustainLength:Float = 0; // Length of the note sustain

    public var scoreMulti:Float = 1; // Note score multiplier
    
    public var playerNote:Bool = false; // Determines if the note is supposed to be hit by the player
	public var canBeHit:Bool = false; // Determines if the player can hit the note or not
	public var tooLate:Bool = false; // If the note isn't hit in time
    public var tooEarly:Bool = false; // If the note is hit too early
	public var wasGoodHit:Bool = false; // If you hit the note good enough to count
    private var willMiss:Bool = false; // If you miss this will go off so you really miss

    public static var swagWidth:Float = 160 * 0.7; // Used for positioning the note

    public function new(strumTime:Float, noteDirection:Direction, ?hasSustain:Bool = false, ?noteType:Int = 0, strumLine:StrumLine) {
        super();

		x += 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;

		this.hasSustain = hasSustain;
		this.strumTime = strumTime;
		this.noteDirection = noteDirection;
        this.strumLine = strumLine;

        // insert stupid hscript BULLSHIT.

        x += swagWidth * noteDirection;
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (playerNote) {
            if (willMiss && !wasGoodHit) {
				tooLate = true;
				canBeHit = false;
			} else {
				if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset) {
                    // The * 0.5 is so that it's easier to hit them too late, instead of too early
					if (strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
						canBeHit = true;
				} else {
					canBeHit = true;
					willMiss = true;
				}
			}
        } else {
            canBeHit = false;

            if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
        }

        if (tooLate) {
            if (alpha > 0.3) alpha = 0.3;
        }
    }
}