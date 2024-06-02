package backend;

import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxSave;

class FunkinData {
    public static var save:FlxSave; // probably not the best way of going about this but eh
    public static var data:Map<String, Dynamic>;
    public static var dataDefault:Map<String, Dynamic> = [
        'downScroll' => false,
        'ghostTapping' => false,
        'flashingLights' => true,
        'cameraZoom' => true,
        'unfocusPause' => true,
        'globalAntialiasing' => true,
        'maxFramerate' => 60
    ];

    public static function initialize() {
        save = new FlxSave();
        save.bind('prototype', 'fyridev');
        data = dataDefault;
        loadData();
    }

    public static function loadData() {
        for (key => value in data) {
            if (Reflect.getProperty(save.data, key) == null) {
                Reflect.setProperty(save.data, key, value);
            } else {
                data[key] = Reflect.getProperty(save.data, key);
            }
        }
    }

    public static function saveData() {
        for (key => value in data) {
            Reflect.setProperty(save.data, key, value);
        }
    }

    public static function setToDefault() {
        for (key => value in dataDefault) {
            Reflect.setProperty(save.data, key, value);
        }
        data = dataDefault;
    }
}