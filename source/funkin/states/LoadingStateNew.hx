package funkin.states;

import backend.assets.FunkinTypedCache;

import flash.media.Sound;
import openfl.display.BitmapData;

@:privateAccess(openfl.display.BitmapData)
class LoadingState extends MusicBeatState {
    inline static var MIN_TIME:Float = 1.0;

    public static var bgSpriteCache:FunkinTypedCache<BGSprite>;
    public static var characterCache:FunkinTypedCache<Character>;
    public static var songCache:FunkinTypedCache<Sound>;
    public static var modchartSpritesCache:FunkinTypedCache<FlxSprite>; // will be used later

    public function new(?spritesToLoad:Array<String>) {
        bgSpriteCache = new FunkinTypedCache<BGSprite>();
        characterCache = new FunkinTypedCache<Character>();
        songCache = new FunkinTypedCache<Sound>();
        modchartSpritesCache = new FunkinTypedCache<FlxSprite>();
    }
}