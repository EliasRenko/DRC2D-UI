package gui.core;

import gui.events.ControlEventType;

class ContextMenu extends Panel {

    // ** Publics.

    // ** Privates.

    /** @private **/ private var __list:List<Label>;

    public function new(width:Float, ?items:Array<String>) {
        
        super(width, 0, 0, 0);

        __list = new List(width, 0, 0);

        __list.addEventListener(__onItemClickEvent, ON_ITEM_CLICK);

        for (item in items) {

            var _label:Label = new Label(item, 4, 2);

            __list.addControl(_label);
        }

        type = 'context_menu';
    }

    override function init() {

        super.init();

        super.addControl(__list);

        height = __list.height;

        visible = false;
    }

    private function __onItemClickEvent(control:Control, type:UInt):Void {
        
        dispatchEvent(control, ON_ITEM_CLICK);
    }
}