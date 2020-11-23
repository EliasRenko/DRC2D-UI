package gui.core;

import drc.display.Tile;

class ListItem extends Container {

    // ** Privates.

    /** @private **/ private var __graphic:Tile;

    // ** Privates with access.

    /** @private **/ private var ____back:ListItem;

    /** @private **/ private var ____front:ListItem;

    public function new(control:Control, width:Float) {

        super(width, control.height, 0, 0);

        __graphic = new Tile(null, null);

        addControl(control);
    }

    override function init():Void {

        if (____front != null) {

            y = ____front.y + ____front.height;
        }

        __graphic.id = ____canvas.tilemap.tileset.names.get('empty');

        __graphic.parentTilemap = ____canvas.tilemap;

        __graphic.visible = false;

        @:privateAccess ____canvas.tilemap.addTile(__graphic);

        __graphic.width = __width;

        __graphic.height = __height;

        super.init();
    }

    override function release():Void {

        if (____front != null) {

            ____front.____back = ____back;
        }

        if (____back != null) {

            ____back.____front = ____front;

            ____back.setPosition();
        }

        super.release();
    }

    override function update() {

        var control:Control = __controls.first();

        if (control.hitTest()) control.update();

        if (__hover) {

            onMouseHover();
        }
        else {

            onMouseEnter();
        }
    }

    public function setPosition():Void {
        
        var _y:Float = 0;

        if (____front != null) {

            _y = ____front.y + ____front.height;
        }

        y = _y;

        if (____back == null) return;
            
        ____back.setPosition();
    }

    override function onMouseEnter() {

        __graphic.visible = true;

        super.onMouseEnter();
    }

    override function onMouseLeave() {

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