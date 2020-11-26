package gui.core;

import gui.core.ListItem;

class List extends Container {

    public function new(width:Float, x:Float, y:Float) {
        
        super(width, 0, x, y);
    }

    override function addControl(control:Control):Control {

        var _listItem:ListItem = new ListItem(control, width, height);

        height += _listItem.height;

        return super.addControl(_listItem);
    }

    override function removeControl(control:Control) {

        super.removeControl(control);

        height -= control.height;

        var _y:Float = 0;

        for (control in __controls) {

            control.y = _y;

            _y += control.height;
        }
    }

    override function onMouseEnter() {

        super.onMouseEnter();
    }

    override function update():Void {

        super.update();
    }
}