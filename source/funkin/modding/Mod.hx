package funkin.modding;

import funkin.modding.util.ModUtil;

// import polymod.Polymod;
// import polymod.util.zip.ZipParser;

import flixel.util.FlxSave;

class Mod {
    public var name:String;
    public var desc:String;
    public var path:String;
    public var data:FlxSave = null;
    
    public var meta:Array<Dynamic> = [];

    public var links:Array<String> = [];

    public var saveLocation:String;

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