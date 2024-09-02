package backend.assets;

import flixel.system.FlxAssets;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.graphics.FlxGraphic;
import flash.media.Sound;

import openfl.display.BitmapData;
import openfl.utils.AssetType;
import openfl.utils.AssetCache;
import openfl.utils.Assets as OpenFlAssets;
import openfl.system.System;
import lime.utils.Assets;

// caching system is like a mix of funkin and flashcache so credits to them i guess
class Paths {
    inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end; // Sound file type

    public static var currentLevel:String = null;
    public static function setCurrentLevel(v:String) currentLevel = v.toLowerCase();

    public static var assetCache:FunkinCache;

    static var graphicCache:Map<String, FlxGraphic> = [];
    static var backupGraphicCache:Map<String, FlxGraphic> = [];
    static var soundCache:Map<String, Sound> = [];
    static var backupSoundCache:Map<String, Sound> = [];

    public static function init() {
        assetCache = new FunkinCache();
    }

    public static function clearCaches() {
        OpenFlAssets.cache.clear('assets/songs');
        FlxG.bitmap.dumpCache(); // i am desperate to clean memory
        assetCache.clearCaches();
        System.gc();
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
        return assetCache.getGraphic(path);
    }

    inline public static function sound(key:String, ?library:String)
        return getSound('sounds/$key.$SOUND_EXT', library);

    inline public static function soundRandom(key:String, min:Int, max:Int, ?library:String)
		return sound(key + FlxG.random.int(min, max), library);

    inline public static function music(key:String, ?library:String)
        return getSound('music/$key.$SOUND_EXT', library);

    public static function getSound(key:String, ?library:Null<String>):Sound { // getPath on steroids
        var path:String = getPath(key, library);
        return assetCache.getSound(path);
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

    inline public static function voices(song:String, ?vocalSuffix:String = '', ?diff:Null<String>) {
        var path:String = songPath('Voices$vocalSuffix.$SOUND_EXT', song, diff);
        return getSound(path);
    }

    inline public static function instPath(song:String, ?diff:Null<String>) {
        var path:String = songPath('Inst.$SOUND_EXT', song, diff);
        return getPath(path);
    }

    inline public static function voicesPath(song:String, ?vocalSuffix:String = '', ?diff:Null<String>) {
        var path:String = songPath('Voices$vocalSuffix.$SOUND_EXT', song, diff);
        return getPath(path);
    }

    inline public static function chart(song:String, diff:String = 'normal', legacy:Bool) {
        var songLowercase:String = song.toLowerCase();
        var path:String = 'songs/$songLowercase/$diff/';
        path = OpenFlAssets.exists(path) ? path : 'songs/$songLowercase/';
        return legacy ? '$path/chart/$diff.json' : '$path/$songLowercase.chrt';
    }

    inline public static function stage(key:String, ?library:String)
        return getPath('stages/$key', library);

    inline public static function video(key:String, ?ext:String = 'mp4')
        return getPath('videos/$key.$ext');

    inline public static function frag(key:String, ?library:String)
        return getPath('shaders/$key.frag', library);

    inline public static function vert(key:String, ?library:String)
        return getPath('shaders/$key.vert', library);

    inline public static function noteSkin(key:String, ?library:String)
        return dataFile('skins/$key.json', library);

    // im gonna make these all into one function later
    inline public static function getSparrowAtlas(key:String, ?library:String) {
        var ext:String = 'xml';
        var path:String = file('images/$key.$ext', library);
        path = OpenFlAssets.exists(path) ? path : file('$key.$ext', library);
        var graphic:FlxGraphic = image(key, library);

        if (OpenFlAssets.exists(path)) {
            return FlxAtlasFrames.fromSparrow(graphic, path);
        } else {
            trace('File not found: ' + path);
            return null;
        }
    }

    inline public static function getPackerAtlas(key:String, ?library:String) {
        var ext:String = 'txt';
        var path:String = file('images/$key.$ext', library);
        path = OpenFlAssets.exists(path) ? path : file('$key.$ext', library);
        var graphic:FlxGraphic = image(key, library);

        if (OpenFlAssets.exists(path)) {
            return FlxAtlasFrames.fromSpriteSheetPacker(graphic, path);
        } else {
            trace('File not found: ' + path);
            return null;
        }
    }

    inline public static function getAsepriteAtlas(key:String, ?library:String) {
        var ext:String = 'json';
        var path:String = file('images/$key.$ext', library);
        path = OpenFlAssets.exists(path) ? path : file('$key.$ext', library);
        var graphic:FlxGraphic = image(key, library);

        if (OpenFlAssets.exists(path)) {
            return FlxAtlasFrames.fromAseprite(graphic, path);
        } else {
            trace('File not found: ' + path);
            return null;
        }
    }

    // multiple spritesheet support (credits to NeeEoo for base code)
    // this assumes all your spritesheet file types are the same
    inline public static function getMultiSpritesheetFrames(keys:Array<String>, ?type:String = 'xml', ?library:String) {
        var framesToReturn:FlxAtlasFrames;
        for (i in 0...keys.length) {
            switch (type) {
                case 'xml' | 'sparrow':
                    var xmlFrames = getSparrowAtlas(keys[i], library);
                    for (frame in xmlFrames.frames)
                        framesToReturn.pushFrame(frame);
                    framesToReturn.frames = framesToReturn.frames;
                case 'txt' | 'packer':
                    var txtFrames = getPackerAtlas(keys[i], library);
                    for (frame in txtFrames.frames)
                        framesToReturn.pushFrame(frame);
                    framesToReturn.frames = framesToReturn.frames;
                case 'json' | 'aseprite': // json spritesheets are usually aseprite sheets so
                    var jsonFrames = getAsepriteAtlas(keys[i], library);
                    for (frame in jsonFrames.frames)
                        framesToReturn.pushFrame(frame);
                    framesToReturn.frames = framesToReturn.frames;
                default:
                    trace('File type not supported: ' + type);
                    return null;
            }
        }
        return framesToReturn;
    }
}