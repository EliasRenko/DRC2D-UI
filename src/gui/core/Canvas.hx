package gui.core;

import drc.display.Text;
import drc.display.Charmap2;
import drc.objects.State;
import drc.display.Tile;
import drc.display.Tilemap;
import drc.utils.Common;

class Canvas {
    
    // ** Publics.

    public var markedControl(get, set):Control;

    public var mouseX(get, null):Int;
	
    public var mouseY(get, null):Int;
    
    public var leftClick(get, null):Bool;

    public var tilemap:Tilemap;

    public var charmap:Charmap2;

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

        tilemap = new Tilemap(Common.resources.getProfile('res/profiles/default.json'), [Common.resources.getTexture('res/graphics/grid_bw.png')]);

        __parentState.addGraphic(tilemap);

        tilemap.tileset.addRegion([0, 0, 32, 32]);

        tilemap.tileset.addRegion([8, 8, 32, 32]);

        // ** 

        charmap = new Charmap2(Common.resources.getProfile('res/profiles/default.json'), Common.resources.getFont('res/fonts/font.json'));

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

        var window:Window = new Window(128, 128, 128, 128);

        addControl(window);
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