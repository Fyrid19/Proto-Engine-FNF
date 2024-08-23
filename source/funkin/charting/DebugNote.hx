package funkin.charting;

class DebugNote extends FlxSpriteGroup {
    public var time:Float;
    public var data:Int;
    public var type:Int;
    public var sustain:Float;

    public var noteSprite:FlxSprite;

    public function new(time:Float, data:Int, type:Int, ?sustain:Float = 0) {
        super();
        this.time = time;
        this.data = data;
        this.type = type;
        this.sustain = sustain;

        noteSprite = new FlxSprite();
        noteSprite.frames = Paths.getSparrowAtlas('NOTE_assets');
        for (i in 0...3)
            noteSprite.animation.addByPrefix('note' + i, returnNoteFrame(i));
        noteSprite.animation.play('note' + data);
        add(noteSprite);
    }

    function returnNoteFrame(data:Int):String {
        return switch (data) {
            case 0:
                'purple instance';
            case 1:
                'blue instance';
            case 2:
                'green instance';
            case 3:
                'red instance';
        }
    }
}