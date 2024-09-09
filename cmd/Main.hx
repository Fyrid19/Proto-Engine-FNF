package;

typedef HaxelibData = {
    name:String,
    version:String,
    git:String
}

class Main {
    public static var haxelibs = sys.io.File.getContent('cmd/data/haxelibs.json');
    public static var haxelibsParsed:Dynamic;
    public static var libraries:Array<HaxelibData>;
    public static function main() {
        var args:Array<String> = ['', '', ''];
        haxelibsParsed = haxe.Json.parse(haxelibs);
        libraries = haxelibsParsed.libraries;

        for (lib in libraries) {
            var install:String = 'install';
            var version:String = null;
            var git:String = null;

            if (lib.git.length > 1) {
                install = 'git';
                git = lib.git;
            }

            if (lib.version.length > 1) {
                version = lib.version;
            }

            if (git != null) args = [install, lib.name, git]; // haxelib git [name] [link]
            else if (version != null) args = [install, lib.name, version]; // haxelib install [name] [version]
            else args = [install, lib.name]; // haxelib install [name]

            var quiet:Array<String>;
            for (i in 0...args.length)
                quiet.push(args[i]);
            quiet.push('--quiet');

            // Sys.println(quiet);
            Sys.command('haxelib', quiet);
        }
    }
}