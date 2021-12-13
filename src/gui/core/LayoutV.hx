package gui.core;

import drc.ds.LinkedList;
import gui.core.Control;

class LayoutV<T:Control> extends Container<T> {

    public function new(width:Float, heigth:Float, alignType:AlignType = VERTICAL, x:Float = 0, y:Float = 0) {
        
        super(width, heigth, alignType, x, y);

        type = 'layoutV';
    }
}

private class ControlList extends LinkedList<T:Control> {

    public function new() {
        
        super();
    }
}