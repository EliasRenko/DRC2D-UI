package ui;

import drc.display.Tile;
import ui.UiContainer;
import ui.UiControl;
import ui.UiEventType;

class UiListItem<T:UiControl> extends UiContainer {

	// ** Publics.

	public var control(get, null):UiControl;

	// ** Privates.
	
	/** @private **/ private var __graphic:Tile;
	
	public function new(control:UiControl, x:Float = 0, y:Float = 0) {

		super(control.width, control.height, x, y);
		
		__addControl(control);

		//control.onEvent.add(__onItemHover, UiEventType.ON_ITEM_MOUSE_HOVER);
		
		//** Create a new graphic class.

		__graphic = new Tile(null, null);
	}
	
	override public function init():Void {

		super.init();
		
		__width = __parent.width - 8;
		
		if (__controls.members[0].height > 16) {

			__height = __controls.members[0].height + 8;
			
			__controls.members[0].y = 4;
		}

		//** Set the graphics parent.
		
		__graphic.parentTilemap = @:privateAccess __form.__tilemap;
		
		//** Add the graphic to it's parent.
		
		@:privateAccess __form.__tilemap.addTile(__graphic);
		
		//** Pass the items width value to the graphic.
		
		__graphic.width = __width;
		
		//** Pass the items height value to the graphic.
		
		__graphic.height = __height;
		
		//** Pass the items visibility value to the graphic.
		
		__graphic.visible = false;
		
		__graphic.z = __parent.z - 1;
		
		//** Call setGraphicX method.
		
		__setGraphicX();
		
		//** Call setGraphicY method.
		
		__setGraphicY();
		
		//** Set the hitbox.
		
		__setHitbox(0, 0, width, height);
		
		if (__mask) {

			// __graphic.setAttribute("maskX", __maskBox.x / 640);
			
			// __graphic.setAttribute("maskY", __maskBox.y / 480);
			
			// __graphic.setAttribute("maskW", __maskBox.width / 640);
			
			// __graphic.setAttribute("maskH", __maskBox.height / 480);
		}
	}

	override function __initGraphics() {

		__graphic.id = __form.getGraphic('empty');
	}
	
	override function release():Void {

		@:privateAccess __form.__tilemap.removeTile(__graphic);
		
		super.release();
	}
	
	private function __setGraphicX():Void {

		__graphic.x = __x + __offsetX;
	}
	
	private function __setGraphicY():Void {

		__graphic.y = __y + __offsetY;
	}
	
	override public function update():Void {

		super.update();

		//__graphic.visible = false;
	}
	
	override public function updateCollision():Void {

		super.updateCollision();
		
		//** If collide...
		
		if (collide) {

			//__graphic.visible = true;

			onEvent.dispatch(this, MOUSE_HOVER);
		}
	}
	
	private function __onItemHover(control:UiControl, type:UiEventType) {

		//onMouseHover();

		trace('Collide child!');
	}

	override function __onClick():Void {

		onEvent.dispatch(control, ON_CLICK);
	}
	
	override function onMouseHover():Void {

		//__graphic.visible = true;

		//super.onMouseHover();
	}

	override function onMouseLeave():Void {

		__graphic.visible = false;

		super.onMouseLeave();
	}

	//** Getters and setters.
	
	private function get_control():UiControl {

		return __controls.members[0];
	}

	override function set_visible(value:Bool):Bool {

		__graphic.visible = value ? __visible : false;
		
		return super.set_visible(value);
	}
	
	override function set_x(value:Float):Float {

		super.set_x(value);
		
		//** Call setGraphicX method.
		
		__setGraphicX();
		
		return value;
	}
	
	override function set_y(value:Float):Float {

		super.set_y(value);
		
		//** Call setGraphicY method.
		
		__setGraphicY();
		
		return value;
	}
	
	override function set_z(value:Float):Float {

		return super.set_z(value);
	}
	
	override function __setOffsetX(value:Float):Void {

		super.__setOffsetX(value);
		
		__setGraphicX();
		
		//@:privateAccess __control.__setOffsetX(__x + value);
	}
	
	override function __setOffsetY(value:Float):Void {
		
		super.__setOffsetY(value);
		
		__setGraphicY();
		
		//@:privateAccess __control.__setOffsetY(__y + value);
	}
}