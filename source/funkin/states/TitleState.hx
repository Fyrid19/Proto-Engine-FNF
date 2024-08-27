package funkin.states;

import flixel.addons.transition.TransitionData;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.FlxTransitionSprite;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;

import openfl.Assets;
import openfl.display.Sprite;
import openfl.media.Video;
import openfl.net.NetStream;
import polymod.Polymod;

#if VIDEO_PLAYBACK
import hxvlc.flixel.FlxVideoSprite;
#end

#if desktop
import sys.FileSystem;
import sys.io.File;
import sys.thread.Thread;
#end

class TitleState extends MusicBeatState
{
	public static var initialized:Bool = false;
	var startedIntro:Bool;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;

	var curWacky:Array<String> = [];
	var wackyImage:FlxSprite;
	var lastBeat:Int = 0;
	var swagShader:ColorSwap;
	var alphaShader:BuildingShaders;
	var thingie:FlxSprite;

	var blackFG:FlxSprite;

	#if VIDEO_PLAYBACK
	var playingKickstarterVideo:Bool;
	var camVideo:FlxCamera;
	var kickstarter:FlxVideoSprite;
	#end

	override public function create():Void {
		startedIntro = false;

		swagShader = new ColorSwap();
		alphaShader = new BuildingShaders();

		curWacky = FlxG.random.getObject(getIntroTextShit());

		Paths.clearUnused();
		Paths.clearStored();

		#if DISCORD_RPC
		DiscordRPC.changePresence({details: 'In the menus'});
		#end

		// DEBUG BULLSHIT

		super.create();

		new FlxTimer().start(1, function(t) {
			startIntro();
			trace('intro started');
		});
	}

	var logoBl:FlxSprite;

	var gfDance:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;

	function startIntro() {
		if (!initialized)
		{
			var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
		}

		if (FlxG.sound.music == null || !FlxG.sound.music.playing || FlxG.sound.music.volume == 0)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			FlxG.sound.music.fadeIn(4, 0, 0.7);
		}

		Conductor.changeBPM(102);
		persistentUpdate = true;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		// bg.antialiasing = true;
		// bg.setGraphicSize(Std.int(bg.width * 0.6));
		// bg.updateHitbox();

		add(bg);

		logoBl = new FlxSprite(-150, -100);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		logoBl.antialiasing = true;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
		logoBl.animation.play('bump');

		logoBl.updateHitbox();

		logoBl.shader = swagShader.shader;
		// logoBl.shader = alphaShader.shader;

		// trace();
		// logoBl.screenCenter();
		// logoBl.color = FlxColor.BLACK;

