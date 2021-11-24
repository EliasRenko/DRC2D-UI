package gui.core;

import gui.events.ControlEventType;

class Window extends Container<Control> {

    // ** Privates.

    /** @private **/ private var __strip:WindowStrip;

    /** @private **/ private var __panel:WindowPanel;

    public function new(text:String, width:Float, heigth:Float, alignType:AlignType = AlignType.VERTICAL, x:Float = 0, y:Float = 0) {
        
        super(width, heigth, alignType, x, y);

        __strip = new WindowStrip(text, width);

        __strip.stamp_close.addEventListener(__onCloseClickEvent, LEFT_CLICK);

        __strip.stamp_fold.addEventListener(__onFoldClickEvent, LEFT_CLICK);

        __panel = new WindowPanel(width, height - 24, 0, 24);

        __type = 'window';
    }

    override function init():Void {

        super.init();

        __addControl(__strip);

        __addControl(__panel);
    }

    public function addControl(control:Control):Control {

        return __panel.addControl(control);
    }

    public function removeControl(control:Control):Void {
        
        __panel.removeControl(control);
    }
    
    public function clear():Void {
        
        __panel.clear();
    }

    override function release() {
        
        super.release();
    }

    private function __onCloseClickEvent(control:Control, type:UInt):Void {

        visible = visible ? false : true;
    }

    private function __onFoldClickEvent(control:Control, type:UInt):Void {

        __panel.visible = __panel.visible ? false : true;
    }
}

private class WindowStrip extends Strip {

    // ** Publics.

    public var label:Label;

    public var stamp_close:Stamp;

    public var stamp_fold:Stamp;

    public function new(title:String, width:Float) {
        
        super(width, VERTICAL, 0, 0);

        label = new Label(title, VERTICAL, 4, 2);

        stamp_close = new Stamp(0, NONE, width - 20, 4);

        stamp_fold = new Stamp(0, NONE, width - 36, 4);
    }

    override function init():Void {

        super.init();

        super.addControl(label);

        super.addControl(stamp_close);

        super.addControl(stamp_fold);
    }

    override function __initGraphics() {

        __threeSlice.get(0).id = ____canvas.tilemap.tileset.names.get('strip_0');

        __threeSlice.get(1).id = ____canvas.tilemap.tileset.names.get('strip_1');

        __threeSlice.get(2).id = ____canvas.tilemap.tileset.names.get('strip_2');

        stamp_close.id = ____canvas.tilemap.tileset.names.get('stamp_close');

        stamp_fold.id = ____canvas.tilemap.tileset.names.get('stamp_fold');
    }
}

private class WindowPanel extends Panel {

    public function new(width:Float, heigth:Float, x:Float, y:Float) {
        
        super(width, heigth, VERTICAL, x, y);
    }

    override function __initGraphics() {

        __nineSlice.get(0).id = ____canvas.tilemap.tileset.names.get('panel_0');

        __nineSlice.get(1).id = ____canvas.tilemap.tileset.names.get('panel_1');

        __nineSlice.get(2).id = ____canvas.tilemap.tileset.names.get('panel_2');

        __nineSlice.get(3).id = ____canvas.tilemap.tileset.names.get('panel_3');

        __nineSlice.get(4).id = ____canvas.tilemap.tileset.names.get('panel_4');

        __nineSlice.get(5).id = ____canvas.tilemap.tileset.names.get('panel_5');

        __nineSlice.get(6).id = ____canvas.tilemap.tileset.names.get('panel_6');

        __nineSlice.get(7).id = ____canvas.tilemap.tileset.names.get('panel_7');

        __nineSlice.get(8).id = ____canvas.tilemap.tileset.names.get('panel_8');
    }
}