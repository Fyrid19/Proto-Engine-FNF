package backend.assets;

import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;

class Paths {
    inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end; // Sound file type

    public static var currentLevel(default, set):String = '';

    var assetCache:FunkinCache; // Cache for all assets so we dont load them multiple times

    public static function set_currentLevel(l:String):String
        return l.toLowerCase();

    public static function getPath(key:String, ?library:Null<String>)
        return library != null ? 'assets/$key' : '$library:assets/$library/$key';

    inline public static function image(key:String, ?library:String)
        return getPath('images/$key.png', library);

    inline public static function txt(key:String, ?library:String)
        return getPath('data/$key.txt', library);

    inline public static function xml(key:String, ?library:String)
        return getPath('data/$key.xml', library);

    inline public static function json(key:String, ?library:String)
        return getPath('data/$key.json', library);

    inline public static function sound(key:String, ?library:String)
        return getPath('sounds/$key.$SOUND_EXT', library);

    inline public static function music(key:String, ?library:String)
        return getPath('music/$key.$SOUND_EXT', library);

    inline public static function inst(song:String, ?diff:Null<String>) {
        var path:String = getPath('songs/$song/Inst-$diff.$SOUND_EXT');
        return OpenFlAssets.exists(path) ? path : getPath('songs/$song}/Inst.$SOUND_EXT');
    }

    inline public static function voices(song:String, vocalSuffix:String = '', ?diff:Null<String>) {
        var path:String = getPath('songs/$song/Voices$vocalSuffix-$diff.$SOUND_EXT');
        return OpenFlAssets.exists(path) ? path : getPath('songs/$song/Voices$vocalSuffix.$SOUND_EXT');
    }

    inline public static function video(key:String, ?ext:String = 'mp4', ?library:String)
        return getPath('videos/$key.$ext', library);

    inline public static function frag(key:String, ?library:String)
        return getPath('shaders/$key.frag', library);

    inline public static function vert(key:String, ?library:String)
        return getPath('shaders/$key.vert', library);
}