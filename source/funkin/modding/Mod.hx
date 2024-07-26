package funkin.modding;

import funkin.modding.util.ModUtil;

import polymod.Polymod;
import polymod.util.zip.ZipParser;

import flixel.util.FlxSave;

class Mod {
    var name:String;
    var desc:String;
    var path:String;
    var data:FlxSave = null;
    
    var meta:Array<Dynamic> = [];

    var links:Array<String> = [];

    var saveLocation:String;

    public function new(name:String, desc:String, ?hasCustomSave:Bool, ?saveLocation:String) {
        this.name = name;
        this.desc = desc;
        path = 'mods/' + name;

        if (saveLocation == null)
            this.saveLocation = name;

        if (hasCustomSave) {
            data = new FlxSave();
            data.bind(name, saveLocation);
        }
    }

    public function setDataVar(dataVar:String, value:Dynamic) {
        if (data != null) 
            Reflect.setProperty(data, dataVar, value) 
        else 
            ModUtil.traceError('No data found, Value not set.');
    }

}