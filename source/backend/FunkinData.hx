package backend;

import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxSave;

class FunkinData {
    public static var save:FlxSave; // probably not the best way of going about this but eh
    public static var data:Map<String, Dynamic>;
    public static var dataDefault:Map<String, Dynamic> = [
        'downScroll' => false,
        'ghostTapping' => false,
        'flashingLights' => true,
        'cameraZoom' => true,
        'unfocusPause' => true,
        'globalAntialiasing' => true,
        'maxFramerate' => 60
    ];

    public static var keyBinds:Map<String, Array<FlxKey>> = [ // borrowed from psych
		//Key Bind, Name for ControlsSubState
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
		'reset'			=> [R],
		
		'volume_mute'	=> [ZERO],
		'volume_up'		=> [NUMPADPLUS, PLUS],
		'volume_down'	=> [NUMPADMINUS, MINUS],
		
		'debug_1'		=> [SEVEN],
		'debug_2'		=> [EIGHT]
	];

	public static var gamepadBinds:Map<String, Array<FlxGamepadInputID>> = [
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

    public static function initialize() {
        save = new FlxSave();
        save.bind('prototype', 'fyridev');
        data = dataDefault;
        loadData();
    }

    public static function loadData() {
        for (key => value in data) {
            if (Reflect.getProperty(save.data, key) == null) {
                Reflect.setProperty(save.data, key, value);
            } else {
                data[key] = Reflect.getProperty(save.data, key);
            }
        }
    }

    public static function saveData() {
        for (key => value in data) {
            Reflect.setProperty(save.data, key, value);
        }
    }

    public static function setToDefault() {
        for (key => value in dataDefault) {
            Reflect.setProperty(save.data, key, value);
        }
        data = dataDefault;
    }
}