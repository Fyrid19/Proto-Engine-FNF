package funkin.game.objects;

class BackgroundGirls extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		// BG fangirls dissuaded
		frames = Paths.getSparrowAtlas('weeb/bgFreaks');

		animation.addByIndices('danceLeft', 'BG girls group', FunkinUtil.numberArray(14), "", 24, false);
		animation.addByIndices('danceRight', 'BG girls group', FunkinUtil.numberArray(30, 15), "", 24, false);

		animation.play('danceLeft');
		animation.finish();
	}

	var danceDir:Bool = false;

	public function getScared():Void
	{
		animation.addByIndices('danceLeft', 'BG fangirls dissuaded', FunkinUtil.numberArray(14), "", 24, false);
		animation.addByIndices('danceRight', 'BG fangirls dissuaded', FunkinUtil.numberArray(30, 15), "", 24, false);
		dance();
		animation.finish();
	}

	public function dance():Void
	{
		danceDir = !danceDir;

		if (danceDir)
			animation.play('danceRight', true);
		else
			animation.play('danceLeft', true);
	}
}
