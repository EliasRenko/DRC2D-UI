package gui.core;

import gui.core.ListItem;

class List extends Container {

    public function new(width:Float, x:Float, y:Float) {
        
        super(width, 0, x, y);
    }

    override function addControl(control:Control):Control {

        var _listItem:ListItem = new ListItem(control);

        var _lastControl:Control = __controls.last();

        if (_lastControl != null) {

            var l:ListItem = cast(_lastControl, ListItem);

            @:privateAccess l.____back = _listItem;

            @:privateAccess _listItem.____front = l;
        }

        return super.addControl(_listItem);
    }

    override function removeControl(control:Control) {

        super.removeControl(control);
    }
}