package funkin.states;

class WarningState extends MusicBeatState {
    var background:FlxSprite;
    var versionInfoTxt:FlxText;
    var warningTxt:FlxText;
    var warningTxt2:FlxText;
    var logoPlaceholder:FlxText;

    override function create() {
        super.create();

        background = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
        background.screenCenter();
        add(background);

        warningTxt = new FlxText(0, 5, FlxG.width, '!! WARNING !!', 64);
        warningTxt.setFormat(Paths.defaultFont, 64, FlxColor.RED, CENTER, OUTLINE_FAST, FlxColor.BLACK);
        add(warningTxt);

        versionInfoTxt = new FlxText(0, 0, FlxG.width, '', 24);
        versionInfoTxt.setFormat(Paths.defaultFont, 24, FlxColor.WHITE, CENTER, OUTLINE_FAST, FlxColor.BLACK);
        versionInfoTxt.y = warningTxt.y + warningTxt.height + 5;
        versionInfoTxt.text = 'Version: ${EngineMain.engineVer} | Current Commit: ${EngineMain.getRepoCommits()}';
        add(versionInfoTxt);

        warningTxt2 = new FlxText(0, 0, FlxG.width, '', 32);
        warningTxt2.setFormat(Paths.defaultFont, 32, FlxColor.WHITE, CENTER, OUTLINE_FAST, FlxColor.BLACK);
        
        warningTxt2.text += "This engine is in active development, by one developer for that matter.\n";
        warningTxt2.text += "There WILL be broken things, and some things that just aren't there yet.\n";
        warningTxt2.text += "Nothing is final, everything is subject to change.\n\n";
        warningTxt2.text += "With that being said, I present to you:";

        warningTxt2.screenCenter();
        add(warningTxt2);

        logoPlaceholder = new FlxText(0, 0, FlxG.width, '- PROTOTYPE ENGINE -', 46);
        logoPlaceholder.setFormat(Paths.defaultFont, 46, FlxColor.CYAN, CENTER, OUTLINE_FAST, FlxColor.BLACK);
        logoPlaceholder.y = warningTxt2.y + warningTxt2.height + 10;
        add(logoPlaceholder);

        var confirmationTxt:FlxText = new FlxText(0, 0, FlxG.width, 'Press ACCEPT to proceed', 64);
        confirmationTxt.setFormat(Paths.defaultFont, 64, FlxColor.BLUE, CENTER, OUTLINE_FAST, FlxColor.BLACK);
        confirmationTxt.y = FlxG.height - confirmationTxt.height - 5;
        add(confirmationTxt);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.ACCEPT) {
            trace('going to title');
            FlxG.switchState(new TitleState());
        }
    }
}