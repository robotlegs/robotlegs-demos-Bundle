package org.robotlegs.demos.cafetownsend.user.model
{
	import flash.events.IEventDispatcher;

	import org.robotlegs.demos.cafetownsend.user.model.events.EmployeeLoginEvent;
	import org.robotlegs.demos.cafetownsend.user.model.vo.User;

	/** @author Jonathan Toland */
public class EmployeeLoginModel
{
	[Inject] public var eventDispatcher : IEventDispatcher;

	private var _user:User;
	
	public function get user():User
	{
		return _user;
	}
	
	public function set user(value:User):void
	{
		_user = value;
		eventDispatcher.dispatchEvent(new EmployeeLoginEvent(EmployeeLoginEvent.USER, value && value.clone()));
	}
	
	private var _hint:String;
	
	public function get hint():String
	{
		return _hint;
	}
	
	public function set hint(value:String):void
	{
		_hint = value;
		eventDispatcher.dispatchEvent(new EmployeeLoginEvent(EmployeeLoginEvent.HINT, null));
	}
	
}
}