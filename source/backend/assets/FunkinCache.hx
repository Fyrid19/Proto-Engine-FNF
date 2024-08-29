package backend.assets;

import openfl.utils.Assets as OpenFlAssets;
import openfl.display.BitmapData;
import flixel.graphics.FlxGraphic;
import flash.media.Sound;
import lime.utils.Assets;

enum abstract AssetType(String) from String to String {
    var IMAGE:String = 'image';
    var SOUND:String = 'sound';
}

class FunkinCache {
    public var graphicCache:Map<String, FlxGraphic> = [];
    public var soundCache:Map<String, Sound> = [];

    public function new() {
        graphicCache = new Map<String, FlxGraphic>();
        soundCache = new Map<String, Sound>();
    }

    public function cacheGraphic(key:String, ?library:String) {
        var path:String = Paths.getPath('images/$key.png', library);
        var bitmap:BitmapData;

        if (graphicCache.exists(path)) {
            trace('Graphic already cached, returning null');
            return null;
        }

        try (bitmap = BitmapData.fromFile(path))
        catch (e) {
            trace('Image cannot be loaded: ' + path);
            return null;
        }

        if (!OpenFlAssets.exists(path)) {
            trace('File doesn\'t exist: ' + path);
            return null;
        }

        var graphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap, false, key);
        graphic.persist = true;
        graphic.destroyOnNoUse = false;
        graphicCache.set(path, graphic);
        trace('Graphic cached: ' + path);
        return graphic;
    }

    public function cacheSound() {
        
    }
}