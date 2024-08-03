package funkin.modding.util;

import funkin.modding.Mod;
import openfl.utils.Assets;

class ModUtil {
    public static var curLoadedMods:Array<Mod> = [];

    static var att:Int = 0;

    public static function loadMods() {
        var accessibleModArray:Array<Mod> = [];
        if (FunkinData.loadedMods != null) {
            for (mod in FunkinData.loadedMods) {
                if (Assets.exists('assets/' + mod.path + 'meta.json')) {
                    accessibleModArray.push(mod);
                } else {
                    trace(mod.name + " has no meta json (or just doesn't exist)");
                }
            }
            FunkinData.loadedMods = accessibleModArray;
        } else { // if for some weird reason its still null, make a backup and call the function again
            var backupModArray:Array<Mod> = [];
            FunkinData.loadedMods = backupModArray;
            att++;
            if (att < 2) {
                loadMods();
            } else {
                return FunkinUtil.forceCrash('Mods cannot be loaded!');
            }
        }
    }

    public static function traceError(err:String) { // placeholder
        trace(err);
    }
}