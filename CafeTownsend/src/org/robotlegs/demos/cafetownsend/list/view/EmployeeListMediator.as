package org.robotlegs.demos.cafetownsend.list.view
{
import org.robotlegs.demos.cafetownsend.detail.model.EmployeeDetailModel;
import org.robotlegs.demos.cafetownsend.detail.model.events.EmployeeDetailEvent;
import org.robotlegs.demos.cafetownsend.detail.model.vo.Employee;
import org.robotlegs.demos.cafetownsend.detail.view.components.interfaces.IEmployeeDetail;
import org.robotlegs.demos.cafetownsend.list.model.events.EmployeeListEvent;
import org.robotlegs.demos.cafetownsend.list.service.interfaces.IEmployeeListService;
import org.robotlegs.demos.cafetownsend.list.view.components.interfaces.IEmployeeList;
import org.robotlegs.demos.cafetownsend.main.model.events.MainEvent;
import org.robotlegs.demos.cafetownsend.main.service.interfaces.IResourceManagerService;
import org.robotlegs.demos.cafetownsend.user.model.events.EmployeeLoginEvent;
import org.robotlegs.demos.cafetownsend.user.service.interfaces.IEmployeeLoginService;

import robotlegs.bender.bundles.classic.impl.Mediator;

	[ResourceBundle("EmployeeList")]
/** @author Jonathan Toland */
public class EmployeeListMediator extends Mediator
{
	[Inject]
	public var employeeList:IEmployeeList;
	[Inject]
	public var employeeDetailModel:EmployeeDetailModel;
	[Inject]
	public var employeeListService:IEmployeeListService;
	[Inject]
	public var employeeLoginService:IEmployeeLoginService;
	[Inject]
	public var resourceManagerService:IResourceManagerService;
	
	private var itemLabelFormat:String;

	[PostConstruct]
	public function onRegister():void
	{
		eventMap.mapListener(employeeList, EmployeeLoginEvent.LOGOUT, onLogout, EmployeeLoginEvent);
		eventMap.mapListener(employeeList, EmployeeDetailEvent.EDIT, onEdit, EmployeeDetailEvent);
		eventMap.mapListener(eventDispatcher, EmployeeListEvent.ADD, whenAdd, EmployeeListEvent);
		eventMap.mapListener(eventDispatcher, EmployeeListEvent.UPDATE, whenUpdate, EmployeeListEvent);
		eventMap.mapListener(eventDispatcher, EmployeeListEvent.REMOVE, whenRemove, EmployeeListEvent);
		itemLabelFormat = resourceManagerService.getString(employeeList, 'itemLabelFormat');
		employeeList.itemLabelFunction = itemLabelFunction;
		employeeListService.loadEmployees();
	}
		
	private function itemLabelFunction(item:Employee):String
	{
		return resourceManagerService.fillString(itemLabelFormat, item);
	}
	
	private function forEmployee(employee:Employee, action:Function):void
	{
		for (var i:int = 0; i < employeeList.collection.length; i++)
		{
			if (Employee(employeeList.collection.getItemAt(i)).id === employee.id)
			{
				action(i);
				return;
			}
		}
	}
	
	private function onLogout(event:EmployeeLoginEvent):void
	{
		employeeLoginService.logOut();
	}
	
	private function onEdit(event:EmployeeDetailEvent):void
	{
		employeeList.clearSelectedEmployee();
		employeeDetailModel.employee = event.employee;
		dispatch(new MainEvent(MainEvent.FOCUS, IEmployeeDetail));
	}
	
	private function whenAdd(event:EmployeeListEvent):void
	{
		employeeList.collection.addItem(event.employee);
	}
	
	private function whenUpdate(event:EmployeeListEvent):void
	{
		forEmployee(event.employee, function(index:int):void
			{
				employeeList.collection.setItemAt(event.employee, index);
			});
	}
	
	private function whenRemove(event:EmployeeListEvent):void
	{
		forEmployee(event.employee, function(index:int):void
			{
				employeeList.collection.removeItemAt(index);
			});
	}
	
}
}