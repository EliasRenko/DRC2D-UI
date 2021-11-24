package gui.core;

import haxe.xml.Fast;
import drc.ds.IListObject;
import drc.ds.LinkedList;
import gui.core.Control;
import gui.events.ControlEventType;

class Container<T:Control> extends Control {

    // ** Publics.

    public var controls(get, null):__ControlList<T>;

    // ** Privates.

    /** @private **/ private var __controls:__ControlList<T> = new __ControlList<T>();

    /** @private **/ private var __controlsHeight:Float = 0;

    /** @private **/ private var __lastAlignedControl:Null<Control> = null;

    public function new(width:Float, height:Float, alignType:AlignType, x:Float, y:Float) {
        
        super(alignType, x, y);

        __width = width;

        __height = height;

        __type = 'container';
    }

    override function init():Void {

        super.init();

        for (control in __controls) {

            __initControl(control);
        }
    }

    override function release():Void {

        __clear();

        super.release();
    }

    private function __addControl(control:T):T {
        
        if (control.active) return control;

        if (____canvas != null) {
			
			__initControl(control);
		}

        //__alignControl(control);

        __controls.add(control);

        control.dispatchEvent(control, ADDED);

        return control;
    }

    private function __removeControl(control:T):Void {

        if (control.active) {

            control.dispatchEvent(control, REMOVED);

            control.release();

            __controls.remove(control);
        }
    }

