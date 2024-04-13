// importing utils and more so i dont have to put the shit in every file!!
import utils.Paths;
import utils.Conductor;
import utils.CoolUtil;
import utils.Controls;
#if discord_rpc
import utils.Discord;
#end
import utils.Highscore;
import utils.InputFormatter;
import utils.PlayerSettings;
import funkin.states.PlayState;
import funkin.states.LoadingState;
import funkin.states.*;
import funkin.objects.*;
import shaders.*;

import general.MusicBeatState;
import general.MusicBeatSubstate;

import general.FlxVideo;
import general.SwagCamera;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

using StringTools;