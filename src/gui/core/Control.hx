package gui.core;

import drc.ds.IListObject;
import drc.core.EventDispacher;
import drc.math.Rectangle;
import gui.events.ControlEvent;
import gui.events.ControlEventType;

class Control extends EventDispacher<ControlEvent> {

    // ** Publics.

    public var active(get, null):Bool;

    public var canvas(get, null):Canvas;

    public var height(get, set):Float;

    public var parent(get, null):Container;

    public var visible(get, set):Bool;

    public var width(get, set):Float;

    public var x(get, set):Float;

    public var y(get, set):Float;

    public var z(get, set):Float;

    // ** Privates.

    /** @private **/ private var __active:Bool = false;

    /** @private **/ private var __focused:Bool = false;

    /** @private **/ private var __height:Float;

    /** @private **/ private var __hitbox:Rectangle;

    /** @private **/ private var __hover:Bool = false;

    /** @private **/ private var __visible:Bool = true;

    /** @private **/ private var __width:Float;

    /** @private **/ private var __x:Float;

    /** @private **/ private var __y:Float;

    /** @private **/ private var __z:Float;

    // ** Privates with access.

    /** @private **/ @:noCompletion private var ____canvas:Canvas;

    /** @private **/ @:noCompletion private var ____offsetX:Float = 0;
	
    /** @private **/ @:noCompletion private var ____offsetY:Float = 0;
    
    /** @private **/ @:noCompletion private var ____parent:Container;

    public function new(x:Float, y:Float) {

        super();

        __x = x;

        __y = y;
    }

    public function init():Void {
        
        __active = true;

        __setGraphicX();

        __setGraphicY();
    }

    public function release():Void {}

    public function hitTest():Bool {
        
        if (__visible) {

            if (____canvas.mouseX > __x + ____offsetX && ____canvas.mouseY > __y + ____offsetY) {

                if (____canvas.mouseX <= width + __x + ____offsetX && ____canvas.mouseY <= height + __y + ____offsetY) {

                    return true;
                }
            }
        }

        return false;
    }

    public function update():Void {
        
        if (__hover) {

            onMouseHover();
        }
        else {

            onMouseEnter();
        }

        if (____canvas.leftClick) {
             
            onMouseLeftClick();

            if (!__focused) {

                onFocusGain();
            }
        }
    }

    public function onMouseLeftClick():Void {

        dispatchEvent({timestamp: 0, control: this}, LEFT_CLICK);
    }

    public function onMouseHover():Void {
        
        dispatchEvent({timestamp: 0, control: this}, ON_HOVER);
    }

    public function onMouseEnter():Void {
        
        __hover = true;

        ____canvas.markedControl = this;

        dispatchEvent({timestamp: 0, control: this}, ON_MOUSE_ENTER);
    }

    public function onMouseLeave():Void {
        
        __hover = false;

        dispatchEvent({timestamp: 0, control: this}, ON_MOUSE_LEAVE);
    }

    public function onSizeChange():Void {
        
        dispatchEvent({timestamp: 0, control: this}, ON_SIZE_CHANGE);
    }

    public function onParentChange():Void {

    }

    public function onLocationChange():Void {
        
        dispatchEvent({timestamp: 0, control: this}, ON_LOCATION_CHANGE);
    }

    public function onVisibilityChange():Void {
        
        dispatchEvent({timestamp: 0, control: this}, ON_VISIBILITY_CHANGE);
    }

    public function onFocusGain():Void {
        
        __focused = true;

        ____canvas.selectedControl = this;
    }

    public function onFocusLost():Void {
        
        __focused = false;
    }

    // ** Privates.

    private function __setGraphicX():Void {}  

    private function __setGraphicY():Void {}

    // ** Privates with access.

    @:noCompletion
    private function ____setOffsetX(value:Float):Void {
        
        ____offsetX = value;

        __setGraphicX();
    }

    @:noCompletion
    private function ____setOffsetY(value:Float):Void {
        
        ____offsetY = value;

        __setGraphicY();
    }

    // ** Getters and setters.

    private function get_active():Bool {

		return __active;
	}
	
	private function set_active(value:Bool):Bool {
        
        __active = value;

		return value;
	}

    private function get_canvas():Canvas {
        
        return canvas;
    }

    private function get_height():Float {

		return __height;
	}
	
	private function set_height(value:Float):Float {
        
        __height = value;

        onSizeChange();

		return value;
    }
    
    private function get_parent():Container {

		return ____parent;
	}

    private function get_visible():Bool {

		return __visible;
	}
	
	private function set_visible(value:Bool):Bool {
        
        __visible = value;

        onVisibilityChange();

		return value;
    }
    
    private function get_width():Float {

		return __width;
	}
	
	private function set_width(value:Float):Float {
        
        __width = value;

		return value;
	}

    private function get_x():Float {

		return __x;
	}
	
	private function set_x(value:Float):Float {

        __x = value;

        __setGraphicX();

        onLocationChange();

		return value;
	}
	
	private function get_y():Float {

		return __y;
	}
	
	private function set_y(value:Float):Float {

        __y = value;

        __setGraphicY();

        onLocationChange();

		return value;
	}
	
	private function get_z():Float {

		return __z;
	}
	
	private function set_z(value:Float):Float {
		
		return __z = value;
	}
}