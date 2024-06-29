package funkin.states.options;

import flixel.addons.display.FlxBackdrop;
import funkin.states.options.OptionItem.Option;

class OptionSubState extends MusicBeatSubstate {
    var gridColor:FlxColor = OptionsStateNew.menuColor;
    var optionGroup:FlxTypedGroup<OptionItem>;

    var bfGrid:FlxBackdrop;
    var optionBG:FlxSprite;
    var textBG:FlxSprite;

    var optionNameText:FlxText;
    var optionDescText:FlxText;

    var menuState:Bool = true;

    public function new(?menuState:Bool = true) {
        super();

        this.menuState = menuState;

        bfGrid = new FlxBackdrop(Paths.image('options/bgGrid'));
		bfGrid.setGraphicSize(Std.int(bfGrid.width * 0.5));
        bfGrid.velocity.set(50, 50);
        bfGrid.color = gridColor;
		bfGrid.updateHitbox();
		bfGrid.screenCenter(X);
		bfGrid.scrollFactor.set();
        bfGrid.alpha = 0;
        add(bfGrid);

        FlxTween.tween(bfGrid, { alpha: 0.6 }, 1);

        if (menuState) {
            optionBG = new FlxSprite().loadGraphic(Paths.image('options/optionBG2'));
            optionBG.updateHitbox();
            optionBG.y = FlxG.height;
            optionBG.scrollFactor.set();
            add(optionBG);

            textBG = new FlxSprite().makeGraphic(FlxG.width, 48, FlxColor.BLACK);
            textBG.updateHitbox();
            textBG.y = -textBG.height;
            textBG.scrollFactor.set();
            add(textBG);

            optionNameText = new FlxText(0, 0, FlxG.width, "", 48);
            optionNameText.setFormat(Paths.font('vcr.ttf'), 48, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            optionNameText.y = -optionNameText.height;
            optionNameText.scrollFactor.set();
            add(optionNameText);

            optionDescText = new FlxText(0, 0, FlxG.width, "", 24);
            optionDescText.setFormat(Paths.font('vcr.ttf'), 24, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            optionDescText.y = FlxG.height;
            optionDescText.scrollFactor.set();
            add(optionDescText);

            optionGroup = new FlxTypedGroup<OptionItem>();
            add(optionGroup);

            FlxTween.tween(optionBG, { y: FlxG.height - optionBG.height }, 1, { ease: FlxEase.expoOut });
            FlxTween.tween(textBG, { y: 0 }, 1, { ease: FlxEase.expoOut });
            FlxTween.tween(optionNameText, { y: 0 }, 1, { ease: FlxEase.expoOut });
            FlxTween.tween(optionDescText, { y: FlxG.height - optionDescText.height - 2 }, 1, { ease: FlxEase.expoOut });
        }
    }

    override function closeSubState() {
        FunkinData.saveData();

        FlxTween.cancelTweensOf(bfGrid);
        FlxTween.tween(bfGrid, { alpha: 0 }, 0.5);

        if (menuState) {
            for (obj in [optionBG, textBG, optionNameText, optionDescText]) {
                FlxTween.cancelTweensOf(obj);
            }

            FlxTween.tween(optionBG, { y: FlxG.height }, 0.5, { ease: FlxEase.expoIn });
            FlxTween.tween(textBG, { y: -textBG.height }, 0.5, { ease: FlxEase.expoIn });
            FlxTween.tween(optionNameText, { y: -optionNameText.height }, 0.5, { ease: FlxEase.expoIn });
            FlxTween.tween(optionDescText, { y: FlxG.height }, 0.5, { ease: FlxEase.expoIn });

            if (optionGroup.length > 0) {
                for (item in optionGroup) {
                    FlxTween.tween(item, { y: item.y + FlxG.height }, 0.5, { ease: FlxEase.expoIn });
                }
            }
        }
        
        new FlxTimer().start(0.5, function(t:FlxTimer) {
            close();
        });
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.BACK) {
            closeSubState();
        }
    }

    var id:Int = 0;
    function addOption(name:String, desc:String, variable:String, type:String) {
        var item:OptionItem = new OptionItem(0, 0, name);
        item.option = new Option(name, desc, variable, type);
        item.isMenuItem = true;
        item.targetY = id;
        optionGroup.add(item);
        id++;
    }
}