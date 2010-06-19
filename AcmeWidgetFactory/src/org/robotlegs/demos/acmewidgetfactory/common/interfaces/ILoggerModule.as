package org.robotlegs.demos.acmewidgetfactory.common.interfaces
{
	
	public interface ILoggerModule extends IContextProvider
	{
		function logMessage(message:String):void;
		function clearMessages():void;
		function close():void;
	}
}