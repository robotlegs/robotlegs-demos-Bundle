package org.robotlegs.demos.cafetownsend.user.controller
{
	import flash.events.IEventDispatcher;

	import org.robotlegs.demos.cafetownsend.list.view.components.interfaces.IEmployeeList;
	import org.robotlegs.demos.cafetownsend.main.model.events.MainEvent;
	import org.robotlegs.demos.cafetownsend.user.service.interfaces.IEmployeeLoginService;
	import org.robotlegs.demos.cafetownsend.user.view.components.interfaces.IEmployeeLogin;

	/** @author Jonathan Toland */
public class UserCommand
{
	[Inject] public var eventDispatcher : IEventDispatcher;
	[Inject]
	public var employeeLoginService:IEmployeeLoginService;
	
	public function execute():void
	{
		eventDispatcher.dispatchEvent(new MainEvent(MainEvent.FOCUS, employeeLoginService.loggedIn ? IEmployeeList : IEmployeeLogin));
	}
	
}
}