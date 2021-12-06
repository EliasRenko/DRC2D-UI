package gui.core;

import gui.core.ThreeSlice;

class Strip extends Container<Control> {

    // ** Privates.

    /** @private **/ private var __threeSlice:ThreeSlice = new ThreeSlice();

    public function new(width:Float, alignType:AlignType = VERTICAL, x:Float = 0, y:Float = 0) {
        
        super(width, 24, alignType, x, y);

        __padding = {left: 0, right: 0, top: 0, bottom: 0};

        type = 'strip';
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

    public function addControl(control:Control):Control {
        
        return __addControl(control);
    }

    public function removeControl(control:Control):Void {
        
        return __removeControl(control);
    }

    public function clear():Void {

        __clear();
    }

    override function onParentResize():Void {

        width = parent.width;

        super.onParentResize();
    }

    private function __initGraphics():Void {

        __threeSlice.get(0).id = ____canvas.tilemap.tileset.names.get('strip_0');

        __threeSlice.get(1).id = ____canvas.tilemap.tileset.names.get('strip_1');

        __threeSlice.get(2).id = ____canvas.tilemap.tileset.names.get('strip_2');
    }

    override function __setGraphicX():Void {

        __threeSlice.setX(__x + ____offsetX);
    }

    override function __setGraphicY():Void {
        
        __threeSlice.setY(__y + ____offsetY);
    }

    override function __setGraphicZ():Void {
        
        __threeSlice.setZ(__z);
    }

    // ** Getters and setters.

    override function set_width(value:Float):Float {

        __threeSlice.setWidth(value);

        return super.set_width(value);
    }

    override function set_visible(value:Bool):Bool {

        __threeSlice.setVisible(value);

        return super.set_visible(value);
    }
}