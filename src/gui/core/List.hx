package gui.core;

import gui.core.ListItem;

class List extends Container {

    public function new(width:Float, x:Float, y:Float) {
        
        super(width, 0, x, y);
    }

    public function addControl(control:Control):Control {

        var _listItem:ListItem = new ListItem(control, width, height);

        height += _listItem.height;

        return __addControl(_listItem);
    }

    public function removeControl(control:Control):Void {

        __removeControl(control);

        height -= control.height;

        var _y:Float = 0;

        for (control in __controls) {

            control.y = _y;

            _y += control.height;
        }
    }

    override function onMouseEnter():Void {

        super.onMouseEnter();
    }

    override function update():Void {

        super.update();
    }

    // ** Getters and setters.

    override function set_visible(value:Bool):Bool {

        for (control in __controls) {

            control.visible = value;
        }

        return super.set_visible(value);
    }
}