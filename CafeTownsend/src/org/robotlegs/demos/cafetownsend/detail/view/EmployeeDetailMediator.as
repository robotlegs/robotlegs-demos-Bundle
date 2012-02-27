package org.robotlegs.demos.cafetownsend.detail.view
{
import mx.validators.Validator;

import org.robotlegs.demos.cafetownsend.detail.model.EmployeeDetailModel;
import org.robotlegs.demos.cafetownsend.detail.model.events.EmployeeDetailEvent;
import org.robotlegs.demos.cafetownsend.detail.model.vo.Employee;
import org.robotlegs.demos.cafetownsend.detail.view.components.interfaces.IEmployeeDetail;
import org.robotlegs.demos.cafetownsend.list.model.EmployeeListModel;
import org.robotlegs.demos.cafetownsend.list.model.events.EmployeeListEvent;
import org.robotlegs.demos.cafetownsend.list.view.components.interfaces.IEmployeeList;
import org.robotlegs.demos.cafetownsend.main.model.events.MainEvent;
import org.robotlegs.demos.cafetownsend.main.model.events.SystemAlertEvent;
import org.robotlegs.demos.cafetownsend.main.model.vo.SystemAlert;
import org.robotlegs.demos.cafetownsend.main.service.interfaces.IResourceManagerService;

import robotlegs.bender.bundles.classic.impl.Mediator;

	/** @author Jonathan Toland */
public class EmployeeDetailMediator extends Mediator
{
	[Inject]
	public var employeeDetail:IEmployeeDetail;
	[Inject]
	public var employeeDetailModel:EmployeeDetailModel;
	[Inject]
	public var employeeListModel:EmployeeListModel;
	[Inject]
	public var resourceManagerService:IResourceManagerService;
	[Inject]
	public var firstNameValidator:Validator;
	[Inject]
	public var lastNameValidator:Validator;
	[Inject(named="Email")]
	public var emailValidator:Validator;
	
	private function set employee(value:Employee):void
	{
		employeeDetail.employee = value || new Employee('', '', '', new Date());
	}

	[PostConstruct]
	public function onRegister():void
	{
		eventMap.mapListener(employeeDetail, EmployeeDetailEvent.ABORT, onAbort, EmployeeDetailEvent);
		eventMap.mapListener(employeeDetail, EmployeeDetailEvent.COMMIT, onCommit, EmployeeDetailEvent);
		eventMap.mapListener(employeeDetail, EmployeeListEvent.REMOVE, onDelete, EmployeeListEvent);
		eventMap.mapListener(eventDispatcher, EmployeeDetailEvent.EDIT, whenEdit, EmployeeDetailEvent);
		firstNameValidator.source = employeeDetail.firstNameValidatorSource;
		firstNameValidator.property = employeeDetail.firstNameValidatorProperty;
		lastNameValidator.source = employeeDetail.lastNameValidatorSource;
		lastNameValidator.property = employeeDetail.lastNameValidatorProperty;
		emailValidator.source = employeeDetail.emailValidatorSource;
		emailValidator.property = employeeDetail.emailValidatorProperty;
		toggleValidation(true);
		employee = employeeDetailModel.employee;
	}
	
	private function toggleValidation(enabled:Boolean):void
	{
		firstNameValidator.required = enabled;
		lastNameValidator.required = enabled;
		emailValidator.required = enabled;
	}
	
	private function dispatchFocus():void
	{
		employeeDetailModel.employee = null;
		toggleValidation(false);
		employeeDetail.firstNameValidatorSource.errorString = '';
		employeeDetail.lastNameValidatorSource.errorString = '';
		employeeDetail.emailValidatorSource.errorString = '';
		dispatch(new MainEvent(MainEvent.FOCUS, IEmployeeList));
	}
	
	private function getString(resourceName:String, parameters:Object = null):String
	{
		return resourceManagerService.getString(employeeDetail, resourceName, parameters);
	}
	
	private function onAbort(event:EmployeeDetailEvent):void
	{
		dispatchFocus();
	}
	
	private function onCommit(event:EmployeeDetailEvent):void
	{
		if (!Validator.validateAll([ firstNameValidator, lastNameValidator, emailValidator ]).length)
		{
			employeeListModel.mapEmployee(event.employee);
			dispatchFocus();
		}
	}
	
	private function onDelete(event:EmployeeListEvent):void
	{
		const action:Function = function(cancelled:Boolean):void
			{
				if (!(cancelled))
				{
					employeeListModel.unmapEmployee(event.employee);
					dispatchFocus();
				}
			};
		dispatch(new SystemAlertEvent(SystemAlertEvent.ALERT,
			new SystemAlert(getString('confirmRemoveText'), getString('confirmRemoveTitle', event.employee), action, true)));
	}
	
	private function whenEdit(event:EmployeeDetailEvent):void
	{
		toggleValidation(true);
		employee = event.employee;
	}
	
}
}