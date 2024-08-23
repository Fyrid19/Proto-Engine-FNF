package funkin.objects.notes;

class NoteNew extends FlxSprite implements NoteBasic {
    public var strumTime:Float = 0; // The time the note will appear on the strum line

    public var noteType:String = ''; // The name of the note type (Nothing for default)
    public var noteTypeID:Int = 0; // The ID of the note type (0 is default)
    public var noteSkin:NoteSkin; // Self explanatory, note type skin overrides this
    public var noteData:Direction = 0; // 0 = Left, 1 = Down, 2 = Up, 3 = Right, can add more in NoteData
    public var strumLine:StrumLine; // The strum line the note is assigned to

    public var hasSustain:Bool; // If the note has a sustain trail or not
    public var sustinLength:Float = 0; // Length of the note sustain

    public var scoreMulti:Float = 1; // Note score multiplier
    
    public var playerNote:Bool = false; // Determines if the note is supposed to be hit by the player
	public var canBeHit:Bool = false; // Determines if the player can hit the note or not
	public var tooLate:Bool = false; // If the note isn't hit in time
    public var tooEarly:Bool = false; // If the note is hit too early
	public var wasGoodHit:Bool = false; // If you hit the note good enough to count
    private var willMiss:Bool = false; // If you miss this will go off so you really miss

    public static var swagWidth:Float = 160 * 0.7; // Used for positioning the note

    public function new(strumTime:Float, noteData:Int, ?hasSustain:Bool = false, ?noteType:Int = 0, strumLine:StrumLine) {
        super();

		x += 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;

		this.hasSustain = hasSustain;
		this.strumTime = strumTime;
		this.noteData = noteData;
        this.strumLine = strumLine;
        noteSkin.parse();

        var curStage:String = PlayState.curStage;
        if (curStage == 'school' || curStage == 'schoolEvil') {
            noteSkin.path = 'weeb/pixelUI/arrows-pixels';
            noteSkin.extraPaths[0] = 'weeb/pixelUI/arrowEnds';
            noteSkin.extraData = [17, 17, 7, 6, PlayState.daPixelZoom]; // width, height, sustain width, sustain height, zoom
            noteSkin.atlasIncluded = false;
        }

        if (noteSkin.atlasIncluded) {
            frames = Paths.getSparrowAtlas(noteSkin.path);

            animation.addByPrefix('greenScroll', 'green instance');
            animation.addByPrefix('redScroll', 'red instance');
            animation.addByPrefix('blueScroll', 'blue instance');
            animation.addByPrefix('purpleScroll', 'purple instance');

            animation.addByPrefix('purpleholdend', 'pruple end hold');
            animation.addByPrefix('greenholdend', 'green hold end');
            animation.addByPrefix('redholdend', 'red hold end');
            animation.addByPrefix('blueholdend', 'blue hold end');

            animation.addByPrefix('purplehold', 'purple hold piece');
            animation.addByPrefix('greenhold', 'green hold piece');
            animation.addByPrefix('redhold', 'red hold piece');
            animation.addByPrefix('bluehold', 'blue hold piece');

            setGraphicSize(Std.int(width * 0.7));
            updateHitbox();
            antialiasing = true;
        } else {
            loadGraphic(Paths.image(noteSkin.path), true, noteSkin.extraData[0], noteSkin.extraData[1]);

            animation.add('greenScroll', [6]);
            animation.add('redScroll', [7]);
            animation.add('blueScroll', [5]);
            animation.add('purpleScroll', [4]);

            if (hasSustain) {
                loadGraphic(Paths.image(noteSkin.extraPaths[0]), true, noteSkin.extraData[2], noteSkin.extraData[3]);

                animation.add('purpleholdend', [4]);
                animation.add('greenholdend', [6]);
                animation.add('redholdend', [7]);
                animation.add('blueholdend', [5]);

                animation.add('purplehold', [0]);
                animation.add('greenhold', [2]);
                animation.add('redhold', [3]);
                animation.add('bluehold', [1]);
            }

            setGraphicSize(Std.int(width * noteSkin.extraData[4]));
            updateHitbox();
        }

        switch (noteData) {
			case 0:
				x += swagWidth * 0;
				animation.play('purpleScroll');
			case 1:
				x += swagWidth * 1;
				animation.play('blueScroll');
			case 2:
				x += swagWidth * 2;
				animation.play('greenScroll');
			case 3:
				x += swagWidth * 3;
				animation.play('redScroll');
		}
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