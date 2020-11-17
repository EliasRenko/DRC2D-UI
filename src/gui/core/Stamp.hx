package gui.core;

import drc.display.Tile;
import gui.events.ControlEventType;

class Stamp extends Control {

    // ** Publics.

    public var id(get, set):Int;

    // ** Privates.

    /** @private **/ private var __graphic:Tile;

    /** @private **/ private var __id:Int;

    public function new(id:UInt, x:Int = 0, y:Int = 0) {
        
        super(x, y);

        __graphic = new Tile(null, id);
    }

    override function init():Void {

        super.init();

        __graphic.parentTilemap = ____canvas.tilemap;

        @:privateAccess ____canvas.tilemap.addTile(__graphic);

        __width = __graphic.width;

        __height = __graphic.height;
    }

    override function release():Void {

        ____canvas.tilemap.removeTile(__graphic);

        super.release();
    }

    override function update():Void {

        super.update();

        if (____canvas.leftClick) {
             
            onMouseLeftClick();
        }
    }

    override function onMouseEnter():Void {

        super.onMouseEnter();

        trace('Enter');
    }

    override function onMouseLeave():Void {

        super.onMouseLeave();

        trace('Leave');
    }

    override function onMouseHover():Void {

        super.onMouseHover();

        trace('Hover');
    }

    override function __setGraphicX():Void {

        __graphic.x = ____offsetX + __x;
    }

    override function __setGraphicY():Void {

        __graphic.y = ____offsetY + __y;
    }

    // ** Getters and setters.

    private function get_id():Int {

        return __id;
    }
    
    private function set_id(value:Int):Int {
        
        return __id = value;
    }
}