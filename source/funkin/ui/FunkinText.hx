package funkin.ui;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.display.Sprite;

enum abstract TextAlignment(String) from String {
    var LEFT:String = 'left';
    var CENTER:String = 'center';
    var RIGHT:String = 'right';
    var JUSTIFY:String = 'justify';
    public static function fromOpenFl(align:TextFormatAlign) {
        return switch (align) {
            case TextFormatAlign.LEFT: LEFT;
            case TextFormatAlign.CENTER: CENTER;
            case TextFormatAlign.RIGHT: RIGHT;
            case TextFormatAlign.JUSTIFY: JUSTIFY;
            default: LEFT;
        }
    }
    public static function toOpenFl(align:TextAlignment) {
        return switch (align) {
            case TextAlignment.LEFT: TextFormatAlign.LEFT;
            case TextAlignment.CENTER: TextFormatAlign.CENTER;
            case TextAlignment.RIGHT: TextFormatAlign.RIGHT;
            case TextAlignment.JUSTIFY: TextFormatAlign.JUSTIFY;
            default: TextFormatAlign.LEFT;
        }
    }
}

// loosely based off of flxtext
@:access(openfl.text.TextField)
class FunkinText extends Sprite {
    public var textField:TextField;

    public var text(get, set):String;
    public var fieldWidth(get, set):Float;
    public var color(get, set):Int;
    public var textSize(get, set):Int;
    public var letterSpacing(get, set):Float;
    public var textFont(get, set):String;
    public var alignment(get, set):TextAlignment;
    public var hasOutline:Int;
    public var outlineColor:Int;

    function get_text() {
        return textField != null ? textField.text : '';
    }

    function set_text(t:String) {
        text = textField != null ? t : '';
        return textField.text = text;
    }

    function get_fieldWidth() {
        return textField != null ? textField.width : 0;
    }

    function set_fieldWidth(w:Float) {
        fieldWidth = textField != null ? w : 0;
		return textField.width = w;
	}

    function get_color() {
        return textField != null ? textField.textColor : 0xFFFFFF;
    }

    function set_color(c:Int) {
        color = textField != null ? c : 0xFFFFFF;
        return textField.textColor = c;
    }

    function get_textSize() {
        return textField != null ? textField.getTextFormat().size : 0;
    }

    function set_textSize(s:Int) {
        textSize = textField != null ? s : 0;
        return textField.getTextFormat().size = s;
    }

    function get_textFont() {
        return textField != null ? textField.getTextFormat().font : Paths.defaultFont;
    }

    function set_textFont(f:String) {
        textFont = textField != null ? f : Paths.defaultFont;
        return textField.getTextFormat().font = f;
    }

    function get_letterSpacing() {
        return textField != null ? textField.getTextFormat().letterSpacing : 0;
    }

    function set_letterSpacing(l:Float) {
        letterSpacing = textField != null ? l : 0;
        return textField.getTextFormat().letterSpacing = l;
    }

    function get_alignment() {
        return textField != null ? TextAlignment.fromOpenFl('', textField.getTextFormat().align) : LEFT;
    }

    function set_alignment(a:TextAlignment) {
        alignment = textField != null ? a : LEFT;
        return textField.getTextFormat().align = TextAlignment.toOpenFl(a);
    }

    public function new(x:Float, y:Float, ?fieldWidth:Float, ?text:String, ?size:Int = 12, ?alignment:TextAlignment = 'left', ?embedFont:Bool = true) {
        super(x, y);
        this.text = text != null ? text : '';
        this.alignment = alignment;
        this.fieldWidth = fieldWidth;

        textField = new TextField();
        textField.selectable = false;
        textField.multiline = true;
        textField.wordWrap = true;
        textField.embedFonts = embedFont;
        textField.text = text;
        textField.sharpness = 100;

        textFont = Paths.defaultFont;
        var _defaultFormat:TextFormat;
        _defaultFormat = new TextFormat(null, size, 0xFFFFFF);
		textField.defaultTextFormat = _defaultFormat;

        switch (alignment) {
            case LEFT: textField.autoSize = LEFT;
            case RIGHT: textField.autoSize = RIGHT;
            case CENTER: textField.autoSize = CENTER;
            default: textField.autoSize = LEFT;
        }
    }

    override public function destroy() {
        textField = null;
        super.destroy();
    }

    public function formatText(?font:String, size:Int, color:Int, ?alignment:TextAlignment, ?hasOutline:Bool, ?outlineColor:Int) {
        this.textFont = font;
        this.textSize = size;
        this.color = color;
        this.alignment = alignment;
        this.hasOutline = hasOutline;
        this.outlineColor = outlineColor;
    }
}