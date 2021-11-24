package gui.core;

import gui.events.ControlEventType;
import gui.core.AlignType;

class Combobox extends Container<Control> {

    // ** Privates.

    /** @private **/ private var __button:Button;

    /** @private **/ private var __panel:ComboboxPanel;

    public function new(width:Float, alignType:AlignType, x:Float, y:Float) {
        
        super(width, 128, alignType, x, y);

        __button = new Button('text', width, NONE, 0, 0);

        __button.addEventListener(__onButtonFocusGain, ON_FOCUS_GAIN);

        __panel = new ComboboxPanel(width, 0, 0);

        __panel.list.addEventListener(__onItemClickEvent, ON_ITEM_CLICK);

        __type = 'combobox';
    }

    override function init():Void {

        super.init();

        __addControl(__button);

        __addControl(__panel);
    }

    public function addItem(value:String):Control {

        var _control:Control = __panel.addControl(new Label(value, VERTICAL, 0, 0));

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

    private function __onButtonFocusGain(control:Control, type:UInt):Void {
        
        __panel.onFocusGain();
    }

    private function __onItemClickEvent(control:Control, type:UInt):Void {
        
        var _listItem:ListItem<Label> = cast control;

        __button.text = _listItem.item.text;
    }
}

private class ComboboxPanel extends Panel {

    // ** Publics.

    public var list:List<Control>;

    public function new(width:Float, x:Float, y:Float) {
        
        super(width, 0, VERTICAL, x, y);

        list = new List(width, 0, 0);

        list.addEventListener(__onItemClickEvent, ON_ITEM_CLICK);
    }

    override function init():Void {

        super.init();

        super.addControl(list);

        height = list.height;

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

    override function onFocusGain():Void {

        visible = true;

        super.onFocusGain();
    }

    override function onFocusLost():Void {

        visible = false;

        super.onFocusLost();
    }

    private function __onItemClickEvent(control:Control, type:UInt):Void {
        
    }

    override function preUpdate():Bool {

        update();

        return false;
    }

    override function update() {

        super.update();
    }
}