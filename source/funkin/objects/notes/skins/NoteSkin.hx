package funkin.objects.notes.skins;

class NoteSkin {
    public var skinName:String;
    public var displayName:String;
    public var assetPath:String;

    public function new(skinName:String, displayName:String, assetPath:String) {
        this.skinName = skinName;
        this.displayName = displayName;
        this.assetPath = assetPath;
    }
}