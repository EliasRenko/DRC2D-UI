package gui.core;

import gui.core.ListItem;
import gui.events.ControlEventType;
import gui.core.AlignType;

class List<T:Control> extends Container<ListItem<T>> {

    public function new(width:Float, alignType:AlignType = VERTICAL, x:Float = 0, y:Float = 0) {
        
        super(width, 0, alignType, x, y);

        __padding = {left: 0, right: 0, top: 0, bottom: 0};

        __type = 'list';
    }

    override function init() {

        super.init();

        for (listItem in __controls) {

            listItem.y = height;

            height += listItem.height;
        }
    }

    override function release() {
        
        super.release();
    }

    public function addControl(control:T):Control {

        var _listItem:ListItem<T> = new ListItem(control, width);

        _listItem.addEventListener(__onItemClickEvent, LEFT_CLICK);

        // **

        __addControl(_listItem);

        if (____canvas != null) {
            
            var _last:Null<ListItem<T>> = controls.last();

            //__height = _listItem.y + _listItem.height + _listItem.padding.top;

            __height = _last.y + _last.height;
		}

        return _listItem;
    }

    public function addAfter(prev:Control, control:T):Control {
        
        var _listItem:ListItem<T> = new ListItem(control, width);

        _listItem.addEventListener(__onItemClickEvent, LEFT_CLICK);

        // **

        __addControlAfter(prev, _listItem);

        if (____canvas != null) {
            
            //_listItem.y = height;

            var _last:Null<ListItem<T>> = controls.last();

            //__height = _listItem.y + _listItem.height + _listItem.padding.top;

            __height = _last.y + _last.height;
		}

        return _listItem;
    }

    public function removeControl(control:T):Bool {

        for (listItem in __controls) {

            if (listItem.item == control) {

                __removeControl(listItem);

                height -= control.height;

                var _y:Float = 0;
        
                for (listItem in __controls) {
        
                    listItem.y = _y;
        
                    _y += listItem.height;
                }

                return true;
            }
        }

        return false;
    }

    public function removeControlAt(index:UInt):Bool {
        
        var i:Int = 0;

        for (listItem in __controls) {

            if (i == index) {

                __removeControl(listItem);

                height -= listItem.height;

                var _y:Float = 0;
        
                for (listItem in __controls) {
        
                    listItem.y = _y;
        
                    _y += listItem.height;
                }

                return true;
            }

            i ++;
        }

        return false;
    }

    public function clear():Void {
        
        height = 0;

        __clear();
    }

    public function onItemClick(control:Control):Void {
        
        dispatchEvent(control, ON_ITEM_CLICK);
    }

    private function __onItemClickEvent(control:Control, type:UInt):Void {

        onItemClick(control);
    }
}