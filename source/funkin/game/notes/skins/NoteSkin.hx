package funkin.game.notes.skins;

class NoteSkin {
    public var skinName:String;
    public var displayName:String;
    public var path:String;

    public function new(path:String, skinName:String, ?displayName:String) {
        this.skinName = skinName;
        this.displayName = displayName != null ? displayName : skinName;
        this.path = path;
    }
}