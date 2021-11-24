package gui.core;

import drc.display.Tile;
import gui.events.ControlEventType;

class Stamp extends Control {

    // ** Publics.

    public var id(get, set):Int;

    // ** Privates.

    /** @private **/ private var __graphic:Tile;

    public function new(id:UInt, alignType:AlignType, x:Float, y:Float) {
        
        super(alignType, x, y);

        __graphic = new Tile(null, id);

        __type = 'stamp';
    }

    override function init():Void {

        super.init();

        __graphic.parentTilemap = ____canvas.tilemap;

        __graphic.visible = visible;

        ____canvas.tilemap.addTile(__graphic);

        __width = __graphic.width;

        __height = __graphic.height;
    }

    override function release():Void {

        ____canvas.tilemap.removeTile(__graphic);

        super.release();
    }

    override function update():Void {

        super.update();
    }

    override function onMouseLeftClick() {
        
        super.onMouseLeftClick();
    }

    override function __setGraphicX():Void {

        __graphic.x = ____offsetX + __x;
    }

    override function __setGraphicY():Void {

        __graphic.y = ____offsetY + __y;
    }

    // ** Getters and setters.

    private function get_id():Int {

        return __graphic.id;
    }
    
    private function set_id(value:Int):Int {
        
        __graphic.id = value;

        __width = __graphic.width;

        __height = __graphic.height;

        return value;
    }

    override function set_visible(value:Bool):Bool {

        __graphic.visible = value;

        return super.set_visible(value);
    }

    override function set_z(value:Float):Float {

        __graphic.z = value;

        return super.set_z(value);
    }
}