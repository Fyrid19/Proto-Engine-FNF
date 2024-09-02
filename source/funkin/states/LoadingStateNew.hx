package funkin.states;

import flixel.addons.util.FlxAsyncLoop;
import backend.assets.FunkinTypedCache;
import openfl.display.BitmapData;
import flash.media.Sound;

import openfl.utils.Assets as OpenFlAssets;

@:privateAccess(openfl.display.BitmapData)
class LoadingState extends MusicBeatState {
    inline static var MIN_TIME:Float = 1.0;

    public static var spritesToCache:Array<String>;
    public static var soundsToCache:Array<String>;

    public static var nextState:FlxState;
    public static var stopMusic:Bool;
    static var asyncLoop:FlxAsyncLoop;

    static var gameSprites:Array<String> = [
        'ready', 'set', 'go', // 3 2 1 go 
        'combo', 'sick', 'good', 'bad', 'shit', // combo & ratings
        'healthBar', 'NOTE_assets', 'noteSplashes', // ui assets
        'alphabet' // just incase it isnt loaded beforehand
    ];

    static var gameSounds:Array<String> = [
        'intro1', 'intro2', 'intro3', 'introGo', // 3 2 1 go
        'missnote1', 'missnote2', 'missnote3', // miss sounds
        'scrollMenu' // again just incase
    ];

    public function new(?nextState:FlxState = null, ?stopMusic:Bool = false) {
        this.nextState = nextState;
        this.stopMusic = stopMusic;
    }

    public function create() {
        var totalAssetsToLoad:Int = 0;

        for (i in 0...9)
            gameSprites.push('num' + i); // makes things easier
        totalAssetsToLoad += gameSprites.length + gameSounds.length;

        for (sprite in gameSprites)
            spritesToCache.push(sprite);
        for (sound in gameSounds)
            soundsToCache.push(sonud);

        if (OpenFlAssets.exists(Paths.stage(PlayState.curStage + '.toml'))) {
            // uhhmmm do toml parsing bullshit idk
        } else {
            trace('No stage found!');
        }
    }
}