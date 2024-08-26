package backend.assets;

import flixel.graphics.FlxGraphic;
import flash.media.Sound;

enum abstract AssetType(String) to String from String {
    var IMAGE = 'image';
    var SOUND = 'sound';
}

class FunkinCache {
    public var graphic:Map<String, FlxGraphic>;
    public var sound:Map<String, Sound>;

    public function new() {
        graphic = new Map<String, FlxGraphic>();
        sound = new Map<String, Sound>();
    }

    public function clear(?prefix:Null<String>) {
        if (prefix == null) {
            graphic = new Map<String, FlxGraphic>();
            sound = new Map<String, Sound>();
        } else {
            var keys = graphic.keys();
            for (key in keys) {
                if (StringTools.startsWith(key, prefix)) {
                    remove(key, IMAGE);
                }
            }
            
            var keys = sound.keys();
            for (key in keys) {
                if (StringTools.startsWith(key, prefix)) {
                    remove(key, SOUND);
                }
            }
        }
    }

    public function set(id:String, type:AssetType, asset:Dynamic) {
        switch (type) {
            case IMAGE: graphic.set(id, asset);
            case SOUND: sound.set(id, asset);
        }
    }

    public function get(id:String, type:AssetType):Dynamic {
        return switch (type) {
            case IMAGE: graphic.get(id);
            case SOUND: sound.get(id);
        }
    }

    public function remove(id:String, type:AssetType) {
        switch (type) {
            case IMAGE: graphic.remove(id);
            case SOUND: sound.remove(id);
        }
    }

    public function exists(id:String, type:AssetType) {
        return switch (type) {
            case IMAGE: graphic.exists(id);
            case SOUND: sound.exists(id);
        }
    }
}