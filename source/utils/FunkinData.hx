package utils;

class FunkinData {
    public static var downScroll:Data;
    public static var ghostTapping:Data;

    public static function loadData() {
        downScroll = new Data('downScroll', false);
        ghostTapping = new Data('ghostTapping', false);
    }

    public static var playerControls:Controls;

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
        init();
    }

    private function init() {
        var saveValue:Dynamic;
        saveValue = Reflect.getProperty(FlxG.save.data, this.dataTag);

        if (saveValue != null) {
            this.value = saveValue;
        } else {
            this.value = this.defaultValue;
            saveValue();
        }
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

    public function getValue() {
        var curValue:Dynamic;
        curValue = Reflect.getProperty(FlxG.save.data, this.dataTag);
        return curValue;
    }
}