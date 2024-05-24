package backend;

import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

class FunkinData {
    public static var dataVars:Map<String, Dynamic> = [
        'downScroll' => false,
        'ghostTapping' => false,
        'flashingLights' => true,
        'cameraZoom' => true,
        'unfocusPause' => true,
        'globalAntialiasing' => true,
        'maxFramerate' => 60
    ];

    public function loadData() {
        var nullData:Bool = false;
        for (key => value in dataVars) {
            if (Reflect.getProperty(FlxG.save.data, key) == null && !nullData) {
                nullData = true;
            }

            if (nullData) {
                Reflect.setProperty(FlxG.save.data, key, value);
            } else {
                dataVars[key] = Reflect.getProperty(FlxG.save.data, key);
            }
        }
    }

    public function saveData() {
        for (key => value in dataVars) {
            Reflect.setProperty(FlxG.save.data, key, value);
        }
    }
}