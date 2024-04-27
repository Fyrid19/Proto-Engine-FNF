// importing utils and more so i dont have to put the shit in every file!!
import utils.Paths;
import utils.FunkinUtil;
import utils.Highscore;

#if DISCORD
import utils.Discord;
#end

#if MODS
import utils.ModUtil;
#end

import funkin.states.PlayState;
import funkin.states.LoadingState;
import funkin.states.*;
import funkin.objects.*;

import shaders.*;

import backend.Controls;
import backend.Conductor;
import backend.FunkinData;
import backend.MusicBeatState;
import backend.MusicBeatSubstate;

// i gotta get rid of these two
import backend.FlxVideo;
import backend.SwagCamera;

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