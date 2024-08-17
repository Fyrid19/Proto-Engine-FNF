package backend;

import flixel.util.FlxSave;

import funkin.modding.util.ModUtil;
import funkin.modding.Mod;

class FunkinData {
    public static var initialized:Bool = false;

    public static var save:FlxSave; // probably not the best way of going about this but eh
    public static var data:Map<String, Dynamic> = null;
    public static var dataDefault:Map<String, Dynamic> = [
        // Gameplay
        'downScroll' => false,
        'ghostTapping' => false,
        'flashingLights' => true,
        'cameraZoom' => true,

        // Misc.
        'childFriendly' => false,
        'unfocusPause' => true,
        'hideFPSText' => false,
        'hideMemoryText' => false,
        'hideWatermark' => false,

        // Graphics
        'globalAntialiasing' => true,
        'maxFramerate' => 60,
        'shadersEnabled' => true,
    ];

    public static var loadedMods:Array<Mod> = [];

    public static function initialize() {
        save = new FlxSave();
        save.bind('prototype', EngineMain.savePath);
        data = dataDefault;

        loadActiveMods();

        loadKeybinds();
        loadData();

        if (data != null)
            initialized = true;
    }

    public static function loadActiveMods() {
        if (save.data.loadedMods == null)
            save.data.loadedMods = [];
        loadedMods = save.data.loadedMods;
        ModUtil.loadMods();
    }

    public static function loadKeybinds() {
        var csave = new FlxSave();
        csave.bind('controls', EngineMain.savePath);
        
        if (csave.data.keybinds == null) {
            csave.data.keybinds = Controls.keyBinds;
            trace('No keybinds found, setting to default');
        } else {
            Controls.keyBinds = csave.data.keybinds;
        }

        if (csave.data.padbinds == null) {
            csave.data.padbinds = Controls.controllerBinds;
            trace('No controller binds found, setting to default');
        } else {
            Controls.controllerBinds = csave.data.padbinds;
        }
    }

    public static function loadData(?log:Bool) {
        var newData:Bool = false;
        for (key => value in data) {
            if (Reflect.getProperty(save.data, key) == null) {
                Reflect.setProperty(save.data, key, value);
                newData = true;
            } else {
                data[key] = Reflect.getProperty(save.data, key);
            }

            // trace('Map: ' + key + ', ' + value);
            // trace('Data: ' + key + ', ' + Reflect.getProperty(save.data, key));
        }
        
        if (log) {
            if (!newData)
                trace('Loaded data successfully!');
            else
                trace('No data was found, your data has been reset');
        }
    }

    public static function saveData(?log:Bool) {
        for (key => value in data) {
            Reflect.setProperty(save.data, key, value);
        }
        if (log) trace('Data saved!');
    }

    public static function setToDefault(?log:Bool) {
        for (key => value in dataDefault) {
            Reflect.setProperty(save.data, key, value);
        }
        data = dataDefault;
        if (log) trace('Data reset');
    }
}