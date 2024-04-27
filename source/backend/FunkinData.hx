package backend;

import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

class FunkinData {
    public static var downScroll:Data;
    public static var ghostTapping:Data;
    public static var flashingLights:Data;
    public static var cameraZoom:Data;
    public static var unfocusPause:Data;
    public static var globalAntialiasing:Data;
    public static var maxFramerate:Data;

    public static var keybinds:Map<String, Array<FlxKey>> = [
        'note_up'		=> [W, UP],
		'note_left'		=> [A, LEFT],
		'note_down'		=> [S, DOWN],
		'note_right'	=> [D, RIGHT],
		
		'ui_up'			=> [W, UP],
		'ui_left'		=> [A, LEFT],
		'ui_down'		=> [S, DOWN],
		'ui_right'		=> [D, RIGHT],
		
		'accept'		=> [SPACE, ENTER],
		'back'			=> [BACKSPACE, ESCAPE],
		'pause'			=> [ENTER, ESCAPE],
		'reset'			=> [R]
    ];
    
	public static var gamepadbinds:Map<String, Array<FlxGamepadInputID>> = [
		'note_up'		=> [DPAD_UP, Y],
		'note_left'		=> [DPAD_LEFT, X],
		'note_down'		=> [DPAD_DOWN, A],
		'note_right'	=> [DPAD_RIGHT, B],
		
		'ui_up'			=> [DPAD_UP, LEFT_STICK_DIGITAL_UP],
		'ui_left'		=> [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
		'ui_down'		=> [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN],
		'ui_right'		=> [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],
		
		'accept'		=> [A, START],
		'back'			=> [B],
		'pause'			=> [START],
		'reset'			=> [BACK]
	];

    public static function init() {
        loadData();
        loadKeybinds();
    }

    public static function loadData() {
        downScroll = new Data('downScroll', false);
        ghostTapping = new Data('ghostTapping', false);
        flashingLights = new Data('flashingLights', false);
        cameraZoom = new Data('cameraZoom', false);
        unfocusPause = new Data('unfocusPause', true);
        globalAntialiasing = new Data('globalAntialiasing', true);
        maxFramerate = new Data('maxFramerate', 60);

        trace('Preferences have been loaded!');
    }

    // hoping this doesnt cause problems
    public static function getDataValue(data:String):Dynamic {
        var dataVar:Data = Reflect.getProperty(FunkinData, data);

        if (dataVar != null) {
            return dataVar.getValue();
        } else {
            trace('No data found.');
            return null;
        }
    }

    public static function setDataValue(data:String, value:Dynamic) {
        var dataVar:Data = Reflect.getProperty(FunkinData, data);

        if (dataVar != null) {
            dataVar.changeValue(value);
        } else {
            trace('No data found.');
        }
    }

    public static function loadKeybinds() {
        if (FlxG.save.data.controls != null) {
            keybinds = FlxG.save.data.controls;
        } else {
            FlxG.save.data.controls = keybinds;
        }

        if (FlxG.save.data.gamepadControls != null) {
            gamepadbinds = FlxG.save.data.gamepadControls;
        } else {
            FlxG.save.data.gamepadControls = gamepadbinds;
        }
    }

    public static function saveKeybinds() {
        FlxG.save.data.controls = keybinds;
        FlxG.save.data.gamepadControls = gamepadbinds;
    }
}

class Data {
    public var dataTag:String;
    public var defaultValue:Dynamic;
    public var value:Dynamic;

    public function new(tag:String, defaultValue:Dynamic) {
        this.defaultValue = defaultValue;
        this.dataTag = tag;
        init();
    }

    private function init() {
        var saveValue:Dynamic;
        saveValue = Reflect.getProperty(FlxG.save.data, this.dataTag);

        if (saveValue != null) {
            this.value = saveValue;
        } else {
            this.value = this.defaultValue;
            saveValue();
        }
    }

    public function changeValue(newValue:Dynamic) {
        this.value = newValue;
        saveValue();
    }

    public function changeToDefault() {
        this.value = this.defaultValue;
        saveValue();
    }

    public function saveValue() {
        Reflect.setProperty(FlxG.save.data, this.dataTag, this.defaultValue);
    }

    public function getValue() {
        var curValue:Dynamic;
        curValue = Reflect.getProperty(FlxG.save.data, this.dataTag);
        return curValue;
    }
}