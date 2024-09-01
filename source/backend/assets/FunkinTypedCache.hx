package backend.assets;

class FunkinTypedCache<T> {
    public var cache:Map<String, T> = [];
    public var backupCache:Map<String, T> = [];

    public function new() {
        cache = new Map<String, T>();
        backupCache = new Map<String, T>();
    }

    public function clear() {
        backupCache = cache;
        cache = [];
        trace('Typed cache cleared');
    }

    public function add(key:String, asset:T) {
        if (cache.exists(key)) {
            trace('Asset already in cache');
            return;
        }

        if (backupCache.exists(key)) {
            var backupAsset:T = backupCache.get(key);
            cache.set(key, backupAsset);
            backupCache.remove(key);
            return;
        }

        cache.set(key, asset);
    }

    public function get(key:String):T {
        if (!cache.exists(key)) {
            trace("Can't find asset: " + key);
            return null;
        }
        return cache.get(key);
    }

    public function remove(key:String)
        if (cache.exists(key)) cache.remove(key);

    public function exists(key:String)
        return cache.exists(key);
}