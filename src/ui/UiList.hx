package ui;

import ui.UiEventType;

class UiList<T:UiControl> extends UiLayout
{
	//** Publics.
	
	public var onClickHandler:UiControl->Void;
	
	//** Privates.
	
	/** @private */ private var __lastItem:Float = 0;
	
	public function new(width:Float = 128, height:Float = 128, x:Float = 0, y:Float = 0, handler:UiControl->Void = null) 
	{
		super(width, 0, x, y);
		
		onClickHandler = handler;
	}
	
	override public function init():Void 
	{
		super.init();
		
		for (i in 0...__controls.count) 
		{
			__controls.members[i].y = __lastItem;
			
			__lastItem += __controls.members[i].height;
			
			height = __lastItem + 4;
		}
	}
	
	override public function release():Void 
	{
		super.release();
	}
	
	public function addListItem(control:T):UiControl
	{
		//var item:UiControl = addControl(new UiListItem(control, 4, __lastItem, onLeftClick, onRightClick));
		
		var listItem:UiListItem<T> = new UiListItem<T>(control, 4, __lastItem);
		
		addControl(listItem);

		listItem.onEvent.add(__onItem_click, ON_CLICK);
		
		control.x += 2;
		
		//if (control.height > 16)
		//{
			//control.y += (control.height / 2) - 11;
		//}
		
		if (__form != null)
		{
			__lastItem += listItem.height;
			
			height = __lastItem + 4;
		}
		
		return control;
	}

	override function clear():Void {

		super.clear();

		__lastItem = 4;
	}
	
	override public function update():Void {

		super.update();
	}
	
	override public function updateCollision():Void {

		super.updateCollision();
		
		if (collide)
		{
			//** Call updateCollision method of the scroll bar.
			
			if (__form.leftClick)
			{
				//trace('Collision: ' + __collisionIndex);
			}
		}
	}

	private function __onItem_click(control:UiControl, type:UiEventType):Void {

		onEvent.dispatch(control, ON_ITEM_CLICK);
	}
	
	//** Getters and setters.
	
	override function set_height(value:Float):Float 
	{
		//__panel.height = value;
		
		return super.set_height(value);
	}
	
	override function set_visible(value:Bool):Bool 
	{
		//__panel.visible = value;
		
		return super.set_visible(value);
	}
	
	override function set_width(value:Float):Float 
	{
		//__panel.width = value;
		
		return super.set_width(value);
	}
	
	override function set_x(value:Float):Float 
	{
		return super.set_x(value);
	}
	
	override function set_y(value:Float):Float 
	{
		return super.set_y(value);
	}
	
	override function set_z(value:Float):Float 
	{
		return super.set_z(value);
	}
}