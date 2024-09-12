package funkin.game.song;

import flixel.sound.FlxSound;

class SongGroup {
    public var inst:FlxSound;
    public var voices:Array<FlxSound>;

    public function new(song:String, ?difficulty:String, ?voiceSuffixes:Array<String>) {
        inst = new FlxSound().loadEmbedded(Paths.inst(song, difficulty));
        voices = new Array<FlxSound>();

        voices = [];
        for (i in 0...voiceSuffixes.length) {
            var vocalTrack:FlxSound = new FlxSound().loadEmbedded(Paths.voices(song, voiceSuffixes[i], difficulty));
            voices.push(vocalTrack);
        }
    }

    // is supposed to prevent that weird audio bug
    // but then again just make your inst and voices the same length
    public function update() {
        if (inst != null && voices != null) {
            for (i in 0...voices.length) {
                if (inst.time > voices[i].length) {
                    voices[i].destroy(); 
                }
            }
        }
    }

    public function play() {
        if (inst != null) inst.play();
        if (voices != null) for (i in 0...voices.length) {
            voices[i].play();
        }
    }

    public function syncVoices() {
        if (voices != null && inst != null) for (i in 0...voices.length) {
            voices[i].time = inst.time;
        }
    }
}