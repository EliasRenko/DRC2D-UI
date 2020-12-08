package gui.core;

import gui.core.NineSlice;

class Panel extends Container<Control> {

    // ** Privates.

    /** @private **/ private var __nineSlice:NineSlice = new NineSlice();

    public function new(width:Float, heigth:Float, x:Float, y:Float) {

        super(width, heigth, x, y);

        type = "panel";
    }

    override function init():Void {

        __initGraphics();

        __nineSlice.iterate(function (tile) {

            tile.parentTilemap = ____canvas.tilemap;

            tile.visible = visible;

            ____canvas.tilemap.addTile(tile);
        });

        __nineSlice.setWidth(__width);

        __nineSlice.setHeight(__height);

        super.init();
    }

    override function release():Void {

        __nineSlice.iterate(function (tile) {

            ____canvas.tilemap.removeTile(tile);
        });

        super.release();
    }

    public function addControl(control:Control):Control {
        
        return __addControl(control);
    }

    public function removeControl(control:Control):Void {
        
        return __removeControl(control);
    }

    public function clear():Void {

        __clear();
    }

    private function __initGraphics():Void {

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

    override function __setGraphicX():Void {

        __nineSlice.setX(__x + ____offsetX);
    }

    override function __setGraphicY():Void {
        
        __nineSlice.setY(__y + ____offsetY);
    }

    // ** Getters and setters.

    override function set_height(value:Float):Float {

        __nineSlice.setHeight(value);

        return super.set_height(value);
    }

    override function set_visible(value:Bool):Bool {

        __nineSlice.setVisible(value);

        return super.set_visible(value);
    }

    override function set_width(value:Float):Float {

        __nineSlice.setWidth(value);

        return super.set_width(value);
    }
}