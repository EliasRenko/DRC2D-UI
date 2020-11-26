package gui.core;

import drc.display.Tile;

class ListItem extends Container {

    // ** Privates.

    /** @private **/ private var __graphic:Tile;

    public function new(control:Control, width:Float, y:Float) {

        super(width, control.height, 0, y);

        __graphic = new Tile(null, null);

        addControl(control);
    }

    override function init():Void {

        __graphic.id = ____canvas.tilemap.tileset.names.get('empty');

        __graphic.parentTilemap = ____canvas.tilemap;

        __graphic.visible = false;

        @:privateAccess ____canvas.tilemap.addTile(__graphic);

        __graphic.width = __width;

        __graphic.height = __height;

        super.init();
    }

    override function release():Void {

        super.release();
    }

    override function update():Void {

        var control:Control = __controls.first();

        if (control.hitTest()) control.update();

        if (__hover) {

            onMouseHover();
        }
        else {

            onMouseEnter();
        }
    }

    override function onMouseEnter():Void {

        __graphic.visible = true;

        super.onMouseEnter();
    }

    override function onMouseLeave():Void {

        __graphic.visible = false;

        super.onMouseLeave();
    }

    override function __setGraphicX():Void {

        __graphic.x = ____offsetX + __x;
    }

    override function __setGraphicY():Void {

        __graphic.y = ____offsetY + __y;
    }
}