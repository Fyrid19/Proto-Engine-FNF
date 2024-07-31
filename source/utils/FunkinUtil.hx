package utils;

import lime.utils.Assets;
import lime.system.System;

import haxe.Exception;

class FunkinUtil
{
	public static var difficultyArray:Array<String> = ['EASY', 'NORMAL', 'HARD'];

	public static function difficultyString():String
	{
		return difficultyArray[PlayState.storyDifficulty];
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	/**
		Lerps camera, but accountsfor framerate shit?
		Right now it's simply for use to change the followLerp variable of a camera during update
		TODO LATER MAYBE:
			Actually make and modify the scroll and lerp shit in it's own function
			instead of solely relying on changing the lerp on the fly
	 */
	public static function camLerpShit(lerp:Float):Float
	{
		return lerp * (FlxG.elapsed / (1 / 60));
	}

	public static function switchState(next:Dynamic = null) {
		if (next == null) {
			refreshState();
			return;
		}
		FlxG.switchState(next);
	}

	public static function refreshState() {
		FlxG.resetState();
	}

	public static function formatMemory(mem:Float) {
		return flixel.util.FlxStringUtil.formatBytes(mem);
	}

	public static function forceCrash(?msg:String = 'No message provided (forced crash)') {
		throw msg; // yeah, thats it, crazy i know
	}
}