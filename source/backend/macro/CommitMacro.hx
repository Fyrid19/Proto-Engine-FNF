package source.backend.macro; // stolen from funkin rewrite, technically not stealing since its mine lol

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
#if sys
import sys.io.Process;
#end
#end

class CommitMacro {
    public static var curCommit(get, null):Int;
    public static var curCommitHash(get, null):String;

    private static inline function get_curCommit():Int
        return _getCommitNum();

    private static inline function get_curCommitHash():String
        return _getCommitHash();

    #if !display
    private static macro function _getCommitNum() {
        var commit:Int;
        final proc:Process = new Process('git', ['rev-list', 'HEAD', '--count']);
        if (proc.exitCode() != 0) {
            var message = proc.stderr.readAll().toString();
            var pos = haxe.macro.Context.currentPos();
            haxe.macro.Context.error("Cannot execute `git rev-list HEAD --count`. " + message, pos);
        }

        commit = Std.parseInt(proc.stdout.readLine());
        return macro $v{commit};
    }

    private static macro function _getCommitHash() {
        var hash:String;
        final proc:Process = new Process('git', ['rev-parse', '--short', 'HEAD']);
        if (proc.exitCode() != 0) {
            var message = proc.stderr.readAll().toString();
            var pos = haxe.macro.Context.currentPos();
            haxe.macro.Context.error("Cannot execute `git rev-parse --short HEAD`. " + message, pos);
        }

        hash = proc.stdout.readLine();
        return macro $v{hash};
    }
    #else
    private static macro function _getCommitNum() {
        var commit:Int = 0;
        return macro $v{commit};
    }

    private static macro function _getCommitHash() {
        var hash:String = "";
        return macro $v{hash};
    }
    #end
}