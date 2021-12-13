package gui.core;

import drc.display.Text;
import drc.display.Charmap;
import drc.objects.State;
import drc.display.Tile;
import drc.display.Tilemap;
import drc.utils.Common;
import drc.input.MouseControl;
import drc.types.WindowEventType;
import tests.IntroDialog;
import drc.ds.LinkedList;

import haxe.Json;
import drc.display.Tileset;
import drc.display.Region;

class Canvas {
    
    // ** Publics.

    public var controls(get, null):LinkedList<Control>;

    public var dialog(get, set):Dialog;

    public var markedControl(get, set):Control;

    public var focusedControl(get, set):Control;

    public var contextMenu:ContextMenu;

    public var mouseX(get, null):Int;
	
    public var mouseY(get, null):Int;

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

        charmap = new Charmap(Common.resources.getProfile('res/profiles/uiFont.json'), Common.resources.getFont('res/fonts/nokiafc22.json'));

        __parentState.addGraphic(charmap);

        if (toolstrip) {

            __toolstripmenu = new Toolstripmenu();

            __toolstripmenu.z = -32;

            addControl(__toolstripmenu);
        }

        Common.window.addEventListener(__onWindowResize, WindowEventType.RESIZED);

        __dialog = new IntroDialog();

        addControl(__dialog);

        __dialog.visible = true;

        __dialog.x = Math.round(__container.width / 2) - (__dialog.width / 2);

        __dialog.y = Math.round(__container.height / 2) - (__dialog.height / 2);

        parser = new CanvasParser(this);

        //parser.parseUI(Common.resources.getText("res/ui/canvas1.json"));

        //var _checkbox:Checkbox = new Checkbox(false, 32, 32);

        //addControl(_checkbox);

        tilemap.uniforms.get('resolution').value = [640.0, 480.0];

        charmap.uniforms.get('resolution').value = [640.0, 480.0];
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

            if (Common.input.mouse.pressed(ANY)) {

                contextMenu.visible = false;

                contextMenu = null;
            }
            else if (contextMenu.visible) {

                return;
            }
        }

        if (focusedControl.preUpdate()) return;

        __container.update();

        return;
    }

    public function startTextInput(textfield:Textfield):Void {

    }

    public function stopTextInput(textfield:Textfield):Void {

    }

    private function __onWindowResize(window:drc.system.Window, type:UInt):Void {

        tilemap.uniforms.get('resolution').value = [window.width, window.height];

        __container.resize(window.width, window.height);

        __dialog.x = Math.round(__container.width / 2) - (__dialog.width / 2);

        __dialog.y = Math.round(__container.height / 2) - (__dialog.height / 2);
    }

    // ** Getters and setters.

    private function get_controls():LinkedList<Control> {

		return __container.controls;
    }

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

    #if debug

    private function get_debugTilemap():Tilemap {

        return __debugTilemap;
    }

    #end
}

private class RootContainer extends Container<Control> {

    public function new(width:Float, height:Float) {

        super(width, height, NONE, 0, 0);

        __type = "canvas";
    }

    override function init() {

        super.init();
    }

    public function addControl(control:Control):Control {
        
        return __addControl(control);
    }

    public function resize(width:Float, height:Float):Void {
        
        this.width = width;

        this.height = height;

        onParentResize();
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
        
        var _label:Label = new Label(text, VERTICAL, x, y);

        __canvas.addControl(_label);

        return _label;
    }

    private function addButton(text:String, width:Float, x:Float, y:Float):Button {
        
        var _button:Button = new Button(text, width, NONE, x, y);

        __canvas.addControl(_button);

        return _button;
    }

    private function addWindow(text:String, width:Float, height:Float, x:Float, y:Float):Window {
        
        var _window:Window = new Window(text, width, height, x, y);

        __canvas.addControl(_window);

        return _window;
    }
}