package backend.focus;

import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.text.TextField;
import openfl.text.TextFormat;

class FocusLost extends Sprite {
    var _text:TextField;
    var bg:Bitmap;
    var textFont:String;

    public function new() {
        super();

        textFont = Assets.getFont('assets/fonts/vcr.ttf').fontName;

        var _bitmap:BitmapData = new BitmapData(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight, false, 0x000000);
        bg = new Bitmap(_bitmap);
        bg.alpha = 0.6;
        addChild(bg);

        _text = new TextField();
        _text.autoSize = CENTER;
        _text.multiline = false;
        _text.defaultTextFormat = new TextFormat(textFont, 64, 0xFFFFFF);
        _text.text = 'FOCUS LOST';
        addChild(_text);
    }

    public override function __enterFrame(d:Int) {
        _text.y = Lib.current.stage.stageHeight/2 - _text.height/2;
        _text.x = Lib.current.stage.stageWidth/2 - _text.width/2;
    }
}