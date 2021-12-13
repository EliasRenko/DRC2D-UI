package gui.core;

import gui.events.ControlEventType;

class TreeviewItem extends ListItem<Control> {
    
    public final DEFAULT_PADDING:Float = 12;

    public var items:Array<TreeviewItem> = new Array<TreeviewItem>();

    public var stamp:Stamp;

    public var show:Bool = true;

    // ** Privates.

    public var __root:TreeviewItem;

    public function new(root:TreeviewItem, control:Label, width:Float) {

        super(control, width);

        stamp = new Stamp(3, NONE, 0, 3);

        stamp.addEventListener(__onStampClick, LEFT_CLICK);

        __addControl(stamp);

        __root = root;

        //contextMenu = menu;

        setPadding();
    }

    public function setPadding():Void {

        __root.items.push(this);
        
        //padding.left = parentNode.padding.left + 8;

        stamp.x = __root.item.padding.left;

        item.padding.left = __root.item.padding.left + 8 + DEFAULT_PADDING;
    }

    override function onContextMenuSelect(value:String) {
        
        var _treeview:Treeview = cast parent;

        //_treeview.addControl(this, new Label("New Item"));

        if (!show) {

            show = true;

            for (i in 0...items.length) {

                items[i].visible = show;
            }
        }

        _treeview.addAfter(this, this, new Label("New Item"));
    }

    private function __onStampClick(control:Control, type:UInt):Void {

        if (show) {

            show = false;

            stamp.id = 4;
        }
        else {

            show = true;

            stamp.id = 3;
        }

        for (i in 0...items.length) {

            items[i].visible = show;
        }

        var _treeview:Treeview = cast parent;

        _treeview.alignFrom(this);
    }

    override function set_visible(value:Bool):Bool {

        if (visible) {

            show = value;

            for (i in 0...items.length) {

                items[i].visible = value;
            }
        }

        return super.set_visible(value);
    }
}