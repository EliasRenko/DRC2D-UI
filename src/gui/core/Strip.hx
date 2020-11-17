package gui.core;

import gui.core.ThreeSlice;

class Strip extends Container {

    // ** Privates.

    /** @private **/ private var __threeSlice:ThreeSlice = new ThreeSlice();

    public function new(width:Float, x:Float, y:Float) {
        
        super(width, 32, x, y);
    }

    override function init():Void {

        __initGraphics();

        __threeSlice.iterate(function (tile) {

            tile.parentTilemap = ____canvas.tilemap;

            tile.visible = visible;

            ____canvas.tilemap.addTile(tile);
        });

        __threeSlice.setWidth(__width);

        super.init();
    }

    override function release():Void {

        __threeSlice.iterate(function (tile) {

            ____canvas.tilemap.removeTile(tile);
        });

        super.release();
    }

    private function __initGraphics():Void {

        __threeSlice.get(0).id = 0;

        __threeSlice.get(1).id = 0;

        __threeSlice.get(2).id = 0;
    }

    override function __setGraphicX():Void {

        __threeSlice.setX(__x + ____offsetX);
    }

    override function __setGraphicY():Void {
        
        __threeSlice.setY(__y + ____offsetY);
    }

    // ** Getters and setters.

    override function set_width(value:Float):Float {

        __threeSlice.setWidth(value);

        return super.set_width(value);
    }
}