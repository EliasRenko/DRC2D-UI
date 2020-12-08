package gui.core;

import drc.display.Tile;
import gui.core.Stamp;

class Checkbox extends Control {

    // ** Publics.

    public var value(get, set):Bool;

    // ** Privates.

    /** @private **/ private var __graphic:Tile;

    /** @private **/ private var __value:Bool;

    public function new(value:Bool, x:Float, y:Float) {
        
        super(x, y);

        __graphic = new Tile(null, 2);

        __value = value;

        __type = 'checkbox';
    }

    override function init():Void {

        __initGraphics();

        __graphic.parentTilemap = ____canvas.tilemap;

        __graphic.visible = visible;

        ____canvas.tilemap.addTile(__graphic);

        __width = __graphic.width;

        __height = __graphic.height;

        super.init();
    }

    override function release():Void {

        ____canvas.tilemap.removeTile(__graphic);

        super.release();
    }

    override function update():Void {

        super.update();
    }

    override function onMouseLeftClick():Void {

        value = __value ? false : true;

        super.onMouseLeftClick();
    }

    private function __initGraphics():Void {

        __graphic.id = ____canvas.tilemap.tileset.names.get('checkbox_0');
    }

    override function __setGraphicX():Void {

        __graphic.x = ____offsetX + __x;
    }

    override function __setGraphicY():Void {

        __graphic.y = ____offsetY + __y;
    }

    // ** Getters and setters.

    private function get_value():Bool {
        
        return __value;
    }

    private function set_value(value:Bool):Bool {

        if (value) {

            __graphic.id = ____canvas.tilemap.tileset.names.get('checkbox_1');
        }
        else {

            __graphic.id = ____canvas.tilemap.tileset.names.get('checkbox_0');
        }

        return __value = value;
    }
}