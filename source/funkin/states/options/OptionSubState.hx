package funkin.states.options;

import flixel.addons.display.FlxBackdrop;
import funkin.objects.ui.OptionItem;

class OptionSubState extends MusicBeatSubstate {
    var curOption:Int;

    var gridColor:FlxColor = OptionsStateNew.menuColor;
    var optionGroup:FlxTypedGroup<OptionItem>;
    var optionsList:Array<Option>;

    var bfGrid:FlxBackdrop;
    var optionBG:FlxSprite;
    var textBG:FlxSprite;

    var optionNameText:FlxText;
    var optionDescText:FlxText;

    public function new() {
        bfGrid = new FlxBackdrop(Paths.image('options/bgGrid'));
		bfGrid.setGraphicSize(Std.int(bfGrid.width * 0.5));
        bfGrid.velocity.set(50, 50);
        bfGrid.color = gridColor;
		bfGrid.updateHitbox();
		bfGrid.screenCenter(X);
		bfGrid.scrollFactor.set();
        bfGrid.alpha = 0;
        add(bfGrid);

        optionBG = new FlxSprite().loadGraphic(Paths.image('options/optionBG2'));
		optionBG.updateHitbox();
        optionBG.y = FlxG.height;
		optionBG.scrollFactor.set();
		add(optionBG);

        textBG = new FlxSprite().makeGraphic(FlxG.width, 38, FlxColor.BLACK);
		textBG.updateHitbox();
        textBG.y -= textBG.height;
		textBG.scrollFactor.set();
		add(textBG);

        optionNameText = new FlxText(0, 0, FlxG.width, "", 36);
		optionNameText.setFormat(Paths.font('vcr.ttf'), 36, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        optionNameText.y -= optionNameText.height;
        optionNameText.scrollFactor.set();
        add(optionNameText);

        optionDescText = new FlxText(0, 0, FlxG.width, "", 12);
		optionDescText.setFormat(Paths.font('vcr.ttf'), 12, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        optionDescText.y = FlxG.height;
        optionDescText.scrollFactor.set();
        add(optionDescText);

        FlxTween.tween(bfGrid, { alpha: 0.6 }, 1);
        FlxTween.tween(optionBG, { y: FlxG.height - optionBG.height }, 1, { ease: FlxEase.expoOut });
        FlxTween.tween(textBG, { y: 0 }, 1, { ease: FlxEase.expoOut });
        FlxTween.tween(optionNameText, { y: 2 }, 1, { ease: FlxEase.expoOut });
        FlxTween.tween(optionDescText, { y: FlxG.height - optionDescText.height - 2 }, 1, { ease: FlxEase.expoOut });

        super();
    }

    override function closeSubState() {
        FunkinData.saveData();

        for (obj in [bfGrid, optionBG, textBG, optionNameText, optionDescText]) {
            FlxTween.cancelTweensOf(obj);
        }

        FlxTween.tween(bfGrid, { alpha: 0 }, 1);
        FlxTween.tween(optionBG, { y: FlxG.height }, 1, { ease: FlxEase.expoIn });
        FlxTween.tween(textBG, { y: 0 - textBG.height }, 1, { ease: FlxEase.expoIn });
        FlxTween.tween(optionNameText, { y: 0 - optionNameText.height }, 1, { ease: FlxEase.expoOut });
        FlxTween.tween(optionDescText, { y: FlxG.height }, 1, { ease: FlxEase.expoIn });
        
        new FlxTimer().start(1, function(t:FlxTimer) {
            close();
        });
    }

    override function update(elapsed:Float) {
        if (controls.BACK) {
            closeSubState();
        }

        if (controls.UI_UP_P) {
            changeSelection(-1);
        }

        if (controls.UI_DOWN_P) {
            changeSelection(1);
        }

        super.update(elapsed);
    }

    function changeSelection(change:Int = 0, playSound:Bool = true) {
        if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'));

        curOption += change;

        if (curOption < 0)
            curOption = optionsList.length - 1;
        if (curOption > optionsList.length - 1)
            curOption = 0;
    }
}