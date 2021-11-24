package gui.core;

import drc.display.Text;
import drc.display.Tile;
import drc.input.MouseControl;
import drc.utils.Common;
import gui.core.Label;
import gui.core.ThreeSlice;

class ProgressBar extends Control {

    public var value(get, set):Float;

    public var max(get, set):Float;

    public var min(get, set):Float;

    public var precision(get, set):Int;

    // ** Privates.

    /** @private **/ private var __bitmapText:Text;

    /** @private **/ private var __check:Bool = false;

    /** @private **/ private var __graphic:Tile;

    /** @private **/ private var __threeSlice:ThreeSlice = new ThreeSlice();

    /** @private **/ private var __max:Float = 100;

    /** @private **/ private var __min:Float = 0;

    /** @private **/ private var __precision:Int = 0;

    /** @private **/ private var __value:Float = 0;

    public function new(text:String, width:Float, value:Float = 0, max:Float = 100, min:Float = 0, precision:Int = 0, x:Float = 0, y:Float = 0) {
        
        super(VERTICAL, x, y);

        __bitmapText = new Text(null, text, 2, 2);

        __graphic = new Tile(null, null);

        __width = width;

        __height = 24;

        __max = max;

        __min = min;

        __precision = precision;

        __value = value;

        __type = 'slider';
    }

    override function init():Void {

        __initGraphics();

        __threeSlice.iterate(function (tile) {

            tile.parentTilemap = ____canvas.tilemap;

            tile.visible = visible;

            ____canvas.tilemap.addTile(tile);
        });

        __threeSlice.setWidth(__width);

        __threeSlice.setZ(z);

        __graphic.parentTilemap = ____canvas.tilemap;

        __graphic.width = 32;

        __graphic.height = 22;

        __graphic.visible = visible;

        __graphic.z = z - 1;

        ____canvas.tilemap.addTile(__graphic);

        __bitmapText.parent = ____canvas.charmap;

        __bitmapText.z = z - 2;

        __bitmapText.addToParent();

        value = __value;

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

    private function __initGraphics():Void {

        __threeSlice.get(0).id = ____canvas.tilemap.tileset.names.get('slider_0');

        __threeSlice.get(1).id = ____canvas.tilemap.tileset.names.get('slider_1');

        __threeSlice.get(2).id = ____canvas.tilemap.tileset.names.get('slider_2');

        __graphic.id = ____canvas.tilemap.tileset.names.get('empty');
    }

    override function __setGraphicX():Void {

        __bitmapText.x = Math.round(____offsetX + __x + (__width / 2) - (__bitmapText.width / 2));

        __graphic.x = ____offsetX + __x + 1;

        __threeSlice.setX(__x + ____offsetX);
    }

    override function __setGraphicY():Void {

        __bitmapText.y = ____offsetY + __y + 2;

        __graphic.y = ____offsetY + __y + 1;

        __threeSlice.setY(__y + ____offsetY);
    }

    // ** Getters and setters.

    private function get_max():Float {
        
        return __max;
    }

    private function set_max(value:Float):Float {

        __max = value;

        this.value = __value;

        return __max;
    }

    private function get_min():Float {
        
        return __min;
    }

    private function set_min(value:Float):Float {

        __min = value;

        this.value = __value;

        return value;
    }

    private function get_precision():Int {
        
        return __precision;
    }

    private function set_precision(value:Int):Int {
        
        __precision = value;

        this.value = __value;

        return value;
    }

    private function get_value():Float {
        
        return __value;
    }

    private function set_value(value:Float):Float {

        __value = Common.clamp(Common.roundWithPrecision((value / __max) * 100, __precision), __max, __min);

        __bitmapText.text = Std.string(__value);

        __bitmapText.x = Math.round(____offsetX + __x + (__width / 2) - (__bitmapText.width / 2));

        __graphic.width = (__value / __max) * (width - 2);

        return __value;
    }

    override function set_width(value:Float):Float {

        __threeSlice.setWidth(value);

        __bitmapText.x = (value / 2) - (__bitmapText.width / 2);

        return super.set_width(value);
    }
}