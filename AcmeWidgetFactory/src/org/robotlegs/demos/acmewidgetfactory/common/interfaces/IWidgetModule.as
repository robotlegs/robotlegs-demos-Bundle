package org.robotlegs.demos.acmewidgetfactory.common.interfaces
{
	
	public interface IWidgetModule extends IContextProvider
	{
		function setTitle(title:String):void;
		function poke():void;
		function close():void;
	}
}