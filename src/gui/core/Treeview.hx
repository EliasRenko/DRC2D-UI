package gui.core;

import gui.core.ListItem;
import gui.events.ControlEventType;
import gui.core.AlignType;

class Treeview extends Container<ListItem<Label>> {

    private var __rootNode:RootTreeviewItem;

    private var __treeviewItemMenu:TreeviewItemMenu;

    public function new(width:Float, alignType:AlignType = VERTICAL, x:Float = 0, y:Float = 0) {
        
        super(width, 0, alignType, x, y);

        __treeviewItemMenu = new TreeviewItemMenu();

        __rootNode = new RootTreeviewItem(null, new Label("Root"), width);

        __rootNode.padding.left = -8;

        __padding = {left: 0, right: 0, top: 0, bottom: 0};

        __type = 'list';
    }

    override function init() {

        super.init();

        for (listItem in __controls) {

            listItem.y = height;

            height += listItem.height;
        }

        ____canvas.addControl(__treeviewItemMenu);
    }

    override function release() {
        
        super.release();
    }

    var index:Int = 0;

    public function addControl(parentNode:TreeviewItem, control:Label):Control {

        if (parentNode == null) {

            parentNode = __rootNode;
        }

        var _listItem:TreeviewItem = new TreeviewItem(parentNode, control, __treeviewItemMenu, width);

        _listItem.type = Std.string(index);

        index ++;

        _listItem.addEventListener(__onItemClickEvent, LEFT_CLICK);

        // **

        __addControl(_listItem);

        if (____canvas != null) {
            
            //_listItem.y = height;

            __height = _listItem.y + _listItem.height + _listItem.padding.top;
		}

        return _listItem;
    }

    public function addAfter(prev:Control, parentNode:TreeviewItem, control:Label):Control {
        
        var _listItem:TreeviewItem = new TreeviewItem(parentNode, control, __treeviewItemMenu, width);

        _listItem.addEventListener(__onItemClickEvent, LEFT_CLICK);

        // **

        __addControlAfter(prev, _listItem);

        if (____canvas != null) {
            
            var _last:Null<ListItem<Label>> = controls.last();

            //__height = _listItem.y + _listItem.height + _listItem.padding.top;

            __height = _last.y + _last.height;
		}

        return _listItem;
    }

    public function removeControl(control:Label):Bool {

        for (listItem in __controls) {

            if (listItem.item == control) {

                __removeControl(listItem);

                height -= control.height;

                var _y:Float = 0;
        
                for (listItem in __controls) {
        
                    listItem.y = _y;
        
                    _y += listItem.height;
                }

                return true;
            }
        }

        return false;
    }

    public function removeControlAt(index:UInt):Bool {
        
        var i:Int = 0;

        for (listItem in __controls) {

            if (i == index) {

                __removeControl(listItem);

                height -= listItem.height;

                var _y:Float = 0;
        
                for (listItem in __controls) {
        
                    listItem.y = _y;
        
                    _y += listItem.height;
                }

                return true;
            }

            i ++;
        }

        return false;
    }

    public function clear():Void {
        
        height = 0;

        __clear();
    }

    public function onItemClick(control:Control):Void {
        
        dispatchEvent(control, ON_ITEM_CLICK);
    }

    private function __onItemClickEvent(control:Control, type:UInt):Void {

        onItemClick(control);
    }
}

private class RootTreeviewItem extends TreeviewItem {

    public function new(parentNode:ListItem<Label>, control:Label, width:Float) {
        
        super(parentNode, control, null, width);
    }

    override function setPadding():Void {

    }
}

private class TreeviewItem extends ListItem<Label> {
    
    public var parentNode:ListItem<Label>;

    public var items:Array<ListItem<Label>>;

    public function new(parentNode:ListItem<Label>, control:Label, menu:TreeviewItemMenu, width:Float) {
        
        super(control, width);

        this.parentNode = parentNode;

        contextMenu = menu;

        setPadding();
    }

    public function setPadding():Void {
        
        padding.left = parentNode.padding.left + 8;
    }

    override function onContextMenuSelect(value:String) {
        
        var _treeview:Treeview = cast parent;

        //_treeview.addControl(this, new Label("New Item"));

        _treeview.addAfter(this, this, new Label("New Item"));
    }
}

private class TreeviewItemMenu extends ContextMenu {

    public function new() {
        
        super(128, ['Add Item', 'Add Folder']);
    }
}