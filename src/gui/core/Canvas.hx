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

    public var dialog(get, set):Dialog;

    public var markedControl(get, set):Control;

    public var focusedControl(get, set):Control;

    public var contextMenu:ContextMenu;

    public var mouseX(get, null):Int;
	
    public var mouseY(get, null):Int;
    
    public var leftClick(get, null):Bool;

    public var rightClick(get, null):Bool;

    public var tilemap:Tilemap;

    public var toolstripmenu(get, null):Toolstripmenu;

    public var charmap:Charmap;

    // ** Privates.

    /** @private **/ private var __container:RootContainer;

    /** @private **/ private var __dialog:Dialog;

    /** @private **/ private var __parentState:State;

    /** @private **/ private var __markedControl:Control;

    /** @private **/ private var __focusedControl:Control;

    /** @private **/ private var __toolstripmenu:Toolstripmenu;

    // ** Debug.

    public var parser:CanvasParser;

    #if debug

    public var __debugTilemap:Tilemap;

    #end

    public function new(parentState:State, toolstrip:Bool = true) {
        
        __parentState = parentState;

        __container = new RootContainer(640, 480);

        @:privateAccess __container.____canvas = this;

        __markedControl = __container;

        __focusedControl = __container;

        tilemap = new Tilemap(Common.resources.getProfile('res/profiles/gui.json'), [Common.resources.getTexture('res/graphics/gui.png')], __loadTileset());

        __parentState.addGraphic(tilemap);

        charmap = new Charmap(Common.resources.getProfile('res/profiles/font copy.json'), Common.resources.getFont('res/fonts/font.json'));

        __parentState.addGraphic(charmap);

        if (toolstrip) {

            __toolstripmenu = new Toolstripmenu();

            __toolstripmenu.z = -32;

            addControl(__toolstripmenu);
        }

        __dialog = new Dialog('Intro', 256, 256);

        addControl(__dialog);

        __dialog.visible = true;

        __dialog.x = Math.round(__container.width / 2) - (__dialog.width / 2);

        __dialog.y = Math.round(__container.height / 2) - (__dialog.height / 2);

        parser = new CanvasParser(this);

        //parser.parseUI(Common.resources.getText("res/ui/canvas1.json"));

        //var _checkbox:Checkbox = new Checkbox(false, 32, 32);

        //addControl(_checkbox);

        tilemap.uniforms.get('resolution').value = [640.0, 480.0];

        return;

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

        var window:Window = new Window('Options', 128, 256, 190, 128);

        addControl(window);

        //var label:Label = new Label('New Window', 128, 128);

        //addControl(label);

        // var list:List<Control> = new List(128, 128, 128);

        // addControl(list);

        // var _label_1 = list.addControl(new Label('Item1', 0, 0));
        // list.addControl(new Label('Item2', 0, 0));
        // var _label_3 = list.addControl(new Label('Item3', 0, 0));
        // list.addControl(new Label('Item4', 0, 0));
        // var _label_5 = list.addControl(new Label('Item5', 0, 0));

        // list.removeControl(_label_3);
        //list.removeControl(_label_5);

        var slider:Slider = new Slider(230, 256, 68);

        addControl(slider);

        var button:Button = new Button("Confirm", 128, 128, 32);

        addControl(button);
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

    public function addControl(control:Control):Control {
        
        return __container.addControl(control);
    }

    public function removeControl(control:Control):Void {
        
        return __container.removeControl(control);
    }

    public function update():Void {
        
        if (__dialog.visible) {

            __dialog.update();

            return;
        }

        if (contextMenu != null) {

            contextMenu.update();

            if (leftClick || rightClick) {

                contextMenu.visible = false;

                contextMenu = null;
            }
            else 
            if (contextMenu.visible) {

                return;
            }
        }

        __container.update();

        return;
    }

    public function startTextInput(textfield:Textfield):Void {

    }

    public function stopTextInput(textfield:Textfield):Void {

    }

    // ** Getters and setters.

    private function get_dialog():Dialog {
        
        return __dialog;
    }

    private function set_dialog(dialog:Dialog):Dialog {
        
        if (__dialog == dialog) {

            __dialog.visible = true;

            return __dialog;
        }

        removeControl(__dialog);

        addControl(dialog);

        __dialog = dialog;

        __dialog.x = Math.round(__container.width / 2) - (__dialog.width / 2);

        __dialog.y = Math.round(__container.height / 2) - (__dialog.height / 2);

        __dialog.z = -128;

        return __dialog;
    }

    private function get_markedControl():Control {

        return __markedControl;
    }

    private function set_markedControl(control:Control):Control {

        __markedControl.onMouseLeave();

        __markedControl = control;

        return control;
    }

    private function get_focusedControl():Control {

        return __focusedControl;
    }

    private function set_focusedControl(control:Control):Control {

        if (control == null) control = __container;

        __focusedControl.onFocusLost();

        __focusedControl = control;

        return control;
    }

    private function get_toolstripmenu():Toolstripmenu {
        
        return __toolstripmenu;
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

    private function get_rightClick():Bool {

        return Common.input.mouse.rightClick;
    }

    #if debug

    private function get_debugTilemap():Tilemap {

        return __debugTilemap;
    }

    #end
}

private class RootContainer extends Container<Control> {

    public function new(width:Float, height:Float) {

        super(width, height, 0, 0);

        __type = "canvas";
    }

    public function addControl(control:Control):Control {
        
        return __addControl(control);
    }

    public function removeControl(control:Control):Void {
        
        return __removeControl(control);
    }

    override function get_contextMenu():ContextMenu {

        return null;
    }
}

private class CanvasParser {

    private var __canvas:Canvas;

    public function new(canvas:Canvas) {
        
        __canvas = canvas;
    }

    public function parseUI(source:String):Void {

        var _rootData:Dynamic = Json.parse(source);

        if (Reflect.hasField(_rootData, "controls")) {	

            var _controlData:Dynamic = Reflect.field(_rootData, "controls");

            for (i in 0..._controlData.length) {

                var _data:Dynamic = _controlData[i];

                switch (_data.control) {

                    case 'label':

                        addLabel(_data.text, _data.x, _data.y);

                    case 'button':

                        addButton(_data.text, _data.width, _data.x, _data.y);

                    case 'window':

                        addWindow(_data.text, _data.width, _data.height, _data.x, _data.y);

                    default:
                }
            }
        }
    }

    private function addLabel(text:String, x:Float, y:Float):Label {
        
        var _label:Label = new Label(text, x, y);

        __canvas.addControl(_label);

        return _label;
    }

    private function addButton(text:String, width:Float, x:Float, y:Float):Button {
        
        var _button:Button = new Button(text, width, x, y);

        __canvas.addControl(_button);

        return _button;
    }

    private function addWindow(text:String, width:Float, height:Float, x:Float, y:Float):Window {
        
        var _window:Window = new Window(text, width, height, x, y);

        __canvas.addControl(_window);

        return _window;
    }
}