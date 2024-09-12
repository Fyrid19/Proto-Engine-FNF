package funkin.game.notes;

import funkin.game.notes.NoteNew as Note;
import funkin.game.notes.SustainTrail;
import flixel.util.FlxSort;

class StrumLine extends FlxSpriteGroup {
    public var scrollSpeed:Float;
    public var playerStrum:Bool;
    public var downScroll:Bool;
    
    public var unspawnNotes:Array<NoteBasic>;

    public function new(scrollSpeed:Float = 1.0, playerStrum:Bool = false, ?downScroll:Bool) {
        super();
        
        this.scrollSpeed = scrollSpeed;
        this.playerStrum = playerStrum;
        this.downScroll = downScroll != null ? downScroll : FunkinData.data.get('downScroll');
        
        unspawnNotes = new Array<NoteBasic>();

        for (i in 0...3) {
            var strumNote:StrumNote;
        }
    }

    public function addNotes(notes:Array<Note>) {
        for (note in notes) { // this is just to make sure none of the data is like fucked up or smth
            var strumTime:Float = note.strumTime;
            var noteDirection:Direction = note.noteDirection;
            var playerNote:Bool = note.playerNote;
            var hasSustain:Bool = note.hasSustain;
            var sustainLength:Float = note.sustainLength;
            var noteType:Int = note.noteTypeID;

            // player note? in MY cpu strum?
            // im the old strum, i want normal notes!
            if (playerNote != playerStrum) playerNote = playerStrum;

            // cant have a sustain note with no length
            if (hasSustain && sustainLength == 0) hasSustain = false;
            sustainLength = sustainLength / Conductor.stepCrochet;

            // not sure if this causes like memory leaks or anything
            var newNote:Note = new Note(strumTime, noteDirection, hasSustain, noteType, this);
            newNote.scrollFactor.set();
            unspawnNotes.push(newNote);
        }
    }

    public function playAnim(dir:Direction) {
        
    }
}