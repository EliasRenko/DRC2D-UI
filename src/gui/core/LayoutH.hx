package gui.core;

import gui.core.Control;

class LayoutH<T:Control> extends Control {
    
    // ** Publics.

    public var controls(get, null):LinkedList<T>;

    // ** Privates.

    /** @private **/ private var __controls:__ControlList<T> = new __ControlList<T>();

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

        __controls.align(__controls.first());
    }

    override function release():Void {

        __clear();

        super.release();
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

    private function __addControl(control:T):T {
        
        if (control.active) return control;

        if (____canvas != null) {
			
			__initControl(control);
		}

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

    private function __initControl(control:Control) {
        
        @:privateAccess control.____canvas = ____canvas; // ** Define metadata privateAccess.

        @:privateAccess control.____offsetX = __x + ____offsetX; // ** Define metadata privateAccess.
		
        @:privateAccess control.____offsetY = __y + ____offsetY; // ** Define metadata privateAccess.
        
        @:privateAccess control.____parent = this; // ** Define metadata privateAccess.

        control.visible = control.visible ? __visible : false;

        if (control.z == 0) control.z += __z - 2;

        if (shouldMask) {

            control.setMask(mask);
        }

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

    private function get_controls():LinkedList<T> {

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

    public function addAfter(control:Control, item:T):Void {
        
        var _object = __createNode(item, null, null);

        var prev:IListObject<T> = null;

        var alignToPrev:Null<IListObject<T>> = null;

        var _current = __first;

        if (first == null) add(item);

        while (_current != null) {

			if (_current.item == control) {

                if (__last == _current) {

					__last = _object;
                }
                else {

                    _object.next = _current.next;
                }

                _current.next = _object;

                _object.prev = _current;

                while (_current != null) {

                    if (_current.item.alignType != AlignType.NONE && _current.item.visible == true) {
        
                        if (alignToPrev == null) {

                            @:privateAccess _current.item.____alignTo(null);
                        }
                        else {

                            @:privateAccess _current.item.____alignTo(alignToPrev.item);
                        }

                        alignToPrev = _current;
                    }

                    //alignToPrev = _current;
        
                    _current = _current.next;
                }

                return;
            }

            if (_current.item.alignType != AlignType.NONE) {

                alignToPrev = _current;
            }

			prev = _current;

			_current = _current.next;
        }
    }

    public function alignFrom(item:T):Void {

        var prev:IListObject<T> = null;

        var alignToPrev:Null<IListObject<T>> = null;

        var _current = __first;

        if (first == null) return;

        while (_current != null) {

			if (_current.item == item) {

                while (_current != null) {

                    if (_current.item.alignType != AlignType.NONE && _current.item.visible == true) {
        
                        if (alignToPrev == null) {

                            @:privateAccess _current.item.____alignTo(null);
                        }
                        else {

                            @:privateAccess _current.item.____alignTo(alignToPrev.item);
                        }

                        alignToPrev = _current;
                    }

                    //alignToPrev = _current;
        
                    _current = _current.next;
                }

                return;
            }

            if (_current.item.alignType != AlignType.NONE && _current.item.visible == true) {

                alignToPrev = _current;
            }

			prev = _current;

			_current = _current.next;
        }
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

    public function align(item:Null<T>):Void {
        
        if (item == null) return;

        var _current:IListObject<T> = __first;

        var _alignTo:Null<IListObject<T>> = null;

		while (_current != null) {

			if (_current.item == item) {

                if (_alignTo == null) {

                    @:privateAccess _current.item.____alignTo(null);
                }
                else {

                    @:privateAccess _current.item.____alignTo(_alignTo.item);
                }

                _alignTo = _current;

                _current = _current.next;

                while (_current != null) {
                    
                    if (_current.item.alignType != AlignType.NONE) {

                        if (_alignTo == null) {

                            @:privateAccess _current.item.____alignTo(null);
                        }
                        else {

                            @:privateAccess _current.item.____alignTo(_alignTo.item);
                        }

                        _alignTo = _current;
                    }

                    _current = _current.next;
                }

                break;
			}

            if (_current.item.alignType != AlignType.NONE) {

                _alignTo = _current;
            }

			_current = _current.next;
		}
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