		gfDance = new FlxSprite(FlxG.width * 0.4, FlxG.height * 0.07);
		gfDance.frames = Paths.getSparrowAtlas('gfDanceTitle');
		gfDance.animation.addByIndices('danceLeft', 'gfDance', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		gfDance.animation.addByIndices('danceRight', 'gfDance', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		gfDance.antialiasing = true;
		add(gfDance);

		gfDance.shader = swagShader.shader;

		add(logoBl);

		titleText = new FlxSprite(100, FlxG.height * 0.8);
		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.antialiasing = true;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		// titleText.screenCenter(X);
		add(titleText);

		var logo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('logo'));
		logo.screenCenter();
		logo.antialiasing = true;
		// add(logo);

		// FlxTween.tween(logoBl, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		// FlxTween.tween(logo, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		// var atlasBullShit:FlxSprite = new FlxSprite();
		// atlasBullShit.frames = FunkinUtil.fromAnimate(Paths.image('money'), Paths.file('images/money.json'));
		// credGroup.add(atlasBullShit);

		credTextShit = new Alphabet(0, 0, "ninjamuffin99\nPhantomArcade\nkawaisprite\nevilsk8er", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		ngSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('newgrounds_logo'));
		add(ngSpr);
		ngSpr.visible = false;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.8));
		ngSpr.updateHitbox();
		ngSpr.screenCenter(X);
		ngSpr.antialiasing = true;

		blackFG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackFG.alpha = 0;
		add(blackFG);

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		FlxG.mouse.visible = false;

		if (initialized)
			skipIntro();
		else
			initialized = true;

		startedIntro = true;
		// credGroup.add(credTextShit);

		#if VIDEO_PLAYBACK
		camVideo = new FlxCamera();
		add(camVideo);

		kickstarter = new FlxVideoSprite(0, 0);
		kickstarter.antialiasing = true;
		kickstarter.bitmap.onFormatSetup.add(function():Void 
		{
			if (kickstarter.bitmap != null && kickstarter.bitmap.bitmapData != null) 
			{
				var width:Float = kickstarter.bitmap.bitmapData.width;
				var height:Float = kickstarter.bitmap.bitmapData.height;
				final scale:Float = Math.min(FlxG.width / width, FlxG.height / height);
	
				kickstarter.setGraphicSize(width * scale, height * scale);
				kickstarter.updateHitbox();
				kickstarter.screenCenter();
			}
		});
		kickstarter.bitmap.onStopped.add(reset);
		kickstarter.bitmap.onEndReached.add(reset);
		add(kickstarter);
		#end
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;

	override function update(elapsed:Float)
	{
		#if debug
		if (FlxG.keys.justPressed.EIGHT)
			FlxG.switchState(new CutsceneAnimTestState());
		#end

		/* 
			if (FlxG.keys.justPressed.R)
			{
				#if polymod
				polymod.Polymod.init({modRoot: "mods", dirs: ['introMod']});
				trace('reinitialized');
				#end
			}

		 */

		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		var pressedEnter:Bool = controls.ACCEPT;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
				pressedEnter = true;
		}
		#end

		if (pressedEnter && !transitioning && skippedIntro #if VIDEO_PLAYBACK && !playingKickstarterVideo #end)
		{
			if (FlxG.sound.music != null)
				FlxG.sound.music.onComplete = null;

			titleText.animation.play('press');

			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

			transitioning = true;
			// FlxG.sound.music.stop();

			new FlxTimer().start(1, function(t) {
				FlxG.switchState(new MainMenuState());
			});
		}

		#if VIDEO_PLAYBACK
		if (pressedEnter && playingKickstarterVideo) {
			if (kickstarter != null) {
				// FlxTween.tween(kickstarter.bitmap, {volume: 0}, 1);
				FlxTween.tween(kickstarter, {alpha: 0}, 1, {onComplete: function(t:FlxTween) {
					reset();
				}});
			}
		}
		#end

		if (pressedEnter && !skippedIntro && initialized)
			skipIntro();

		if (controls.UI_LEFT)
			swagShader.update(-elapsed * 0.1);

		if (controls.UI_RIGHT)
			swagShader.update(elapsed * 0.1);

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.screenCenter(X);
			money.y += (i * 60) + 200;
			credGroup.add(money);
			textGroup.add(money);
		}
	}

	function addMoreText(text:String)
	{
		var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
		coolText.screenCenter(X);
		coolText.y += (textGroup.length * 60) + 200;
		credGroup.add(coolText);
		textGroup.add(coolText);
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	var isRainbow:Bool = false;

	override function beatHit()
	{
		super.beatHit();

		if (!startedIntro)
			return ;

		if (skippedIntro)
		{
			logoBl.animation.play('bump', true);

			danceLeft = !danceLeft;

			if (danceLeft)
				gfDance.animation.play('danceRight');
			else
				gfDance.animation.play('danceLeft');
		}
		else
		{
			FlxG.log.add(curBeat);
			// if the user is draggin the window some beats will
			// be missed so this is just to compensate
			if (curBeat > lastBeat)
			{
				for (i in lastBeat...curBeat)
				{
					switch (i + 1)
					{
						case 1:
							createCoolText(['Currently solo-developed by']);
						//	createCoolText(['ninjamuffin99', 'phantomArcade', 'kawaisprite', 'evilsk8er']);
						//  credTextShit.visible = true;
						case 3:
							addMoreText('FyriDev');
						//  credTextShit.text += '\npresent...';
						//  credTextShit.addText();
						case 4:
							deleteCoolText();
						//  credTextShit.visible = false;
						//  credTextShit.text = 'In association \nwith';
						//  credTextShit.screenCenter();
						case 5:
							createCoolText(['Not in association', 'with']);
						case 7:
							addMoreText('newgrounds');
							ngSpr.visible = true;
						// credTextShit.text += '\nNewgrounds';
						case 8:
							deleteCoolText();
							ngSpr.visible = false;
						// credTextShit.visible = false;

						// credTextShit.text = 'Shoutouts Tom Fulp';
						// credTextShit.screenCenter();
						case 9:
							createCoolText([curWacky[0]]);
						// credTextShit.visible = true;
						case 11:
							addMoreText(curWacky[1]);
						// credTextShit.text += '\nlmao';
						case 12:
							deleteCoolText();
						// credTextShit.visible = false;
						// credTextShit.text = "Friday";
						// credTextShit.screenCenter();
						case 13:
							addMoreText('Friday');
						// credTextShit.visible = true;
						case 14:
							addMoreText('Night');
						// credTextShit.text += '\nNight';
						case 15:
							addMoreText('Funkin'); // credTextShit.text += '\nFunkin';

						case 16:
							skipIntro();
					}
				}
			}
			lastBeat = curBeat;
		}
	}

	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(ngSpr);

			FlxG.camera.flash(FlxColor.WHITE, 4);
			remove(credGroup);
			skippedIntro = true;

			#if VIDEO_PLAYBACK
			new FlxTimer().start(10, function(t) {
				transitionToKickstarter();
				trace('kickstarter video');
			});
			#end
		}
	}

	#if VIDEO_PLAYBACK
	function transitionToKickstarter() {
		FlxG.sound.music.fadeOut(1);
		FlxTween.tween(blackFG, {alpha: 1}, 1, {onComplete: function(t) showKickstarterVideo()});
	}

	function showKickstarterVideo() {
		if (kickstarter != null) {
			playingKickstarterVideo = true;

			kickstarter.bitmap.volume = Std.int(FlxG.sound.volume);
			// kickstarter.cameras = [camVideo];

			if (kickstarter.load(Paths.video('kickstarterTrailer'))) {
				kickstarter.play();
				trace('video playing');
			}
		} else {
			trace('shit null bruh');
		}
	}

	private function reset() {
		playingKickstarterVideo = false;
		initialized = false;
		kickstarter.destroy();
		// blackFG.alpha = 0;
		FlxG.resetState();
	}
	#end
}
