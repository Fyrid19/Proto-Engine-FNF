package backend;

class Globals {
    public static final WINDOW_TITLE:String = "Friday Night Funkin': Prototype Engine";

    public static final ENGINE_VERSION_MAJOR:Int = 0;
    public static final ENGINE_VERSION_MINOR:Int = 0;
    public static final ENGINE_VERSION_PATCH:Int = 0;
    public static final ENGINE_VERSION_STRING:String = "INDEV";

    public static final SAVE_PATH:String = "FyriDev";

    public static final COMMIT_NUMBER:Int = backend.macro.CommitMacro.curCommit;
    public static final COMMIT_HASH:String = backend.macro.CommitMacro.curCommitHash;
}