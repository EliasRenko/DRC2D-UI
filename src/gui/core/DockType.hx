package gui.core;

@:enum abstract DockType(UInt) from UInt to UInt {

	var NONE = 0;

    var LEFT = 1;

    var RIGHT = 2;

    var TOP = 3;

    var BOTTOM = 4;
}