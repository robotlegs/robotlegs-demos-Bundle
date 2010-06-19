package org.robotlegs.demos.acmewidgetfactory.shell.view
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.demos.acmewidgetfactory.shell.controller.ShellEvent;
	import org.robotlegs.demos.acmewidgetfactory.shell.controller.ShellWidgetEvent;
	import org.robotlegs.mvcs.Mediator;
	
	public class ControlPanelMediator extends Mediator
	{
		[Inject]
		public var view:ControlPanelView;
		
		public function ControlPanelMediator()
		{
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.createWidgetButton, MouseEvent.CLICK, onCreateWidgetClick);
			eventMap.mapListener(view.pokeWidgetButton, MouseEvent.CLICK, onPokeWidgetClick);
			eventMap.mapListener(view.destroyWidgetButton, MouseEvent.CLICK, onDestroyWidgetClick);
			eventMap.mapListener(view.destroyAllWidgetsButton, MouseEvent.CLICK, onDestroyAllClick);
			eventMap.mapListener(view.clearLoggerButton, MouseEvent.CLICK, onClearLoggerClick);
		}
		
		protected function onCreateWidgetClick(e:MouseEvent):void
		{
			eventDispatcher.dispatchEvent(new ShellWidgetEvent(ShellWidgetEvent.CREATE_WIDGET, view.widgetId.text));
		}
		
		protected function onPokeWidgetClick(e:MouseEvent):void
		{
			eventDispatcher.dispatchEvent(new ShellWidgetEvent(ShellWidgetEvent.POKE_WIDGET, view.widgetId.text));
		}
		
		protected function onDestroyWidgetClick(e:MouseEvent):void
		{
			eventDispatcher.dispatchEvent(new ShellWidgetEvent(ShellWidgetEvent.REMOVE_WIDGET, view.widgetId.text));
		}
		
		protected function onDestroyAllClick(e:MouseEvent):void
		{
			eventDispatcher.dispatchEvent(new ShellEvent(ShellEvent.REMOVE_ALL_WIDGETS));
		}
	
		protected function onClearLoggerClick(e:MouseEvent):void
		{
			eventDispatcher.dispatchEvent(new ShellEvent(ShellEvent.CLEAR_LOGGER));
		}
	
	}
}