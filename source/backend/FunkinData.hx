package backend;

import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

class FunkinData {
    public static var save:FlxSave;
    public static var dataVars:Map<String, Dynamic> = [
        'downScroll' => false,
        'ghostTapping' => false,
        'flashingLights' => true,
        'cameraZoom' => true,
        'unfocusPause' => true,
        'globalAntialiasing' => true,
        'maxFramerate' => 60
    ];

    public static var dataVarsCopy:Map;

    public function initialize() {
        save = new FlxSave();
        save.save.bind('prototype', 'fyridev');

        dataVarsCopy = dataVars;
    }

    public function loadData() {
        var nullData:Bool = false;
        for (key => value in dataVars) {
            if (Reflect.getProperty(save.data, key) == null && !nullData) {
                nullData = true;
            }

            if (nullData) {
                Reflect.setProperty(save.data, key, value);
            } else {
                dataVars[key] = Reflect.getProperty(save.data, key);
            }
        }
    }

    public function saveData() {
        for (key => value in dataVars) {
            Reflect.setProperty(save.data, key, value);
        }
    }

    public function setToDefault() {
        for (key => value in dataVarsCopy) {
            Reflect.setProperty(save.data, key, value);
        }

        dataVars = dataVarsCopy;
    }
}