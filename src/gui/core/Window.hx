package gui.core;

class Window extends Container {

    // ** Privates.

    /** @private **/ private var __strip:WindowStrip;

    /** @private **/ private var __panel:WindowPanel;

    public function new(text:String, width:Float, heigth:Float, x:Float, y:Float) {
        
        super(width, heigth, x, y);

        __strip = new WindowStrip(text, width);

        __panel = new WindowPanel(width, height - 24, 0, 24);
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

private class WindowStrip extends Strip {

    // ** Privates.

    /** @private **/ private var __label:Label;

    public function new(title:String, width:Float) {
        
        super(width, 0, 0);

        __label = new Label(title, 0, 0);
    }

    override function init():Void {

        super.init();

        super.addControl(__label);
    }

    override function __initGraphics() {

        __threeSlice.get(0).id = ____canvas.tilemap.tileset.names.get('windowStrip_0');

        __threeSlice.get(1).id = ____canvas.tilemap.tileset.names.get('windowStrip_1');

        __threeSlice.get(2).id = ____canvas.tilemap.tileset.names.get('windowStrip_2');
    }
}

private class WindowPanel extends Panel {

    public function new(width:Float, heigth:Float, x:Float, y:Float) {
        
        super(width, heigth, x, y);
    }

    override function __initGraphics() {

        __nineSlice.get(0).id = ____canvas.tilemap.tileset.names.get('windowPanel_0');

        __nineSlice.get(1).id = ____canvas.tilemap.tileset.names.get('windowPanel_1');

        __nineSlice.get(2).id = ____canvas.tilemap.tileset.names.get('windowPanel_2');

        __nineSlice.get(3).id = ____canvas.tilemap.tileset.names.get('windowPanel_3');

        __nineSlice.get(4).id = ____canvas.tilemap.tileset.names.get('windowPanel_4');

        __nineSlice.get(5).id = ____canvas.tilemap.tileset.names.get('windowPanel_5');

        __nineSlice.get(6).id = ____canvas.tilemap.tileset.names.get('windowPanel_6');

        __nineSlice.get(7).id = ____canvas.tilemap.tileset.names.get('windowPanel_7');

        __nineSlice.get(8).id = ____canvas.tilemap.tileset.names.get('windowPanel_8');
    }
}