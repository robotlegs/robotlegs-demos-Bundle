package org.robotlegs.demos.cafetownsend.detail.model
{
	import flash.events.IEventDispatcher;

	import org.robotlegs.demos.cafetownsend.detail.model.events.EmployeeDetailEvent;
	import org.robotlegs.demos.cafetownsend.detail.model.vo.Employee;

	/** @author Jonathan Toland */
public class EmployeeDetailModel
{
	[Inject] public var eventDispatcher : IEventDispatcher;

	private var _employee:Employee;
	
	public function get employee():Employee
	{
		return _employee;
	}
	
	public function set employee(value:Employee):void
	{
		_employee = value;
		eventDispatcher.dispatchEvent(new EmployeeDetailEvent(EmployeeDetailEvent.EDIT, value && value.clone()));
	}
	
}
}