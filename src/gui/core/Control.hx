package gui.core;

import drc.core.EventDispacher;
import drc.input.MouseControl;
import drc.math.Rectangle;
import drc.utils.Common;
import gui.core.AlignType;
import gui.events.ControlEvent;
import gui.events.ControlEventType;

typedef Directions = {

    var left:Float;

    var right:Float;

    var top:Float;

    var bottom:Float;
}

class Control extends EventDispacher<Control> {

    // ** Publics.

    public var active(get, null):Bool;

    public var alignType(get, set):AlignType;

    public var canvas(get, null):Canvas;

    public var contextMenu(get, set):ContextMenu;

    public var height(get, set):Float;

    public var focused(get, set):Bool;

    public var padding(get, set):Directions;

    public var parent(get, null):Control;

    public var type(get, default):String;

    public var visible(get, set):Bool;

    public var width(get, set):Float;

    public var x(get, set):Float;

    public var y(get, set):Float;

    public var z(get, set):Float;

    // ** Privates.

    /** @private **/ private var __active:Bool = false;

    /** @private **/ private var __contextMenu:ContextMenu;

    /** @private **/ private var __focused:Bool = false;

    /** @private **/ private var __height:Float = 0;

    /** @private **/ private var __hitbox:Rectangle;

    /** @private **/ private var __hover:Bool = false;

    /** @private **/ private var __type:String = "";

    /** @private **/ private var __paddingX:Int = 2;

    /** @private **/ private var __paddingY:Int = 2;

    /** @private **/ private var __padding:Directions = {left: 2, right: 2, top: 2, bottom: 2};

    /** @private **/ private var __visible:Bool = true;

    /** @private **/ private var __width:Float = 0;

    /** @private **/ private var __x:Float = 0;

    /** @private **/ private var __y:Float = 0;

    /** @private **/ private var __z:Float = 0;

    // ** Privates with access.

    /** @private **/ @:noCompletion private var ____alignType:AlignType = AlignType.VERTICAL;

    /** @private **/ @:noCompletion private var ____canvas:Canvas;

    /** @private **/ @:noCompletion private var ____offsetX:Float = 0;
	
    /** @private **/ @:noCompletion private var ____offsetY:Float = 0;
    
    /** @private **/ @:noCompletion private var ____parent:Control;

    public function new(alignType:AlignType, x:Float, y:Float) {

        super();

        ____alignType = alignType;

        __x = x;

        __y = y;
    }

    public function init():Void {
        
        __active = true;

        __setGraphicX();

        __setGraphicY();

        dispatchEvent(this, INIT);
    }

    public function release():Void {

        __active = false;

        clearEventListeners();
    }

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

    public function preUpdate():Bool {
        
        return false;
    }

    public function update():Void {
        
        if (__hover) {

            onMouseHover();
        }
        else {

            onMouseEnter();
        }

        if (Common.input.mouse.pressed(MouseControl.LEFT_CLICK)) {
             
            onMouseLeftClick();

            if (!__focused) {

                onFocusGain();
            }
        }

        if (Common.input.mouse.pressed(MouseControl.RIGHT_CLICK)) {

            if (contextMenu == null) return;

            contextMenu.show(this);

            onMouseRightClick();
        }
    }

    public function onContextMenuSelect(value:String):Void {
        
    }

    public function focuseUpdate():Void {

    }

    public function onMouseLeftClick():Void {

        dispatchEvent(this, LEFT_CLICK);
    }

    public function onMouseRightClick():Void {

        dispatchEvent(this, LEFT_CLICK);
    }

    public function onMouseHover():Void {
        
        dispatchEvent(this, ON_HOVER);
    }

    public function onMouseEnter():Void {
        
        __hover = true;

        ____canvas.markedControl = this;

        dispatchEvent(this, ON_MOUSE_ENTER);
    }

    public function onMouseLeave():Void {
        
        __hover = false;

        dispatchEvent(this, ON_MOUSE_LEAVE);
    }

    public function onSizeChange():Void {
        
        dispatchEvent(this, ON_SIZE_CHANGE);
    }

    public function onParentChange():Void {

    }

    public function onLocationChange():Void {
        
        dispatchEvent(this, ON_LOCATION_CHANGE);
    }

    public function onVisibilityChange():Void {
        
        dispatchEvent(this, ON_VISIBILITY_CHANGE);
    }

    public function onParentResize():Void {
        
    }

    public function onFocusGain():Void {
        
        if (__focused) return;

        __focused = true;

        ____canvas.focusedControl = this;

        dispatchEvent(this, ON_FOCUS_GAIN);
    }

    public function onFocusLost():Void {
        
        __focused = false;

        dispatchEvent(this, ON_FOCUS_LOST);
    }

    // ** Privates.

    private function __setGraphicX():Void {}  

    private function __setGraphicY():Void {}

    private function __setGraphicZ():Void {}

    // ** Privates with access.

    @:noCompletion
    private function ____alignTo(control:Null<Control>):Void {

        if (control == null) {

            ____setPositionX(__padding.left);

            ____setPositionY(__padding.top);

            return;
        }

        switch (this.alignType) {

            case NONE: 

                return;

            case VERTICAL: 

                ____setPositionX(padding.left);

                ____setPositionY(control.y + control.height + control.padding.bottom + __padding.top);

            case HORIZONTAL:

                ____setPositionX(control.x + control.width + control.padding.right + __padding.left);

                ____setPositionY(control.y);
        }
    }

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

    @:noCompletion
    private function ____setPositionX(value:Float):Void {
        
        __x = value;

        __setGraphicX();
    }

    @:noCompletion
    private function ____setPositionY(value:Float):Void {
        
        __y = value;

        __setGraphicY();
    }

    // ** Getters and setters.

    private function get_active():Bool {

		return __active;
	}

    private function get_alignType():AlignType {

		return ____alignType;
	}

    private function set_alignType(value:AlignType):AlignType {

        ____alignType = value;

		return value;
	}
	
	private function set_active(value:Bool):Bool {
        
        __active = value;

		return value;
	}

    private function get_canvas():Canvas {
        
        return canvas;
    }

    private function get_contextMenu():ContextMenu {

        return __contextMenu;
    }

    private function set_contextMenu(value:ContextMenu):ContextMenu {

        return __contextMenu = value;
    }

    private function get_height():Float {

		return __height;
	}
	
	private function set_height(value:Float):Float {
        
        __height = value;

        onSizeChange();

		return value;
    }

    private function get_focused():Bool {
        
        return __focused;
    }

    private function set_focused(value:Bool):Bool {

        return false; // ** Impl
    }

    private function get_padding():Directions {
        
        return __padding;
    }

    private function set_padding(value:Directions):Directions {
        
        __padding = value;

        return __padding;
    }
    
    private function get_parent():Control {

		return ____parent;
    }
    
    private function get_type():String {
        
        return __type;
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

        if (alignType == NONE) {

            __x = value;

            __setGraphicX();

            onLocationChange();
        }

		return __x;
	}
	
	private function get_y():Float {

		return __y;
	}
	
	private function set_y(value:Float):Float {

        if (alignType == NONE) {

            __y = value;

            __setGraphicY();

            onLocationChange();
        }

		return __y;
	}
	
	private function get_z():Float {

		return __z;
	}
	
	private function set_z(value:Float):Float {
		
        __z = value;

        __setGraphicZ();

		return value;
	}
}