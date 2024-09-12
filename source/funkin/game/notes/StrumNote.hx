package funkin.game.notes;

import flixel.graphics.frames.FlxFrame;

class StrumNote extends FlxSprite {
    public var noteSkin:NoteSkin;
    public function new(dir:Direction) {
        super();

        // snatched from note thing
        noteSkin.parse();
        var curStage:String = PlayState.curStage;
        if (curStage.startsWith('school')) {
            noteSkin.jsonPath = Paths.noteSkin('pixel'); // so i can softcode later
            noteSkin.path = 'weeb/pixelUI/arrows-pixels';
            noteSkin.extraPaths[0] = 'weeb/pixelUI/arrowEnds';
            noteSkin.extraData = [17, 17, 7, 6, PlayState.daPixelZoom]; // width, height, sustain width, sustain height, zoom
            noteSkin.atlasIncluded = false;
            noteSkin.antialiasing = false;
        }
        
        antialiasing = noteSkin.antialiasing;

        frames = Paths.getAtlas('NOTE_assets');

        if (noteSkin.atlasIncluded) {

        } else {
            animation.add('static', [0 + dir]);
            animation.add('pressed', [4 + dir, 8 + dir], 12, false);
            animation.add('confirm', [12 + dir, 16 + dir], 24, false);
        }
    }
}