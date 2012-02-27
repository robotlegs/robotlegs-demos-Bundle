//------------------------------------------------------------------------------
// Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package org.robotlegs.demos.cafetownsend
{
	import flash.display.DisplayObjectContainer;

	import mx.core.Application;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.http.HTTPService;
	import mx.validators.EmailValidator;
	import mx.validators.StringValidator;
	import mx.validators.Validator;

	import org.hamcrest.object.instanceOf;
	import org.robotlegs.demos.cafetownsend.detail.model.EmployeeDetailModel;
	import org.robotlegs.demos.cafetownsend.detail.view.EmployeeDetailMediator;
	import org.robotlegs.demos.cafetownsend.detail.view.components.interfaces.IEmployeeDetail;
	import org.robotlegs.demos.cafetownsend.list.model.EmployeeListModel;
	import org.robotlegs.demos.cafetownsend.list.service.EmployeeListService;
	import org.robotlegs.demos.cafetownsend.list.service.interfaces.IEmployeeListService;
	import org.robotlegs.demos.cafetownsend.list.view.EmployeeListMediator;
	import org.robotlegs.demos.cafetownsend.list.view.components.interfaces.IEmployeeList;
	import org.robotlegs.demos.cafetownsend.main.service.ResourceManagerService;
	import org.robotlegs.demos.cafetownsend.main.service.interfaces.IResourceManagerService;
	import org.robotlegs.demos.cafetownsend.main.view.MainMediator;
	import org.robotlegs.demos.cafetownsend.main.view.components.Main;
	import org.robotlegs.demos.cafetownsend.main.view.components.interfaces.IMain;
	import org.robotlegs.demos.cafetownsend.user.controller.UserCommand;
	import org.robotlegs.demos.cafetownsend.user.model.EmployeeLoginModel;
	import org.robotlegs.demos.cafetownsend.user.model.events.EmployeeLoginEvent;
	import org.robotlegs.demos.cafetownsend.user.service.MockEmployeeLoginService;
	import org.robotlegs.demos.cafetownsend.user.service.interfaces.IEmployeeLoginService;
	import org.robotlegs.demos.cafetownsend.user.view.EmployeeLoginMediator;
	import org.robotlegs.demos.cafetownsend.user.view.components.interfaces.IEmployeeLogin;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.context.api.IContext;
	import robotlegs.bender.framework.context.api.IContextConfig;

	public class ApplicationConfig implements IContextConfig
	{
		private var injector : Injector;
		private var mediatorMap:IMediatorMap;
		private var commandMap:IEventCommandMap;

		private var _context:IContext;

		public function configureContext(context:IContext):void
		{
			_context = context;
			context.addConfigHandler(instanceOf(DisplayObjectContainer), handleContextView);
		}

		private function handleContextView(contextView:DisplayObjectContainer):void
		{
			injector = _context.injector;
			mediatorMap = injector.getInstance(IMediatorMap);
			commandMap = injector.getInstance(IEventCommandMap);
			mapMembership();
			mapModel();
			mapService();
			mapView();
			mapController();

			//cheat, because I don't know the first thing about Flex:
			const main:Main = new Main();
			main.width = 700;
			Application(contextView).addElement(main);
		}

		private function mapMembership():void
		{
			injector.map(IResourceManager).toValue(ResourceManager.getInstance());
			injector.map(HTTPService).toType(HTTPService);
			injector.map(Validator).toType(StringValidator);
			injector.map(Validator, 'Email').toType(EmailValidator);
		}

		private function mapModel():void
		{
			injector.map(EmployeeLoginModel).asSingleton();
			injector.map(EmployeeListModel).asSingleton();
			injector.map(EmployeeDetailModel).asSingleton();
		}

		private function mapService():void
		{
			injector.map(IResourceManagerService).toSingleton(ResourceManagerService);
			injector.map(IEmployeeLoginService).toSingleton(MockEmployeeLoginService);
			injector.map(IEmployeeListService).toSingleton(EmployeeListService);
		}

		private function mapView():void
		{
			mediatorMap.mapView(IMain).toMediator(MainMediator);
			mediatorMap.mapView(IEmployeeLogin).toMediator(EmployeeLoginMediator);
			mediatorMap.mapView(IEmployeeList).toMediator(EmployeeListMediator);
			mediatorMap.mapView(IEmployeeDetail).toMediator(EmployeeDetailMediator);
		}

		private function mapController():void
		{
			commandMap.map(EmployeeLoginEvent.USER, EmployeeLoginEvent).toCommand(UserCommand);
		}
	}
}