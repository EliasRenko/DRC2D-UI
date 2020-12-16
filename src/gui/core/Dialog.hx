package gui.core;

class Dialog extends Window {

    public function new(text:String, width:Float, height:Float) {
        
        super(text, width, height, 0, 0);

        __type = 'dialog';
    }

    override function update() {
        
        super.update();
    }
}