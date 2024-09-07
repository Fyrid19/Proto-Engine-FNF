package backend.assets;

import openfl.utils.Assets;
import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
import openfl.system.System;

/**
 * Funkin asset library, used for caching, returning files, and more.
 */
@:access(openfl.display.BitmapData)
class FunkinAssets {
    private static var _cache:FunkinCache;

    /**
     * Initializes the asset cache
     */
    public static function init() {
        _cache = new FunkinCache();
        trace('FunkinAssets initialized');
    }

    /**
     * Clears both the sound and graphic caches
     */
    @:access(flixel.system.frontEnds.BitmapFrontEnd._cache)
    public static function clearCaches() {
        Assets.cache.clear('assets/songs');
        for (key in FlxG.bitmap._cache.keys()) {
			if (!_cache.graphicCache.exists(key)) {
                if (FlxG.bitmap.get(key).bitmap.__texture != null)
                    FlxG.bitmap.get(key).bitmap.__texture.dispose();
				FlxG.bitmap.remove(FlxG.bitmap.get(key));
            }
		}
        FlxG.bitmap.dumpCache(); // i am desperate to clean memory
        _cache.clearCaches();
        System.gc();
    }

    /**
     * Returns a graphic from the current _cache, if no graphic is found it caches a new one.
     * @param Key       The key of the graphic to return
     * @return          The cached graphic
     */
    public static function getCacheGraphic(Key:String)
        return _cache.getGraphic(Key);

    /**
     * Returns a sound from the current _cache, if no sound is found it caches a new one.
     * @param Key       The key of the sound to return
     * @return          The cached sound
     */
    public static function getCacheSound(Key:String)
        return _cache.getSound(Key);

    /**
     * Returns a blank graphic.
     * 
     * Functions similarly to FlxSprite's "createGraphic"
     * @param Width     Width of the graphic
     * @param Height    Height of the graphic
     * @param Color     Color of the graphic
     * @return          The blank graphic that got created
     */
    public static function makeGraphic(Width:Int = 10, Height:Int = 10, Color:FlxColor = FlxColor.WHITE) {
        var graphicKey:String = Width + 'x' + Height + ':' + Color;
        var bitmap:BitmapData = new BitmapData(1, 1, false);
        bitmap.lock();
        bitmap.setPixel(1, 1, Color);
        bitmap.width = Width;
        bitmap.height = Height;
        bitmap.unlock();

        var graphic:FlxGraphic = _cache.getGraphic(graphicKey);
        if (graphic != null) return graphic;

        var graphic:FlxGraphic;
        try (graphic = FlxGraphic.fromBitmapData(bitmap))
        catch (e) {
            trace('Graphic failed to load');
            return null;
        }
        _cache.cacheGraphic(graphicKey, graphic);
        return graphic;
    }

    /**
     * Returns a parsed JSON file
     * @param Path      The path to the json file
     * @return          Parsed JSON file
     */
    public static function getJson(Path:String) {
        var rawJson:String = Assets.getText(Path);
        return haxe.Json.parse(rawJson);
    }
}