package gui.core;

import drc.display.Text;
import gui.core.Control;

class Button extends Control {

    // ** Publics.

    public var text(get, set):String;

    // ** Privates.

    /** @private **/ private var __bitmapText:Text;

    /** @private **/ private var __threeSlice:ThreeSlice = new ThreeSlice();
    
    public function new(text:String, width:Float, alignType:AlignType, x:Float, y:Float) {
        
        super(alignType, x, y);

        __bitmapText = new Text(null, text, 0, 0);

        __height = 24;

        __width = width;

        type = 'button';
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

        __bitmapText.x = Math.round(__x + ____offsetX + (__width / 2) - (__bitmapText.width / 2));

        __threeSlice.setX(__x + ____offsetX);
    }

    override function __setGraphicY():Void {

        __bitmapText.y = __y + ____offsetY + 2;

        __threeSlice.setY(__y + ____offsetY);
    }

    override function onFocusGain() {
        super.onFocusGain();
    }

    override function onFocusLost() {
        super.onFocusLost();
    }

    // ** Getters and setters.

    private function get_text():String {
        
        return __bitmapText.text;
    }

    private function set_text(value:String):String {

        return __bitmapText.text = value;
    }

    override function set_visible(value:Bool):Bool {

        __threeSlice.setVisible(value);

        __bitmapText.visible = value;

        return super.set_visible(value);
    }

    override function set_width(value:Float):Float {

        __threeSlice.setWidth(value);

        __bitmapText.x = __x + (value / 2) - (__bitmapText.width / 2);

        return super.set_width(value);
    }

    override function set_z(value:Float):Float {

        __threeSlice.setZ(value);

        __bitmapText.z = value - 1;

        return super.set_z(value);
    }
}