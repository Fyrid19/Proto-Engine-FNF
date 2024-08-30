package backend.assets;

import flixel.system.FlxAssets;
import flixel.graphics.FlxGraphic;

import openfl.display.BitmapData;
import openfl.utils.AssetType;
import openfl.utils.AssetCache;
import openfl.utils.Assets as OpenFlAssets;

import lime.utils.Assets;
import flash.media.Sound;

// caching system is like a mix of funkin and flashcache so credits to them i guess
class Paths {
    inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end; // Sound file type

    public static var currentLevel:String = null;
    public static function setCurrentLevel(v:String) currentLevel = v.toLowerCase();

    static var graphicCache:Map<String, FlxGraphic> = [];
    static var backupGraphicCache:Map<String, FlxGraphic> = [];
    static var soundCache:Map<String, Sound> = [];
    static var backupSoundCache:Map<String, Sound> = [];

    public static function clearCaches() {
        backupGraphicCache = graphicCache;
        graphicCache = [];
        backupSoundCache = soundCache;
        soundCache = [];
        OpenFlAssets.cache.clear('assets/songs');
        trace('Caches cleared');
    }

    public static function getPath(key:String, ?library:String) {
        var level:String = currentLevel != null ? currentLevel : library;
        var path:String = '$level:assets/$level/$key';
        path = OpenFlAssets.exists(path) ? path : 'assets/$level/$key'; // if theres no actual library check for parent folder
        return OpenFlAssets.exists(path) ? path : 'assets/$key';
    }

    inline public static function file(key:String, ?library:String)
        return getPath(key, library);

    inline public static function dataFile(key:String, ?library:String)
        return getPath('data/$key', library);

    inline public static function txt(key:String, ?library:String)
        return dataFile('$key.txt', library);

    inline public static function xml(key:String, ?library:String)
        return dataFile('$key.xml', library);

    inline public static function json(key:String, ?library:String)
        return dataFile('$key.json', library);

    inline public static function font(key:String, ?library:String)
        return getPath('fonts/$key', library);

    inline public static function image(key:String, ?library:String):FlxGraphic {
        var path:String = getPath('images/$key.png', library);
        if (graphicCache.exists(path)) {
            // trace('Graphic exists in cache ($path)');
            return graphicCache.get(path);
        } else {
            return cacheGraphic(path);
        }
    }

    inline public static function sound(key:String, ?library:String)
        return getSound('sounds/$key.$SOUND_EXT', library);

    inline public static function soundRandom(key:String, min:Int, max:Int, ?library:String)
		return sound(key + FlxG.random.int(min, max), library);

    inline public static function music(key:String, ?library:String)
        return getSound('music/$key.$SOUND_EXT', library);

    public static function cacheGraphic(key:String):FlxGraphic {
        var bitmap:BitmapData;

        if (graphicCache.exists(key)) {
            trace('Graphic already cached');
            return null;
        }

        if (backupGraphicCache.exists(key)) {
            var graphic = backupGraphicCache.get(key);
            backupGraphicCache.remove(key);
            graphicCache.set(key, graphic);
            return graphic;
        }

        try (bitmap = BitmapData.fromFile(key))
        catch (e) {
            trace('Graphic not found: ' + key);
            return null;
        }

        var graphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap, false, key);
        graphic.persist = true;
        graphicCache.set(key, graphic);
        trace('Graphic cached: ' + key);
        return graphic;
    }

    public static function getSound(key:String, ?library:Null<String>):Sound { // getPath on steroids
        var path:String = getPath(key, library);
        var sound:Sound = OpenFlAssets.getSound(path);

        if (backupSoundCache.exists(path)) {
            var sound:Sound = backupSoundCache.get(path);
            backupSoundCache.remove(path);
            soundCache.set(path, sound);
            return sound;
        }

        if (soundCache.exists(path)) {
            return soundCache.get(path);
        } else {
            if (OpenFlAssets.exists(path)) {
                trace('Sound cached: ' + path);
                soundCache.set(path, sound);
                return sound;
            } else {
                trace('Sound not found: ' + path);
				return FlxAssets.getSound('flixel/sounds/beep');
            }
        }
    }

    inline public static function songPath(key:String, song:String, ?diff:Null<String>) {
        var songLowercase:String = song.toLowerCase();
        var path:String = 'songs/$songLowercase/$diff/$key';
        path = OpenFlAssets.exists(path) ? path : 'songs/$songLowercase/$key';
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
        var songLowercase:String = song.toLowerCase();
        var path:String = 'songs/$songLowercase/$diff/';
        path = OpenFlAssets.exists(path) ? path : 'songs/$songLowercase/';
        return legacy ? '$path/chart/$diff.json' : '$path/$songLowercase.chrt';
    }

    inline public static function video(key:String, ?ext:String = 'mp4', ?library:String)
        return getPath('videos/$key.$ext', library);

    inline public static function frag(key:String, ?library:String)
        return getPath('shaders/$key.frag', library);

    inline public static function vert(key:String, ?library:String)
        return getPath('shaders/$key.vert', library);

    inline public static function noteSkin(key:String, skin:String, ?library:String)
        return dataFile('skins/$skin/$key.json', library);

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