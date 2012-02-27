package org.robotlegs.demos.cafetownsend.user.view
{
import mx.validators.Validator;

import org.robotlegs.demos.cafetownsend.user.model.EmployeeLoginModel;
import org.robotlegs.demos.cafetownsend.user.model.events.EmployeeLoginEvent;
import org.robotlegs.demos.cafetownsend.user.service.interfaces.IEmployeeLoginService;
import org.robotlegs.demos.cafetownsend.user.view.components.interfaces.IEmployeeLogin;

import robotlegs.bender.bundles.classic.impl.Mediator;

	/** @author Jonathan Toland */
public class EmployeeLoginMediator extends Mediator
{
	[Inject]
	public var employeeLogin:IEmployeeLogin;
	[Inject]
	public var employeeLoginModel:EmployeeLoginModel;
	[Inject]
	public var employeeLoginService:IEmployeeLoginService;
	[Inject]
	public var usernameValidator:Validator;
	[Inject]
	public var passwordValidator:Validator;

	[PostConstruct]
	public function onRegister():void
	{
		eventMap.mapListener(employeeLogin, EmployeeLoginEvent.LOGIN, onLogin, EmployeeLoginEvent);
		eventMap.mapListener(eventDispatcher, EmployeeLoginEvent.USER, whenUser, EmployeeLoginEvent);
		eventMap.mapListener(eventDispatcher, EmployeeLoginEvent.HINT, whenHint, EmployeeLoginEvent);
		usernameValidator.source = employeeLogin.usernameValidatorSource;
		usernameValidator.property = employeeLogin.usernameValidatorProperty;
		passwordValidator.source = employeeLogin.passwordValidatorSource;
		passwordValidator.property = employeeLogin.passwordValidatorProperty;
		toggleValidation();
		employeeLoginService.loadHint();
	}
	
	private function toggleValidation():void
	{
		usernameValidator.required = !employeeLoginService.loggedIn;
		passwordValidator.required = !employeeLoginService.loggedIn;
	}
	
	private function onLogin(event:EmployeeLoginEvent):void
	{
		if (!Validator.validateAll([ usernameValidator, passwordValidator ]).length)
		{
			employeeLogin.resetFocus();
			employeeLogin.usernameValidatorSource[employeeLogin.usernameValidatorProperty] = '';
			employeeLogin.usernameValidatorSource.errorString = '';
			employeeLogin.passwordValidatorSource[employeeLogin.passwordValidatorProperty] = '';
			employeeLogin.passwordValidatorSource.errorString = '';
			employeeLoginService.logIn(event.user);
		}
	}
	
	private function whenUser(event:EmployeeLoginEvent):void
	{
		toggleValidation();
	}
	
	private function whenHint(event:EmployeeLoginEvent):void
	{
		employeeLogin.hint = employeeLoginModel.hint;
	}
	
}
}