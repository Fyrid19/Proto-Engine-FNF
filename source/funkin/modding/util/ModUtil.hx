package funkin.modding.util;

import funkin.modding.Mod;

class ModUtil {
    public static var curLoadedMods:Array<Mod> = [];

    public static function loadMods() {
        var accessibleModArray:Array<Mod> = [];
        if (FunkinData.save.data.loadedMods != null) {
            for (mod in FunkinData.save.data.loadedMods) {
                // doing later
            }
        }
    }

    public static function traceError(err:String) { // placeholder
        trace(err);
    }
}