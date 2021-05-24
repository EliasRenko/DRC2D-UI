package gui.core;

import drc.display.Tile;
import haxe.ds.Vector;

@:forward(get)
abstract NineSlice(Vector<Tile>) from Vector<Tile> to Vector<Tile> {
    
    public function new() {
        
        this = new Vector<Tile>(9);

        for (i in 0...9) {

            this.set(i, new Tile(null, null));
        }

        this.get(1).offsetX = 25;
		
		this.get(3).offsetY = 25;
		
		this.get(4).offsetX = 25;
		
		this.get(4).offsetY = 25;
		
		this.get(5).offsetY = 25;
		
        this.get(7).offsetX = 25;
    }

    public function iterate(func:(Tile)->Void):Void {
        
        for (tile in this) {

            func(tile);
        }
    }

    public function setHeight(value:Float):Void {
        
        this.get(3).height = value - (25 * 2);
		
		this.get(4).height = value - (25 * 2);
		
		this.get(5).height = value - (25 * 2);
		
		this.get(6).offsetY = value - 25;
		
		this.get(7).offsetY = value - 25;
		
        this.get(8).offsetY = value - 25;
    }

    public function setVisible(value:Bool):Void {
        
        for (tile in this) {

            tile.visible = value;
        }
    }

    public function setWidth(value:Float):Void {
        
        this.get(1).width = value - (25 * 2);
		
		this.get(2).offsetX = value - 25;
		
		this.get(4).width = value - (25 * 2);
		
		this.get(5).offsetX = value - 25;
		
		this.get(7).width = value - (25 * 2);
		
		this.get(8).offsetX = value - 25;
    }

    public function setX(value:Float):Void {
        
        for (tile in this) {

            tile.x = value;
        }
    }

    public function setY(value:Float):Void {
        
        for (tile in this) {

            tile.y = value;
        }
    }

    public function setZ(value:Float):Void {
        
        for (tile in this) {

            tile.z = value;
        }
    }
}