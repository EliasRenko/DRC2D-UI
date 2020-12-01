package gui.core;

import drc.display.Text;
import gui.core.Control;

class Button extends Control {

    /** @private **/ private var __bitmapText:Text;

    /** @private **/ private var __threeSlice:ThreeSlice = new ThreeSlice();
    
    public function new(text:String, width:Float, x:Float, y:Float) {
        
        super(x, y);

        __bitmapText = new Text(null, text, 0, 0);

        __width = width;
    }

    override function init():Void {

        __initGraphics();

        __threeSlice.iterate(function (tile) {

            tile.parentTilemap = ____canvas.tilemap;

            tile.visible = visible;

            ____canvas.tilemap.addTile(tile);
        });

        __threeSlice.setWidth(__width);

        __bitmapText.parent = ____canvas.charmap;

        __bitmapText.addToParent();

        super.init();
    }

    override function release():Void {

        __threeSlice.iterate(function (tile) {

            ____canvas.tilemap.removeTile(tile);
        });

        __bitmapText.dispose();

        super.release();
    }

    private function __initGraphics():Void {

        __threeSlice.get(0).id = ____canvas.tilemap.tileset.names.get('slider_0');

        __threeSlice.get(1).id = ____canvas.tilemap.tileset.names.get('slider_1');

        __threeSlice.get(2).id = ____canvas.tilemap.tileset.names.get('slider_2');
    }

    override function __setGraphicX():Void {

        __bitmapText.x = __x + (__width / 2) - (__bitmapText.width / 2);

        __threeSlice.setX(__x + ____offsetX);
    }

    override function __setGraphicY():Void {

        __bitmapText.y = ____offsetY + __y;

        __threeSlice.setY(__y + ____offsetY);
    }

    // ** Getters and setters.

    override function set_width(value:Float):Float {

        __bitmapText.x = __x + (value / 2) - (__bitmapText.width / 2);

        __threeSlice.setWidth(value);

        return super.set_width(value);
    }
}