package ui;

import drc.part.Group;
import ui.UiEventType;
import ui.UiContainer;

class UiLayout extends UiContainer {

	public function new(width:Float, height:Float, x:Float = 0, y:Float = 0) {

		super(width, height, x, y);
	}

	public function addControl(control:UiControl):UiControl {

		return super.__addControl(control);
	}

	public function removeControl(control:UiControl):Void {
		
		super.__removeControl(control);
	}
}
