package gui.core;

import drc.display.Text;
import drc.display.Tile;
import gui.core.Label;
import gui.core.ThreeSlice;

class Slider extends Control {

    public var value(get, set):Float;

    // ** Privates.

    /** @private **/ private var __bitmapText:Text;

    /** @private **/ private var __graphic:Tile;

    /** @private **/ private var __threeSlice:ThreeSlice = new ThreeSlice();

    /** @private **/ private var __value:Float;

    public function new(width:Float, x:Float, y:Float) {
        
        super(x, y);

        __bitmapText = new Text(null, "", 2, 2);

        __graphic = new Tile(null, null);

        __width = width;

        __height = 24;
    }

    override function init():Void {

        __initGraphics();

        __threeSlice.iterate(function (tile) {

            tile.parentTilemap = ____canvas.tilemap;

            tile.visible = visible;

            ____canvas.tilemap.addTile(tile);
        });

        __threeSlice.setWidth(__width);

        __graphic.parentTilemap = ____canvas.tilemap;

        __graphic.width = 32;

        __graphic.height = 22;

        __graphic.visible = visible;

        @:privateAccess ____canvas.tilemap.addTile(__graphic);

        __bitmapText.parent = ____canvas.charmap;

        __bitmapText.addToParent();

        super.init();
    }

    override function release():Void {

        __threeSlice.iterate(function (tile) {

            ____canvas.tilemap.removeTile(tile);
        });

        ____canvas.tilemap.removeTile(__graphic);

        __bitmapText.dispose();

        super.release();
    }

    override function onMouseLeftClick():Void {

        value = ____canvas.mouseX - __x - 1;

        super.onMouseLeftClick();
    }

    private function __initGraphics():Void {

        __threeSlice.get(0).id = ____canvas.tilemap.tileset.names.get('slider_0');

        __threeSlice.get(1).id = ____canvas.tilemap.tileset.names.get('slider_1');

        __threeSlice.get(2).id = ____canvas.tilemap.tileset.names.get('slider_2');

        __graphic.id = ____canvas.tilemap.tileset.names.get('empty');
    }

    override function __setGraphicX():Void {

        __bitmapText.x = ____offsetX + __x;

        __graphic.x = ____offsetX + __x + 1;

        __threeSlice.setX(__x + ____offsetX);
    }

    override function __setGraphicY():Void {

        __bitmapText.y = ____offsetY + __y;

        __graphic.y = ____offsetY + __y + 1;

        __threeSlice.setY(__y + ____offsetY);
    }

    // ** Getters and setters.

    private function get_value():Float {
        
        return __value;
    }

    private function set_value(value:Float):Float {
        
        __value = Math.round(((value / (width - 1)) * 100));

        __bitmapText.text = Std.string(__value);

        __graphic.width = (__value / 100) * (width - 2);

        return __value;
    }

    override function set_width(value:Float):Float {

        __threeSlice.setWidth(value);

        return super.set_width(value);
    }
}