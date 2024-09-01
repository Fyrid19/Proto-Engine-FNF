package backend.assets;

import openfl.utils.Assets as OpenFlAssets;
import openfl.display.BitmapData;
import flixel.graphics.FlxGraphic;
import flash.media.Sound;
import lime.utils.Assets;

class FunkinCache {
    public var graphicCache:Map<String, FlxGraphic> = [];
    public var soundCache:Map<String, Sound> = [];
    public var backupGraphicCache:Map<String, FlxGraphic> = [];
    public var backupSoundCache:Map<String, Sound> = [];

    public function new() {
        graphicCache = new Map<String, FlxGraphic>();
        soundCache = new Map<String, Sound>();
        backupGraphicCache = new Map<String, FlxGraphic>();
        backupSoundCache = new Map<String, Sound>();
    }

    public function clearCaches() {
        backupGraphicCache = graphicCache;
        graphicCache = [];
        backupSoundCache = soundCache;
        soundCache = [];
        trace('Caches cleared');
    }

    public function cacheGraphic(key:String) {
        var bitmap:BitmapData;

        if (graphicCache.exists(key)) {
            trace('Graphic already cached');
            return;
        }

        if (backupGraphicCache.exists(key)) {
            var graphic = backupGraphicCache.get(key);
            backupGraphicCache.remove(key);
            graphicCache.set(key, graphic);
            return;
        }

        try (bitmap = BitmapData.fromFile(key))
        catch (e) {
            trace('Graphic not found: ' + key);
            return;
        }

        var graphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap, false, key);
        graphic.persist = true;
        graphicCache.set(key, graphic);
        trace('Graphic cached: ' + key);
    }

    public function cacheSound(key:String) {
        var sound:Sound = OpenFlAssets.getSound(key);

        if (backupSoundCache.exists(key)) {
            var sound:Sound = backupSoundCache.get(key);
            backupSoundCache.remove(key);
            soundCache.set(key, sound);
            return;
        }

        if (!soundCache.exists(key)) {
            if (OpenFlAssets.exists(key)) {
                trace('Sound cached: ' + key);
                soundCache.set(key, sound);
                return;
            } else {
                trace('Sound not found: ' + key);
				return;
            }
        }
    }

    public function getGraphic(key:String) {
        if (!graphicCache.exists(key))
            cacheGraphic(key);
        return graphicCache.get(key);
    }

    public function getSound(key:String) {
        if (!soundCache.exists(key))
            cacheSound(key);
        return soundCache.get(key);
    }

    public function removeGraphic(key:String)
        if (graphicCache.exists(key)) graphicCache.remove(key);

    public function removeSound(key:String)
        if (soundCache.exists(key)) soundCache.remove(key);

    public function graphicExists(key:String)
        return graphicCache.exists(key);
    
    public function soundExists(key:String)
        return soundCache.exists(key);
}