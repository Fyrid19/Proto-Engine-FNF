package backend;

import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

@:structInit class DataVariables {
    public static var downScroll:Bool = false;
    public static var ghostTapping:Bool = false;
    public static var flashingLights:Bool = true;
    public static var cameraZoom:Bool = true;
    public static var unfocusPause:Bool = true;
    public static var globalAntialiasing:Bool = true;
    public static var maxFramerate:Int = 60;
}

class FunkinData {
    public function loadData() {
        for (key => value in defaultValues) {
            Reflect.setProperty(FlxG.save.data, key, value);
        }
    }

    public function setDataValue(data:String, value:Dynamic) {
        Reflect.setProperty(FlxG.save.data, data, value);
    }
}