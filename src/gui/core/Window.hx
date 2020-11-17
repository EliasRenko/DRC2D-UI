package gui.core;

class Window extends Container {

    // ** Privates.

    /** @private **/ private var __strip:Strip;

    /** @private **/ private var __panel:Panel;

    public function new(width:Float, heigth:Float, x:Float, y:Float) {
        
        super(width, heigth, x, y);

        __strip = new Strip(width, 0, 0);

        __panel = new Panel(width, height - 32, 0, 32);
    }

    override function init():Void {

        super.init();

        super.addControl(__strip);

        super.addControl(__panel);
    }

    override function addControl(control:Control):Control {

        return __panel.addControl(control);
    }

    override function removeControl(control:Control):Void {
        
        __panel.removeControl(control);
    }
}