package funkin.modding;

import polymod.Polymod;
import polymod.util.zip.ZipParser;

import flixel.util.FlxSave;

// ill do more with this later
class Mod {
    var name:String;
    var desc:String;
    var path:String;
    var data:FlxSave = null;

    public function new(name:String, desc:String) {
        this.name = name;
        this.desc = desc;
        path = 'mods/' + name;
    }

    public function setData(data:String, value:Dynamic) {
        Reflect.setProperty(this.data, data, value);
    }
}