// importing utils and more so i dont have to put the shit in every file!!
#if discord_rpc
import utils.Discord;
#end

import utils.Paths;
import utils.FunkinUtil;
import utils.Highscore;
import utils.InputFormatter;
import utils.PlayerSettings;

import funkin.states.PlayState;
import funkin.states.LoadingState;
import funkin.states.*;
import funkin.objects.*;
import funkin.objects.ui.*;
import funkin.ui.PreferencesMenu;

import shaders.*;

import backend.Controls;
import backend.Conductor;
import backend.MusicBeatState;
import backend.MusicBeatSubstate;
import backend.FunkinData;
import backend.EngineMain;

import backend.SwagCamera;

import openfl.Lib;

import lime.app.Application;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;