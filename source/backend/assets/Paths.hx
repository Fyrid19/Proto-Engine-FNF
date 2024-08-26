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

    public static var assetCache:FunkinCache; // Cache for all assets so we dont load them multiple times
    public static var curBitmapCache:Map<String, BitmapData>; // might not use idk
    public static var curSoundCache:Map<String, Sound>;

    public static function clearCache() {
        FlxG.bitmap.clearUnused();
        FlxG.bitmap.clearCache();
        assetCache.clear();
        trace('Cache cleared');
    }

    public static function clearUnused() {
        FlxG.bitmap.clearUnused();
        trace('Unused cache cleared');
    }

    public static function getPath(key:String, ?library:String = null)
        return library != null ? '$library:assets/$library/$key' : 'assets/$key';

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
        if (assetCache.exists(path, IMAGE))
            return assetCache.get(path, IMAGE);
        else
            return cacheGraphic(key, library);
    }

    // slightly based off psych thing
    inline public static function cacheGraphic(key:String, ?library:String) {
        var path:String = getPath('images/$key.png', library);
        var bitmap:BitmapData = OpenFlAssets.getBitmapData(path);
        if (bitmap == null) {
            trace('Bitmap returned null: $path');
            return null;
        }

        var graphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap, false, key);
        graphic.destroyOnNoUse = false;
        graphic.persist = true;
        assetCache.set(path, IMAGE, graphic);
        return graphic;
    }

    inline public static function sound(key:String, ?library:String)
        return getSound('sounds/$key.$SOUND_EXT', library);

    inline public static function soundRandom(key:String, min:Int, max:Int, ?library:String)
		return sound(key + FlxG.random.int(min, max), library);

    inline public static function music(key:String, ?library:String)
        return getSound('music/$key.$SOUND_EXT', library);

    inline public static function inst(song:String, ?diff:Null<String>) {
        var path:String = 'songs/$song/Inst-$diff.$SOUND_EXT';
        path = OpenFlAssets.exists(path) ? path : 'songs/$song/Inst.$SOUND_EXT';
        return getSound(path);
    }

    inline public static function voices(song:String, vocalSuffix:String = '', ?diff:Null<String>) {
        var path:String = 'songs/$song/Voices$vocalSuffix-$diff.$SOUND_EXT';
        path = OpenFlAssets.exists(path) ? path : 'songs/$song/Voices$vocalSuffix.$SOUND_EXT';
        return getSound(path);
    }

    inline public static function instPath(song:String, ?diff:Null<String>) {
        var path:String = 'songs/$song/Inst-$diff.$SOUND_EXT';
        path = OpenFlAssets.exists(path) ? path : 'songs/$song/Inst.$SOUND_EXT';
        return path;
    }

    inline public static function voicesPath(song:String, vocalSuffix:String = '', ?diff:Null<String>) {
        var path:String = 'songs/$song/Voices$vocalSuffix-$diff.$SOUND_EXT';
        path = OpenFlAssets.exists(path) ? path : 'songs/$song/Voices$vocalSuffix.$SOUND_EXT';
        return path;
    }

    inline public static function video(key:String, ?ext:String = 'mp4', ?library:String)
        return getPath('videos/$key.$ext', library);

    inline public static function frag(key:String, ?library:String)
        return getPath('shaders/$key.frag', library);

    inline public static function vert(key:String, ?library:String)
        return getPath('shaders/$key.vert', library);

    inline public static function getSound(key:String, ?library:Null<String>):Sound { // getPath on steroids
        var path:String = library != null ? 'assets/$key' : '$library:assets/$library/$key';
        if (assetCache.get(path, SOUND) == null)
            assetCache.set(path, SOUND, Sound.fromFile(path));
        return assetCache.get(path, SOUND);
    }

    // im gonna make these all into one function later
    inline public static function getSparrowAtlas(?key:String, ?library:String) {
        var graphic:FlxGraphic = image(key, library);
        return FlxAtlasFrames.fromSparrow(graphic, xml(key, library));
    }

    inline public static function getPackerAtlas(?key:String, ?library:String) {
        var graphic:FlxGraphic = image(key, library);
        return FlxAtlasFrames.fromSpriteSheetPacker(graphic, txt(key, library));
    }

    inline public static function getTextureAtlas(?key:String, ?library:String) {
        var graphic:FlxGraphic = image(key, library);
        return FlxAtlasFrames.fromTexturePackerJson(graphic, json(key, library));
    }
}