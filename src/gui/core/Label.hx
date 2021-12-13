package gui.core;

import drc.math.Rectangle;
import drc.display.Text;

class Label extends Control {

    public var text(get, set):String;

    // ** Privates.

    private var __bitmapText:Text;

    public function new(text:String, alignType:AlignType = VERTICAL, x:Float = 0, y:Float = 0) {
        
        super(alignType, x, y);

        __bitmapText = new Text(null, text, x, y);

        __type = 'label';
    }

    override function init():Void {
        
        super.init();

        __bitmapText.parent = ____canvas.charmap;

        __bitmapText.addToParent();

        __width = __bitmapText.width;

        __height = __bitmapText.height;

        setMask(mask);        
    }

    override function setMask(rectangle:Rectangle) {

        super.setMask(rectangle);

        for (i in 0...__bitmapText.__characters.length) {

            __bitmapText.__characters[i].setAttribute("mx", rectangle.x);

            __bitmapText.__characters[i].setAttribute("my", rectangle.y);

            __bitmapText.__characters[i].setAttribute("mw", rectangle.width);

            __bitmapText.__characters[i].setAttribute("mh", rectangle.height);
        }
    }

    override function release():Void {

        __bitmapText.dispose();

        super.release();
    }

    override function onMouseLeftClick() {

        super.onMouseLeftClick();
    }

    override function __setGraphicX():Void {

        __bitmapText.x = ____offsetX + __x;
    }

    override function __setGraphicY():Void {

        __bitmapText.y = ____offsetY + __y;
    }

    // ** Getters and setters.

    override function get_height():Float {

        return super.get_height();
    }

    public function get_text():String {

        return __bitmapText.text;
    }
    
    public function set_text(text:String):String {
        
        __bitmapText.text = text;
        
        __width = __bitmapText.width;
        
        __height = __bitmapText.height;
        
        return text;
    }

    override function set_visible(value:Bool):Bool {

        __bitmapText.visible = value;

        return super.set_visible(value);
    }

    override function set_z(value:Float):Float {

        __bitmapText.z = value;

        return super.set_z(value);
    }
}