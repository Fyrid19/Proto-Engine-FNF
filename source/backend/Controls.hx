package backend;

import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

enum InputType {
    PRESS;
    HOLD;
    RELEASE;
}

class ControlMap {
    // HOLD

    public var UI_LEFT(get, never):Bool;
    public var UI_UP(get, never):Bool;
    public var UI_DOWN(get, never):Bool;
    public var UI_RIGHT(get, never):Bool;

    public var NOTE_LEFT(get, never):Bool;
    public var NOTE_UP(get, never):Bool;
    public var NOTE_DOWN(get, never):Bool;
    public var NOTE_RIGHT(get, never):Bool;
    
    inline function get_UI_LEFT() return getInput('ui_left', HOLD);
    inline function get_UI_DOWN() return getInput('ui_down', HOLD);
    inline function get_UI_UP() return getInput('ui_up', HOLD);
    inline function get_UI_RIGHT() return getInput('ui_right', HOLD);

    inline function get_NOTE_LEFT() return getInput('note_left', HOLD);
    inline function get_NOTE_DOWN() return getInput('note_down', HOLD);
    inline function get_NOTE_UP() return getInput('note_up', HOLD);
    inline function get_NOTE_RIGHT() return getInput('note_right', HOLD);

    // PRESS

    public var UI_LEFT_P(get, never):Bool;
    public var UI_UP_P(get, never):Bool;
    public var UI_DOWN_P(get, never):Bool;
    public var UI_RIGHT_P(get, never):Bool;

    public var NOTE_LEFT_P(get, never):Bool;
    public var NOTE_UP_P(get, never):Bool;
    public var NOTE_DOWN_P(get, never):Bool;
    public var NOTE_RIGHT_P(get, never):Bool;

    inline function get_UI_LEFT_P() return getInput('ui_left', PRESS);
    inline function get_UI_DOWN_P() return getInput('ui_down', PRESS);
    inline function get_UI_UP_P() return getInput('ui_up', PRESS);
    inline function get_UI_RIGHT_P() return getInput('ui_right', PRESS);

    inline function get_NOTE_LEFT_P() return getInput('note_left', PRESS);
    inline function get_NOTE_DOWN_P() return getInput('note_down', PRESS);
    inline function get_NOTE_UP_P() return getInput('note_up', PRESS);
    inline function get_NOTE_RIGHT_P() return getInput('note_right', PRESS);

    // RELEASE

    public var UI_LEFT_R(get, never):Bool;
    public var UI_UP_R(get, never):Bool;
    public var UI_DOWN_R(get, never):Bool;
    public var UI_RIGHT_R(get, never):Bool;

    public var NOTE_LEFT_R(get, never):Bool;
    public var NOTE_UP_R(get, never):Bool;
    public var NOTE_DOWN_R(get, never):Bool;
    public var NOTE_RIGHT_R(get, never):Bool;

    inline function get_UI_LEFT_R() return getInput('ui_left', RELEASE);
    inline function get_UI_DOWN_R() return getInput('ui_down', RELEASE);
    inline function get_UI_UP_R() return getInput('ui_up', RELEASE);
    inline function get_UI_RIGHT_R() return getInput('ui_right', RELEASE);

    inline function get_NOTE_LEFT_R() return getInput('note_left', RELEASE);
    inline function get_NOTE_DOWN_R() return getInput('note_down', RELEASE);
    inline function get_NOTE_UP_R() return getInput('note_up', RELEASE);
    inline function get_NOTE_RIGHT_R() return getInput('note_right', RELEASE);

    // EXTRA

    public var RESET(get, never):Bool;
    public var ACCEPT(get, never):Bool;
    public var BACK(get, never):Bool;
    public var PAUSE(get, never):Bool;

    inline function get_RESET() return getInput('reset', PRESS);
    inline function get_ACCEPT() return getInput('accept', PRESS);
    inline function get_BACK() return getInput('back', PRESS);
    inline function get_PAUSE() return getInput('pause', PRESS);

    // THE FUNCTION OF ALL TIME

    function getInput(bindTag:String, input:InputType):Bool {
        var keyboard = Controls.keyBinds;
        var controller = Controls.controllerBinds;

        if (FlxG.keys.anyJustPressed([ANY])) {
            Controls.controllerActive = false;
        } else if (FlxG.gamepads.anyJustPressed(ANY)) {
            Controls.controllerActive = true;
        }

        return switch (input) {
            case HOLD: 
                FlxG.keys.anyPressed(keyboard[bindTag]) || getControllerInput(bindTag, input, controller[bindTag]);
            case PRESS: 
                FlxG.keys.anyJustPressed(keyboard[bindTag]) || getControllerInput(bindTag, input, controller[bindTag]);
            case RELEASE: 
                FlxG.keys.anyJustReleased(keyboard[bindTag]) || getControllerInput(bindTag, input, controller[bindTag]);
        }
    }

    function getControllerInput(bindTag:String, input:InputType, keyArray:Array<FlxGamepadInputID>):Bool {
        for (key in keyArray) {
            switch (input) {
                case HOLD:
                    if (FlxG.gamepads.anyPressed(key)) {
                        return true;
                    }
                case PRESS:
                    if (FlxG.gamepads.anyJustPressed(key)) {
                        return true;
                    }
                case RELEASE:
                    if (FlxG.gamepads.anyJustReleased(key)) {
                        return true;
                    }
            }
        }
        return false;
    }
}

class Controls {
    public static var controlMap:ControlMap;
    public static var controllerActive(default, set):Bool;
    public static var keyBinds:Map<String, Array<FlxKey>> = [
        'ui_left'       =>      [A, LEFT],
        'ui_up'         =>      [W, UP],
        'ui_down'       =>      [S, DOWN],
        'ui_right'      =>      [D, RIGHT],

        'note_left'     =>      [A, LEFT],
        'note_up'       =>      [W, UP],
        'note_down'     =>      [S, DOWN],
        'note_right'    =>      [D, RIGHT],
        
        'reset'         =>      [R],
        'accept'        =>      [ENTER],
        'back'          =>      [ESCAPE, BACKSPACE],
        'pause'         =>      [ENTER, ESCAPE]
    ];

    public static var controllerBinds:Map<String, Array<FlxGamepadInputID>> = [
        'ui_left'       =>      [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
        'ui_up'         =>      [DPAD_UP, LEFT_STICK_DIGITAL_UP],
        'ui_down'       =>      [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN],
        'ui_right'      =>      [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],

        'note_left'     =>      [X, LEFT_STICK_DIGITAL_LEFT, RIGHT_STICK_DIGITAL_LEFT],
        'note_up'       =>      [Y, LEFT_STICK_DIGITAL_UP, RIGHT_STICK_DIGITAL_UP],
        'note_down'     =>      [A, LEFT_STICK_DIGITAL_DOWN, RIGHT_STICK_DIGITAL_DOWN],
        'note_right'    =>      [B, LEFT_STICK_DIGITAL_RIGHT, RIGHT_STICK_DIGITAL_RIGHT],
        
        'reset'         =>      [BACK],
        'accept'        =>      [A, START],
        'back'          =>      [B, BACK],
        'pause'         =>      [START]
    ];
    
    static var oldValue:Bool;
    static function set_controllerActive(value:Bool) {
        if (oldValue != value) {
            trace('controller active: ' + value);
            oldValue = value;
        }
        return value;
    }
}