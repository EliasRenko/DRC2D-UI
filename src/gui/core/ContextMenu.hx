package gui.core;

import gui.events.ControlEventType;

class ContextMenu extends Panel {

    // ** Publics.

    // ** Privates.

    /** @private **/ private var __list:List<Label>;

    /** @private **/ private var __callback:Control;

    public function new(width:Float, ?items:Array<String>) {
        
        super(width, 0, NONE, 0, 0);

        __list = new List(width, 0, 0);

        __list.addEventListener(__onItemClickEvent, ON_ITEM_CLICK);

        for (item in items) {

            var _label:Label = new Label(item, VERTICAL, 4, 2);

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

    public function show(control:Control):Void {
        
        __callback = control;

        visible = true;

        x = ____canvas.mouseX;

        y = ____canvas.mouseY;

        ____canvas.contextMenu = this;
    }

    private function __onItemClickEvent(control:Control, type:UInt):Void {
        
        var _listItem:ListItem<Label> = cast control;

        __callback.onContextMenuSelect(_listItem.item.text);

        dispatchEvent(control, ON_ITEM_CLICK);

        visible = false;
    }
}