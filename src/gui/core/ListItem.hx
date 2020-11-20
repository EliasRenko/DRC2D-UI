package gui.core;

import drc.display.Tile;

class ListItem extends Container {

    // ** Privates.

    /** @private **/ private var __graphic:Tile;

    // ** Privates with access.

    /** @private **/ private var ____back:ListItem;

    /** @private **/ private var ____front:ListItem;

    public function new(control:Control) {

        super(control.width, control.height, 0, 0);

        addControl(control);
    }

    override function init():Void {

        if (____front != null) {

            y = ____front.y + ____front.height;
        }

        super.init();
    }

    override function release():Void {

        if (____front != null) {

            ____front.____back = ____back;
        }

        if (____back != null) {

            ____back.____front = ____front;

            ____back.setPosition();
        }

        super.release();
    }

    public function setPosition():Void {
        
        var _y:Float = 0;

        if (____front != null) {

            _y = ____front.y + ____front.height;
        }

        y = _y;

        if (____back == null) return;
            
        ____back.setPosition();
    }
}