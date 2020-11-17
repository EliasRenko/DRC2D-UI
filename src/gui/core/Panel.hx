package gui.core;

import gui.core.NineSlice;

class Panel extends Container {

    // ** Privates.

    /** @private **/ private var __nineSlice:NineSlice = new NineSlice();

    public function new(width:Float, heigth:Float, x:Float, y:Float) {

        super(width, heigth, x, y);
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

    private function __initGraphics():Void {

        __nineSlice.get(0).id = 0;

        __nineSlice.get(1).id = 0;

        __nineSlice.get(2).id = 0;

        __nineSlice.get(3).id = 0;

        __nineSlice.get(4).id = 0;

        __nineSlice.get(5).id = 0;

        __nineSlice.get(6).id = 0;

        __nineSlice.get(7).id = 0;

        __nineSlice.get(8).id = 0;
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

    override function set_width(value:Float):Float {

        __nineSlice.setWidth(value);

        return super.set_width(value);
    }
}