    private function __clear():Void {
        
        for (control in __controls) {

            __removeControl(control);
        }
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

    override function onParentResize() {

        super.onParentResize();

        for (control in __controls) {

            control.onParentResize();
        }
    }

    private function __alignControl(control:Control):Void {

        var _last:Null<Control> = __controls.last();

        if (_last == null) {

            trace('Last is null');

            control.x = control.__paddingX;

            control.y = control.__paddingY;

            return;
        }

        @:privateAccess control.____alignTo(_last);

        return;

        switch (control.alignType) {

            case NONE: 

                return;

            case VERTICAL: 

                control.x = __paddingX;

                control.y = _last.y + _last.height + control.__paddingY;

            case HORIZONTAL:

                control.x = _last.x + _last.width + control.__paddingX;

                control.y = __paddingY;
        }
    }

    private function __alignControlOld(control:Control):Void {

        // ** Define metadata `privateAccess`.
        // if (@:privateAccess control.____shouldAlign) {

        //     if (control.x == 0 || control.y == 0) {

        //         if (__lastAlignedControl == null) {

        //             control.x = control.__paddingX;

        //             control.y = control.__paddingY;

        //             __controlsHeight = control.y + control.height;
        //         }
        //         else {

        //             switch (control.alignType) {

        //                 case NONE: 

        //                     return;

        //                 case VERTICAL: 

        //                     control.x = __paddingX;

        //                     control.y = __lastAlignedControl.y + __lastAlignedControl.height + control.__paddingY;

        //                     __controlsHeight = control.y + control.height;

        //                 case HORIZONTAL:

        //                     control.x = __lastAlignedControl.x + __lastAlignedControl.width + control.__paddingX;

        //                     control.y = __paddingY;
        //             }

        //         }

        //         __lastAlignedControl = control;
        //     }
        // }
    }

    private function __dockControl(control:Control):Void {

        
    }
    
    private function __initControl(control:Control) {
        
        @:privateAccess control.____canvas = ____canvas; // ** Define metadata privateAccess.

        @:privateAccess control.____offsetX = __x + ____offsetX; // ** Define metadata privateAccess.
		
        @:privateAccess control.____offsetY = __y + ____offsetY; // ** Define metadata privateAccess.
        
        @:privateAccess control.____parent = this; // ** Define metadata privateAccess.

        control.visible = control.visible ? __visible : false;

        if (control.z == 0) control.z += __z - 2;

        control.init();
    }

    override function ____setOffsetX(value:Float):Void {
        
        super.____setOffsetX(value);

        for (control in __controls) {

            @:privateAccess control.____setOffsetX(__x + ____offsetX);
        }
    }

    override function ____setOffsetY(value:Float):Void {
        
        super.____setOffsetY(value);

        for (control in __controls) {

            @:privateAccess control.____setOffsetY(__y + ____offsetY);
        }
    }

    override function ____setPositionX(value:Float):Void {
        
        super.____setPositionX(value);

        for (control in __controls) {

            @:privateAccess control.____setOffsetX(__x + ____offsetX);
        }
    }

    override function ____setPositionY(value:Float):Void {
        
        super.____setPositionY(value);

        for (control in __controls) {

            @:privateAccess control.____setOffsetY(__y + ____offsetY);
        }
    }

    // ** Getters and setters.

    private function get_controls():__ControlList<T> {

		return __controls;
    }

    override function set_height(value:Float):Float {

        return super.set_height(value);
    }

    override function set_visible(value:Bool):Bool {

        for (control in __controls) {

            control.visible = value;
        }

        return super.set_visible(value);
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

    override function set_z(value:Float):Float {

        super.set_z(value);

        for (control in __controls) {

            control.z += __z - 2;
        }

        return value;
    }
}

private class __ControlList<T:Control> extends LinkedList<T> {
    
    public function new() {
        
        super();
    }

    override function add(item:T) {

        var _object = __createNode(item, null, null);

        if (__first == null) {
            
            __first = _object;
        }
        else {
            
            __last.next = _object;

            _object.prev = __last;
        }

        __last = _object;
        
		length ++;

        var _current = _object.prev;

        while (_current != null) {

            if (_current.item.alignType != AlignType.NONE) {

                @:privateAccess _object.item.____alignTo(_current.item);

                return;
            }

            _current = _current.prev;
        }

        @:privateAccess _object.item.____alignTo(null);
    }

    override function remove(item:Control):Bool {

        var prev:IListObject<T> = null;

        var alignToPrev:Null<IListObject<T>> = null;

        var alignToNext:Null<IListObject<T>> = null;

		var _current = __first;

        var _dropLine:Bool = false;

		while (_current != null) {

			if (_current.item == item) {

				if (prev == null) {

					__first = _current.next;

                    _current.prev = null;
                }
				else {

					prev.next = _current.next;
                }

				if (__last == _current) {

					__last = prev;

                    prev.next = null;
                }
                else {

                    _current.next.prev = prev;
                }

				length--;

                if (_current.next == null) {

                    return true;
                }

                if (_current.item.alignType == VERTICAL) {

                    _dropLine = true;
                }

                _current = _current.next;

                while (_current != null) {

                    if (_current.item.alignType != AlignType.NONE) {

                        if (_dropLine) {

                            _current.item.alignType = VERTICAL;

                            _dropLine = false;
                        }

                        if (alignToPrev == null) {

                            @:privateAccess _current.item.____alignTo(null);
                        }
                        else {

                            @:privateAccess _current.item.____alignTo(alignToPrev.item);
                        }

                        alignToPrev = _current;
                    }

                    _current = _current.next;
                }

				return true;
			}

            if (_current.item.alignType != AlignType.NONE) {

                alignToPrev = _current;
            }

			prev = _current;

			_current = _current.next;
		}

		return false;
    }

    public function align(node:IListObject<T>):Void {
        
    }

    public function alignNodes(node:IListObject<T>):Void {

        var _current:IListObject<T> = node.next;

        var _previous:IListObject<T> = node.prev;

        while (_previous != null) {

            if (_previous.item.alignType != AlignType.NONE) {

               break;
            }

            _previous = _previous.prev;
        }

        while (_current != null) {

            if (_current.item.alignType == AlignType.NONE) {

                _current = _current.next;

                continue;
            }

            break;
        }

        return;

        if (node.item.alignType == VERTICAL) {

            while (_current != null) {

                if (_current.item.alignType == AlignType.NONE) {

                    _current = _current.next;

                    continue;
                }

                @:privateAccess _current.item.____alignType = VERTICAL;

                @:privateAccess _current.item.____alignTo(_current.prev.item);
            }
        }
    }

    public function alignNodes2(node:IListObject<T>):Void {

        var _current:IListObject<T> = node.next;

        if (node.item.alignType == VERTICAL) {

            @:privateAccess _current.item.____alignType = VERTICAL;
        }

        while (_current != null) {

            var _prev:IListObject<T> = _current.prev;

            while (_prev != null) {

                if (_prev.item.alignType != NONE) {

                    @:privateAccess _current.item.____alignTo(_current.prev.item);

                    break;
                }

                _prev = _prev.prev;
            }

            _current = _current.next;
        }
    }
}