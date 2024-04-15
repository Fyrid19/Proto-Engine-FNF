package utils; // will work on later

class FunkinData {
    public static var downScroll:Data;
    public static var ghostTapping:Data;

    /* 
    * Meant to load preferences 
    */
    public static function loadData() { // this should work
        downScroll = new Data('downScroll', false);
        ghostTapping = new Data('ghostTapping', false);
    }

    public static function loadKeybinds() {

    }
}

class Data {
    public var dataTag:String;
    public var defaultValue:Dynamic;
    public var value:Dynamic;

    public function new(tag:String, defaultValue:Dynamic) {
        this.defaultValue = defaultValue;
        this.dataTag = tag;
        saveValue();
    }

    public function changeValue(newValue:Dynamic) {
        this.value = newValue;
        saveValue();
    }

    public function changeToDefault() {
        this.value = this.defaultValue;
        saveValue();
    }

    public function saveValue() {
        Reflect.setProperty(FlxG.save.data, this.dataTag, this.defaultValue);
    }
}