package funkin.states.options.sections;

class GameplayOptions extends OptionSubState {
    var curSelected:Int = 0;
    var menuList:Array<Array<String>> = [
        [
            'Downscroll',
            'If true, arrows scroll down instead of up.',
            'downScroll',
            'bool'
        ],
        [
            'Ghost Tapping',
            'If true, there will be no penalty for spamming.',
            'ghostTapping',
            'bool'
        ],
        [
            'Camera Zoom on Beat',
            'If true, the camera won\'t zoom in on a beat hit.',
            'cameraZoom',
            'bool'
        ]
    ];

    public function new() {
        super(true);

        for (i in 0...menuList.length) {
            addOption(menuList[i][0], menuList[i][1], menuList[i][2], menuList[i][3]);
        }

        changeSelection(0, false);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.UI_UP_P) {
            changeSelection(-1);
        }

        if (controls.UI_DOWN_P) {
            changeSelection(1);
        }
    }

    function changeSelection(change:Int = 0, playSound:Bool = true) {
        if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'));

        curSelected += change;

        if (curSelected < 0)
            curSelected = optionGroup.length - 1;
        if (curSelected > optionGroup.length - 1)
            curSelected = 0;

        var bullShit:Int = 0;

        for (item in optionGroup)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
				item.alpha = 1;
		}

        optionNameText.text = menuList[curSelected][0];
        optionDescText.text = menuList[curSelected][1];
    }
}