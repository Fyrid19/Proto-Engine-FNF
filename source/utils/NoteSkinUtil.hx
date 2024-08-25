package utils;

import funkin.objects.notes.NoteBasic;

@:structInit class NoteSkinParams {
    public var jsonPath:String;
    public var name:String;
    public var path:String;
    public var extraPaths:Array<String>;
    public var atlasIncluded:Bool;
    public var extraData:Array<Dynamic>;
}

class NoteSkinUtil {
    function setSkin(noteSkin:NoteSkin, isSustain:Bool, params:NoteSkinParams) {
        noteSkin.jsonPath = params.jsonPath;
        noteSkin.name = params.name;
        noteSkin.path = params.path;
        noteSkin.extraPaths = params.extraPaths;
        noteSkin.atlasIncluded = params.atlasIncluded;
        noteSkin.extraData = params.extraData;
        noteSkin.parse();
    }
}

class NoteSkin {
    public var jsonPath:String = '';
    public var name:String = 'Default';
    public var path:String = 'NOTE_assets';
    public var extraPaths:Array<String> = [''];
    public var atlasIncluded:Bool = false; // if true it'll load like the pixel notes
    public var extraData:Array<Dynamic> = []; // used for non-atlas skins (if it has atlas then its just extra)
    public function parse(?skinFile:String) {
        trace('parse noteskin file (should be json)');
    }
}