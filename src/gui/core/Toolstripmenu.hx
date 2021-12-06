package gui.core;

import gui.core.Strip;
import gui.events.ControlEventType;

class Toolstripmenu extends Container<Control> {

    // ** Publics.

    public var selection(get, null):String;

    // ** Privates.

    /** @private **/ private var __strip:ToolstripBar;

    /** @private **/ private var __focusedPanel:Control;

    /** @private **/private var __selection:String = "";

    public function new() {
        
        super(0, 24, VERTICAL, 0, 0);

        __strip = new ToolstripBar();

        __padding = {left: 0, right: 0, top: 0, bottom: 0};

        __type = 'toolstrip';
    }

    override function init():Void {

        __addControl(__strip);

        width = parent.width;

        super.init();
    }

    public function addItem(text:String, options:Array<String>):Label {
        
        var _toolstripPanel:ToolstripPanel = new ToolstripPanel(128);

        _toolstripPanel.list.addEventListener(__onItemClickEvent, ON_ITEM_CLICK);

        _toolstripPanel.z = __z;

        ____canvas.addControl(_toolstripPanel);

        var _label:ToolstripLabel = new ToolstripLabel(text, _toolstripPanel, 0, 0);

        _label.padding = {left: 4, right: 8, top: 2, bottom: 0};

        __strip.addControl(_label);

        // ** 

        for (option in options) {

            var _option = new Label(option, VERTICAL);

            _option.padding = {left: 4, right: 0, top: 2, bottom: 0};

            _toolstripPanel.addControl(_option);
        }

        return _label;
    }

    public function removeItem(label:Label):Void {
        
        __strip.removeControl(label);
    }

    public function onItemClick():Void {
        
        dispatchEvent(this, ON_ITEM_CLICK);
    }

    private function __onItemClickEvent(control:Control, type:UInt):Void {
        
        var _listItem:ListItem<Label> = cast control;

        __selection = _listItem.item.text;

        onItemClick();
    }

    override function onParentResize():Void {

        width = parent.width;

        super.onParentResize();
    }

    // ** Getters and setters.

    private function get_selection():String {
        
        return __selection;
    }
}

private class ToolstripLabel extends Label {

    public var toolstripPanel:ToolstripPanel;

    public function new(text:String, panel:ToolstripPanel, x:Float, y:Float) {

        toolstripPanel = panel;

        toolstripPanel.visible = false;

        super(text, HORIZONTAL, x, y);
    }

    override function release():Void {

        ____canvas.removeControl(toolstripPanel);

        super.release();
    }

    override function onFocusGain():Void {

        toolstripPanel.onFocusGain();
    }

    override function ____alignTo(control:Null<Control>):Void {

        super.____alignTo(control);

        toolstripPanel.x = __x;
    }
}

private class ToolstripBar extends Strip {

    public function new() {
        
        super(640);
    }
}

private class ToolstripPanel extends Panel {

    // ** Publics.

    public var list:List<Control>;

    public function new(width:Float) {
        
        super(width, 0, NONE, 0, 24);

        list = new List(width, 0, 0);

        list.addEventListener(__onItemClickEvent, ON_ITEM_CLICK);
    }

    override function init():Void {

        super.init();

        super.addControl(list);
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
}