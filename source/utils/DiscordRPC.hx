package utils;

import hxdiscord_rpc.Discord;
import hxdiscord_rpc.Types;
import sys.thread.Thread;

#if DISCORD_RPC
@:structInit class PresenceDetails {
    public var state:String = "";
    public var details:String = "";
    public var largeImageKey:String = "logo";
    public var largeImageText:String = "Protoype Engine Version: " + EngineMain.engineVer;
    public var smallImageKey:String = "";
    public var smallImageText:String = "";
    public var hasStartTimestamp:Bool = false;
    public var endTimestamp:Float = 0;
}

class DiscordRPC {
    public static var initialized:Bool = false;
    private static final defaultID:String = "1233843000283762739";
    public static var clientID:String = defaultID;
    private static var presence:DiscordRichPresence = DiscordRichPresence.create();

    public static function init() {
        setupClient();
        Application.current.onExit.add(function(e) {
            if (initialized) shutdownClient();
        });
        Thread.create(() -> {
			while (true) {
				#if DISCORD_DISABLE_IO_THREAD
				Discord.UpdateConnection();
				#end
				Discord.RunCallbacks();

				// Wait 2 seconds until the next loop...
				Sys.sleep(2);
			}
		});
    }

    public static function changePresence(params:PresenceDetails) {
        var startTimestamp:Float = 0;
        if (params.hasStartTimestamp) startTimestamp = Date.now().getTime();
        var realEndTimestamp:Float = params.endTimestamp;
        if (realEndTimestamp > 0) realEndTimestamp = startTimestamp + realEndTimestamp;
        
        presence.state = params.state;
        presence.details = params.details;
        presence.largeImageKey = params.largeImageKey;
        presence.largeImageText = params.largeImageText;
        presence.smallImageKey = params.smallImageKey;
        presence.smallImageText = params.smallImageText;
        presence.startTimestamp = formatTimestamp(startTimestamp);
        presence.endTimestamp = formatTimestamp(realEndTimestamp);
        updatePresence();
    }

    public static function changeClientID(newID:String) {
        clientID = newID;
        resetClient();
    }

    public static function resetClient() {
        shutdownClient();
        setupClient();
    }

    public static function shutdownClient() {
        Discord.Shutdown();
        initialized = false;
    }

    public static function updatePresence()
		Discord.UpdatePresence(cpp.RawConstPointer.addressOf(presence));

    inline static function formatTimestamp(timestamp:Float)
        return Std.int(timestamp / 1000); // formatted into milliseconds for discord to use
    
    private static function setupClient(?params:PresenceDetails = null) {
        var handlers:DiscordEventHandlers = DiscordEventHandlers.create();
		handlers.ready = cpp.Function.fromStaticFunction(onReady);
		handlers.disconnected = cpp.Function.fromStaticFunction(onDisconnected);
		handlers.errored = cpp.Function.fromStaticFunction(onError);
		Discord.Initialize(clientID, cpp.RawPointer.addressOf(handlers), 1, null);
        if (params != null) changePresence(params) else changePresence({});
        initialized = true;
    }

    private static function onReady(request:cpp.RawConstPointer<DiscordUser>):Void {
		if (Std.parseInt(cast(request[0].discriminator, String)) != 0)
			Sys.println('Discord: Connected to user (${cast(request[0].username, String)}#${cast(request[0].discriminator, String)})');
		else
			Sys.println('Discord: Connected to user (${cast(request[0].username, String)})');

		changePresence({});
        updatePresence();
	}

	private static function onDisconnected(errorCode:Int, message:cpp.ConstCharStar):Void
		Sys.println('Discord: Disconnected ($errorCode: ${cast(message, String)})');

	private static function onError(errorCode:Int, message:cpp.ConstCharStar):Void 
		Sys.println('Discord: Error ($errorCode: ${cast(message, String)})');
}
#end