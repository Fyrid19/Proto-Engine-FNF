package backend.assets;

import flixel.graphics.FlxGraphic;

import openfl.display.BitmapData;
import openfl.utils.AssetType;
import openfl.utils.AssetCache;
import openfl.utils.Assets as OpenFlAssets;

import lime.utils.Assets;
import flash.media.Sound;

class Paths {
    inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end; // Sound file type

    public static var currentLevel:String = '';
    public static function setCurrentLevel(v:String) currentLevel = v.toLowerCase();

    static var exclusionList:Array<String> = ['freakyMenu.$SOUND_EXT'];
    static var tempCacheList:Array<String> = [];
    static var graphicCache:Map<String, FlxGraphic> = [];
    static var soundCache:Map<String, Sound> = [];

    public static function clearCache() {
        FlxG.bitmap.clearCache();
        graphicCache.clear();
        soundCache.clear();
        trace('Cache cleared');
    }

    public static function clearUnused() {
        FlxG.bitmap.clearUnused();

        for (key in graphicCache.keys()) {
            var exclude:Bool = false;
            for (i in 0...exclusionList.length) {
                if (key.endsWith(exclusionList[i])) {
                    exclude = true;
                }
            }

            if (!tempCacheList.contains(key) && !exclude) {
                graphicCache.remove(key);
            }
        }

        trace('Unused cache cleared');
    }

    // based off psych thing
    public static function clearStored() {
        for (key => asset in soundCache) {
            var exclude:Bool = false;
            for (i in 0...exclusionList.length) {
                if (key.endsWith(exclusionList[i])) {
                    exclude = true;
                }
            }

			if (!tempCacheList.contains(key) && !exclude && asset != null) {
				Assets.cache.clear(key);
				soundCache.remove(key);
			}
		}
		tempCacheList = [];
		#if !html5 OpenFlAssets.cache.clear("songs"); #end
    }

    public static function getPath(key:String, ?library:String) {
        var path:String = '$library:assets/$library/$key';
        return OpenFlAssets.exists(path) ? path : 'assets/$key';
    }

    inline public static function file(key:String, ?library:String)
        return getPath(key, library);

    inline public static function txt(key:String, ?library:String)
        return getPath('data/$key.txt', library);

    inline public static function xml(key:String, ?library:String)
        return getPath('data/$key.xml', library);

    inline public static function json(key:String, ?library:String)
        return getPath('data/$key.json', library);

    inline public static function font(key:String, ?library:String)
        return getPath('fonts/$key', library);

    inline public static function image(key:String, ?library:String):FlxGraphic {
        var path:String = getPath('images/$key.png', library);
        if (graphicCache.exists(path)) {
            trace('Graphic exists in cache ($path)');
            return graphicCache.get(path);
        } else {
            return cacheGraphic(key, library);
        }
    }

    inline public static function sound(key:String, ?library:String)
        return getSound('sounds/$key.$SOUND_EXT', library);

    inline public static function soundRandom(key:String, min:Int, max:Int, ?library:String)
		return sound(key + FlxG.random.int(min, max), library);

    inline public static function music(key:String, ?library:String)
        return getSound('music/$key.$SOUND_EXT', library);

    public static function cacheGraphic(key:String, ?library:String) {
        var path:String = getPath('images/$key.png', library);
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

        var graphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap, false, key);
        graphic.persist = true;
        graphic.destroyOnNoUse = false;
        graphicCache.set(path, graphic);
        if (!tempCacheList.contains(path)) tempCacheList.push(path);
        trace('Graphic cached: ' + path);
        return graphic;
    }

    public static function getSound(key:String, ?library:Null<String>):Sound { // getPath on steroids
        var path:String = getPath(key, library);
        if (!soundCache.exists(path)) {
            soundCache.set(path, Sound.fromFile(path));
            trace('Sound added to cache ($path)');
        }
        if (!tempCacheList.contains(path)) tempCacheList.push(path);
        return soundCache.get(path);
    }

    inline public static function songPath(key:String, song:String, ?diff:Null<String>) {
        var path:String = 'songs/$song/$diff/$key';
        path = OpenFlAssets.exists(path) ? path : 'songs/$song/$key';
        return path;
    }

    inline public static function inst(song:String, ?diff:Null<String>) {
        var path:String = songPath('Inst.$SOUND_EXT', song, diff);
        return getSound(path);
    }

    inline public static function voices(song:String, vocalSuffix:String = '', ?diff:Null<String>) {
        var path:String = songPath('Voices$vocalSuffix.$SOUND_EXT', song, diff);
        return getSound(path);
    }

    inline public static function instPath(song:String, ?diff:Null<String>) {
        var path:String = songPath('Inst-$diff.$SOUND_EXT', song, diff);
        return path;
    }

    inline public static function voicesPath(song:String, vocalSuffix:String = '', ?diff:Null<String>) {
        var path:String = songPath('Voices$vocalSuffix.$SOUND_EXT', song, diff);
        return path;
    }

    inline public static function chart(song:String, diff:String = 'normal', legacy:Bool) {
        var path:String = 'songs/$song/$diff/';
        path = OpenFlAssets.exists(path) ? path : 'songs/$song/';
        return legacy ? '$path/chart/$diff.json' : '$path/$song.chrt';
    }

    inline public static function video(key:String, ?ext:String = 'mp4', ?library:String)
        return getPath('videos/$key.$ext', library);

    inline public static function frag(key:String, ?library:String)
        return getPath('shaders/$key.frag', library);

    inline public static function vert(key:String, ?library:String)
        return getPath('shaders/$key.vert', library);

    // im gonna make these all into one function later
    inline public static function getSparrowAtlas(?key:String, ?library:String) {
        var ext:String = 'xml';
        var path:String = file('images/$key.$ext', library);
        path = OpenFlAssets.exists(path) ? path : '$key.$ext';
        var graphic:FlxGraphic = image(key, library);

        if (OpenFlAssets.exists(path)) {
            return FlxAtlasFrames.fromSparrow(graphic, path);
        } else {
            trace('File not found: ' + path);
            return null;
        }
    }

    inline public static function getPackerAtlas(?key:String, ?library:String) {
        var ext:String = 'txt';
        var path:String = file('images/$key.$ext', library);
        path = OpenFlAssets.exists(path) ? path : '$key.$ext';
        var graphic:FlxGraphic = image(key, library);

        if (OpenFlAssets.exists(path)) {
            return FlxAtlasFrames.fromSpriteSheetPacker(graphic, path);
        } else {
            trace('File not found: ' + path);
            return null;
        }
    }

    inline public static function getAsepriteAtlas(?key:String, ?library:String) {
        var ext:String = 'json';
        var path:String = file('images/$key.$ext', library);
        path = OpenFlAssets.exists(path) ? path : '$key.$ext';
        var graphic:FlxGraphic = image(key, library);

        if (OpenFlAssets.exists(path)) {
            return FlxAtlasFrames.fromAseprite(graphic, path);
        } else {
            trace('File not found: ' + path);
            return null;
        }
    }
}