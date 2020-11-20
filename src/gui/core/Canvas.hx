package gui.core;

import drc.display.Text;
import drc.display.Charmap;
import drc.objects.State;
import drc.display.Tile;
import drc.display.Tilemap;
import drc.utils.Common;

import haxe.Json;
import drc.display.Tileset;
import drc.display.Region;

class Canvas {
    
    // ** Publics.

    public var markedControl(get, set):Control;

    public var mouseX(get, null):Int;
	
    public var mouseY(get, null):Int;
    
    public var leftClick(get, null):Bool;

    public var tilemap:Tilemap;

    public var charmap:Charmap;

    // ** Privates.

    /** @private **/ private var __container:RootContainer;

    /** @private **/ private var __parentState:State;

    /** @private **/ private var __markedControl:Control;

    // ** Debug.

    #if debug

    public var __debugTilemap:Tilemap;

    #end

    public function new(parentState:State) {
        
        __parentState = parentState;

        __container = new RootContainer(640, 480);

        @:privateAccess __container.____canvas = this;

        __markedControl = __container;

        tilemap = new Tilemap(Common.resources.getProfile('res/profiles/gui.json'), [Common.resources.getTexture('res/graphics/gui.png')], __loadTileset());

        __parentState.addGraphic(tilemap);

        //tilemap.tileset.addRegion([0, 0, 32, 32]);

        //tilemap.tileset.addRegion([8, 8, 32, 32]);

        // ** 

        charmap = new Charmap(Common.resources.getProfile('res/profiles/default.json'), Common.resources.getFont('res/fonts/font.json'));

        __parentState.addGraphic(charmap);

        // ** 

        var stamp:Stamp = new Stamp(0, 64, 64);

        //addControl(stamp);

        var stamp2:Stamp = new Stamp(1, 0, 0);

        //addControl(stamp2);

        //removeControl(stamp);

        var strip:Strip = new Strip(128, 0, 0);

        strip.addControl(stamp2);

        //addControl(strip);

        //var panel:Panel = new Panel(128, 128, 128, 128);

        //addControl(panel);

        var window:Window = new Window('New Window', 128, 256, 190, 128);

        addControl(window);

        //var label:Label = new Label('New Window', 128, 128);

        //addControl(label);

        var list:List = new List(128, 128, 128);

        addControl(list);

        var _label_1 = list.addControl(new Label('Item1', 0, 0));
        list.addControl(new Label('Item2', 0, 0));
        var _label_3 = list.addControl(new Label('Item3', 0, 0));
        list.addControl(new Label('Item4', 0, 0));
        var _label_5 = list.addControl(new Label('Item5', 0, 0));

        list.removeControl(_label_3);
        list.removeControl(_label_5);
    }

    private function __loadTileset():Tileset {

        //** Create a new tileset class.
		
		var tileset:Tileset = new Tileset();
		
		var regions:Array<Region>;
		
		//** Parse the requested profile source file.
		
		var data:Dynamic = Json.parse(Common.resources.getText("res/graphics/gui.json"));
		
		#if debug // ------
		
		//** Parse the name.
		
		var name:String = data.name;
		
		#end // ------
		
		if (Reflect.hasField(data, "regions")) {

			var regionsData:Dynamic = Reflect.field(data, "regions");
			
			regions = new Array<Region>();
			
			for (i in 0...regionsData.length) {

				var name:String = regionsData[i].name;

				var region:Region = regionsData[i].dimensions;

				regions[regionsData[i].id] = region;

				tileset.addRegion(region, name);
			}
		}
		
		#if debug // ------
		
		else 
		{
			throw "Tileset: " + name + " has no regions attached.";
		}
		
		#end // ------
		
		// ** Return.
		
		return tileset;
    }

    private function addControl(control:Control):Control {
        
        return __container.addControl(control);
    }

    private function removeControl(control:Control):Void {
        
        return __container.removeControl(control);
    }

    public function update():Void {
        
        __container.update();
    }

    // ** Getters and setters.

    private function get_markedControl():Control {

        return __markedControl;
    }

    private function set_markedControl(control:Control):Control {

        __markedControl.onMouseLeave();

        __markedControl = control;

        return control;
    }

    private function get_mouseX():Int {

        return __parentState.mouseX;
    }

    private function get_mouseY():Int {

        return __parentState.mouseY;
    }

    private function get_leftClick():Bool {

        return Common.input.mouse.leftClick;
    }

    #if debug

    private function get_debugTilemap():Tilemap {

        return __debugTilemap;
    }

    #end
}

private class RootContainer extends Container {

    public function new(width:Float, height:Float) {

        super(width, height, 0, 0);
    }
}