package org.robotlegs.demos.cafetownsend.user.service
{
	import flash.events.IEventDispatcher;

	import org.robotlegs.demos.cafetownsend.main.model.events.SystemAlertEvent;
	import org.robotlegs.demos.cafetownsend.main.model.vo.SystemAlert;
	import org.robotlegs.demos.cafetownsend.main.service.interfaces.IResourceManagerService;
	import org.robotlegs.demos.cafetownsend.user.model.EmployeeLoginModel;
	import org.robotlegs.demos.cafetownsend.user.model.vo.User;
	import org.robotlegs.demos.cafetownsend.user.service.interfaces.IEmployeeLoginService;

	[ResourceBundle("MockEmployeeLoginService")]
/** @author Jonathan Toland */
public class MockEmployeeLoginService implements IEmployeeLoginService
{
	[Inject] public var eventDispatcher : IEventDispatcher;

	[Inject]
	public var employeeLoginModel:EmployeeLoginModel;
	[Inject]
	public var resourceManagerService:IResourceManagerService;
	
	private var mockUser:User;
	
	public function get loggedIn():Boolean
	{
		return Boolean(employeeLoginModel.user);
	}
	
	public function logIn(user:User):void
	{
		if (user.username === mockUser.username && user.password === mockUser.password)
		{
			employeeLoginModel.user = user;
		}
		else
		{
			eventDispatcher.dispatchEvent(new SystemAlertEvent(SystemAlertEvent.ALERT,
				new SystemAlert(getString('userFailureText'), getString('userFailureTitle'))));
		}
	}
	
	public function logOut():void
	{
		employeeLoginModel.user = null;
	}
	
	public function loadHint():void
	{
		employeeLoginModel.hint = getString('hint', mockUser);
	}
	
	[PostConstruct]
	public function loadMockUser():void
	{
		mockUser = new User(getString('username'), getString('password'));
	}
	
	private function getString(resourceName:String, parameters:Object = null):String
	{
		return resourceManagerService.getString(this, resourceName, parameters);
	}
	
}
}