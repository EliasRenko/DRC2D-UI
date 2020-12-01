package gui.core;

class Combobox extends Container {

    // ** Privates.

    /** @private **/ private var __button:Button;

    /** @private **/ private var __panel:ComboboxPanel;

    public function new(width:Float, x:Float, y:Float) {
        
        super(width, 128, x, y);

        __button = new Button("text", width, 0, 0);

        __panel = new ComboboxPanel(width, 0, 24);
    }

    override function init():Void {

        super.init();

        __addControl(__button);

        __addControl(__panel);

        // ** 

        __addLabel('Item1');

        __addLabel('Item2');

        __addLabel('Item3');
    }

    public function addItem(value:String):Control {

        __panel.addControl(new Label(value, 0, 0));

        return label;
    }

    override function onMouseLeftClick() {

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

    private function onComboboxPanelClick(control:Control):Void {
        
    }
}

private class ComboboxPanel extends Panel {

    /** @private **/ private var __list:List;

    public function new(width:Float, x:Float, y:Float) {
        
        super(width, 0, x, y);

        __list = new List(width, 0, 0);
    }

    override function init():Void {

        super.init();

        super.addControl(__list);

        visible = false;
    }

    override function addControl(control:Control):Control {

        __list.addControl(control);

        height = __list.height;

        return control;
    }
}