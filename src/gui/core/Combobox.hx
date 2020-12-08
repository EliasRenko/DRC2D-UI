package gui.core;

import gui.events.ControlEventType;

class Combobox extends Container<Control> {

    // ** Privates.

    /** @private **/ private var __button:Button;

    /** @private **/ private var __panel:ComboboxPanel;

    public function new(width:Float, x:Float, y:Float) {
        
        super(width, 128, x, y);

        __button = new Button("text", width, 0, 0);

        __panel = new ComboboxPanel(width, 0, 24);

        __panel.list.addEventListener(__onItemClick, ON_ITEM_CLICK);

        __type = "combobox";
    }

    override function init():Void {

        super.init();

        __addControl(__button);

        __addControl(__panel);
    }

    public function addItem(value:String):Control {

        var _control:Control = __panel.addControl(new Label(value, 0, 0));

        height = 24 + __panel.height;

        return _control;
    }

    public function removeItem(control:Control):Void {
        
        __panel.removeControl(control);

        height = 24 + __panel.height;
    }

    public function removeItemAt(index:UInt):Void {
        
        __panel.removeControlAt(index);
        
        height = 24 + __panel.height;
    }

    override function onMouseLeftClick():Void {

        super.onMouseLeftClick();
    }

    override function onFocusGain():Void {

        __panel.visible = true;

        super.onFocusGain();
    }

    override function onFocusLost():Void {

        __panel.visible = false;

        super.onFocusLost();
    }

    private function __onItemClick(control:Control, type:UInt):Void {
        
        var _listItem:ListItem<Label> = cast control;

        __button.text = _listItem.item.text;
    }
}

private class ComboboxPanel extends Panel {

    // ** Publics.

    public var list:List<Control>;

    public function new(width:Float, x:Float, y:Float) {
        
        super(width, 0, x, y);

        list = new List(width, 0, 0);
    }

    override function init():Void {

        super.init();

        super.addControl(list);

        visible = false;
    }

    override function addControl(control:Control):Control {

        list.addControl(control);

        height = list.height;

        return control;
    }

    override function removeControl(control:Control):Void {

        list.removeControl(control);

        height = list.height;
    }

    public function removeControlAt(index:UInt):Void {
        
        list.removeControlAt(index);

        height = list.height;
    }
}