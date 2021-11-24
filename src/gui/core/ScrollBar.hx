package gui.core;

import gui.core.ThreeSlice;

class ScrollBar extends Control {
    
    // ** Publics.

    public var value(get, set):Float;

    // ** Privates.

    private var __threeSlice:ThreeSliceV = new ThreeSliceV();

    public function new() {
        
        super(NONE, 0, 0);

        __width = 32;

        __height = 128;
    }

    override function init():Void {

        __initGraphics();

        __threeSlice.iterate(function (tile) {

            tile.parentTilemap = ____canvas.tilemap;

            tile.visible = visible;

            ____canvas.tilemap.addTile(tile);
        });

        __threeSlice.setHeight(__height);
    }

    private function __initGraphics():Void {

        __threeSlice.get(0).id = ____canvas.tilemap.tileset.names.get('scrollBar_0');

        __threeSlice.get(1).id = ____canvas.tilemap.tileset.names.get('scrollBar_1');

        __threeSlice.get(2).id = ____canvas.tilemap.tileset.names.get('scrollBar_2');
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

    override function set_height(value:Float):Float {

        __threeSlice.setHeight(value);

        return super.set_height(value);
    }

    private function get_value():Float {
        
        return 0;
    }

    private function set_value(value:Float):Float {
        
        // var _dif:Float = __layout.height - height;

		// if (_dif > 0) {

		// 	__slider.visible = true;

		// 	var perc_available = (_dif / __layout.height) * 100;

		// 	__slider.height = height - (height * perc_available) / 100;

            

		// 	return;
		// }

        return value;
    }

    override function set_visible(value:Bool):Bool {

        super.set_visible(value);

        __threeSlice.setVisible(value);

        return value;
    }
}