package backend;

import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

@:structInit class DataVariables {
    public var downScroll:Bool = false;
    public var ghostTapping:Bool = false;
    public var flashingLights:Bool = true;
    public var cameraZoom:Bool = true;
    public var unfocusPause:Bool = true;
    public var globalAntialiasing:Bool = true;
    public var maxFramerate:Int = 60;
}

class FunkinData {
    public static var data:DataVariables;

    public function loadData() {
        Reflect;
    }

    public function setDataValue(data:String, value:Dynamic) {
        Reflect.setProperty(FlxG.save.data, data, value);
    }
}