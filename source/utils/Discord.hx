package utils;

import Sys.sleep;
import hxdiscord_rpc.Discord;
import hxdiscord_rpc.Types;

class DiscordClient {
	public static var clientID:String = "1233843000283762739";
	public static var initialized:Bool;
	private static var presence:DiscordRichPresence = DiscordRichPresence.create();

	private static function onReady(request:cpp.RawConstPointer<DiscordUser>):Void {
		if (Std.parseInt(cast(request[0].discriminator, String)) != 0)
			Sys.println('Discord: Connected to user (${cast(request[0].username, String)}#${cast(request[0].discriminator, String)})');
		else
			Sys.println('Discord: Connected to user (${cast(request[0].username, String)})');

		changePresence();
	}

	private static function onDisconnected(errorCode:Int, message:cpp.ConstCharStar):Void {
		Sys.println('Discord: Disconnected ($errorCode: ${cast(message, String)})');
	}

	private static function onError(errorCode:Int, message:cpp.ConstCharStar):Void {
		Sys.println('Discord: Error ($errorCode: ${cast(message, String)})');
	}

	public static function initialize() {
		var rpcHandler:DiscordEventHandlers = DiscordEventHandlers.create();
		rpcHandler.ready = cpp.Function.fromStaticFunction(onReady);
		rpcHandler.disconnected = cpp.Function.fromStaticFunction(onDisconnected);
		rpcHandler.errored = cpp.Function.fromStaticFunction(onError);
		Discord.Initialize(clientID, cpp.RawPointer.addressOf(rpcHandler), 1, null);

		sys.thread.Thread.create(() -> {
			while (true)
			{
				#if DISCORD_DISABLE_IO_THREAD
				Discord.UpdateConnection();
				#end
				Discord.RunCallbacks();

				// Wait 1 second until the next loop...
				Sys.sleep(1);
			}
		});
		
		initialized = true;
	}

	public static function changePresence(?state:String, ?details:String, ?smallImageKey:String, ?hasStartTimestamp:Bool, ?endTimestamp:Float) {
		var startTimestamp:Float = 0;
		if (hasStartTimestamp) startTimestamp = Date.now().getTime();
		if (endTimestamp > 0) endTimestamp = startTimestamp + endTimestamp;

		presence.state = state;
		presence.details = details;
		presence.largeImageKey = 'logo';
		presence.largeImageText = "Prototype Engine v" + Application.current.meta.get('version');
		presence.smallImageKey = smallImageKey;
		presence.startTimestamp = Std.int(startTimestamp / 1000);
		presence.endTimestamp = Std.int(endTimestamp / 1000);
		updatePresence();
	}

	public static function changePresenceLargeIcon(largeImageKey:String = '', ?largeImageText:String = null) {
		presence.largeImageKey = largeImageKey;
		if (largeImageText != null) presence.largeImageText = largeImageText;
		updatePresence();
	}

	public static function updatePresence() {
		Discord.UpdatePresence(cpp.RawConstPointer.addressOf(presence));
	}

	public static function setClientID(newID:String) {
		var changedID:Bool = (clientID != newID);
		clientID = newID;

		if (changedID && initialized) {
			shutdown();
			initialize();
			updatePresence();
		}
	}

	public static function shutdown() {
		if (initialized) {
			Discord.Shutdown();
			initialized = false;
		} else {
			trace('Discord RPC is already down!');
		}
	}
}
