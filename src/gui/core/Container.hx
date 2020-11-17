package gui.core;

import gui.events.ControlEventType;
import haxe.ds.List;

class Container extends Control {

    // ** Publics.

    public var controls(get, null):List<Control>;

    // ** Privates.

    /** @private **/ private var __controls:List<Control> = new List<Control>();

    public function new(width:Float, height:Float, x:Float, y:Float) {
        
        __width = width;

        __height = height;

        super(x, y);
    }

    override function init():Void {

        super.init();

        for (control in __controls) {

            __initControl(control);
        }
    }

    override function release():Void {

        super.release();
    }

    public function addControl(control:Control):Control {
        
        if (control.active) return control;

        if (____canvas != null) {
			
			__initControl(control);
		}

        __controls.add(control);

        control.dispatchEvent({timestamp: 0, control: control}, ADDED);

        return control;
    }

    public function removeControl(control:Control):Void {

        control.dispatchEvent({timestamp: 0, control: control}, REMOVED);

        control.release();

		__controls.remove(control);
    }

    override function update():Void {

        for (control in __controls) {

            if (control.hitTest()) {

                control.update();

                return;
            }
        }

        super.update();
    }

    override function onMouseEnter():Void {

        super.onMouseEnter();
    }

    override function onMouseLeave():Void {

        super.onMouseLeave();
    }

    override function onMouseHover():Void {

        super.onMouseHover();
    }
    
    private function __initControl(control:Control) {
        
        @:privateAccess control.____canvas = ____canvas;

        @:privateAccess control.____offsetX = __x + ____offsetX;
		
        @:privateAccess control.____offsetY = __y + ____offsetY;
        
        @:privateAccess control.____parent = this;

        control.init();

        control.dispatchEvent({timestamp: 0, control: this}, INIT);
    }

    // ** Getters and setters.

    private function get_controls():List<Control> {

		return __controls;
    }
    
    override function set_x(value:Float):Float {

        super.set_x(value);

        for (control in __controls) {

            @:privateAccess control.____setOffsetX(__x + ____offsetX);
        }

        return value;
    }

    override function set_y(value:Float):Float {

        super.set_y(value);

        for (control in __controls) {

            @:privateAccess control.____setOffsetY(__y + ____offsetY);
        }

        return value;
    }
}

