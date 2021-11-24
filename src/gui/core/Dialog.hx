package gui.core;

class Dialog extends Window {

    public function new(text:String, width:Float, height:Float) {
        
        super(text, width, height, NONE, 0, 0);

        __type = 'dialog';
    }

    override function init() {
        
        super.init();
    }

    override function update():Void {
        
        super.update();
    }
}