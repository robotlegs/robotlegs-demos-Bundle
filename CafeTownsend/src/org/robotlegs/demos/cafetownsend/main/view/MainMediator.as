package org.robotlegs.demos.cafetownsend.main.view
{
import org.robotlegs.demos.cafetownsend.main.model.events.MainEvent;
import org.robotlegs.demos.cafetownsend.main.model.events.SystemAlertEvent;
import org.robotlegs.demos.cafetownsend.main.view.components.interfaces.IMain;
import org.robotlegs.demos.cafetownsend.user.service.interfaces.IEmployeeLoginService;
import org.robotlegs.demos.cafetownsend.user.view.components.interfaces.IEmployeeLogin;

import robotlegs.bender.bundles.classic.impl.Mediator;

	/** @author Jonathan Toland */
public class MainMediator extends Mediator
{
	[Inject]
	public var main:IMain;
	[Inject]
	public var employeeLoginService:IEmployeeLoginService;

	[PostConstruct]
	public function onRegister():void
	{
		eventMap.mapListener(eventDispatcher, MainEvent.FOCUS, whenFocus, MainEvent);
		eventMap.mapListener(eventDispatcher, SystemAlertEvent.ALERT, whenAlert, SystemAlertEvent);
		main.activeViewComponentType = IEmployeeLogin;
	}
	
	private function whenFocus(event:MainEvent):void
	{
		main.activeViewComponentType = event.viewComponentType;
	}
	
	private function whenAlert(event:SystemAlertEvent):void
	{
		main.receiveSystemAlert(event.systemAlert);
	}
	
}
}