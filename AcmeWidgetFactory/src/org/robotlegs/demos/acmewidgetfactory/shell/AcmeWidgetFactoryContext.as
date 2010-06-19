/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package org.robotlegs.demos.acmewidgetfactory.shell
{
	import org.robotlegs.demos.acmewidgetfactory.common.interfaces.ILoggerModule;
	import org.robotlegs.demos.acmewidgetfactory.common.interfaces.IWidgetModule;
	import org.robotlegs.demos.acmewidgetfactory.shell.controller.CreateLoggerCommand;
	import org.robotlegs.demos.acmewidgetfactory.shell.controller.CreateWidgetCommand;
	import org.robotlegs.demos.acmewidgetfactory.shell.controller.PokeWidgetCommand;
	import org.robotlegs.demos.acmewidgetfactory.shell.controller.RemoveWidgetCommand;
	import org.robotlegs.demos.acmewidgetfactory.shell.controller.ShellLoggerEvent;
	import org.robotlegs.demos.acmewidgetfactory.shell.controller.ShellWidgetEvent;
	import org.robotlegs.demos.acmewidgetfactory.shell.controller.UnregisterWidgetCommand;
	import org.robotlegs.demos.acmewidgetfactory.shell.model.ActiveWidgetModel;
	import org.robotlegs.demos.acmewidgetfactory.shell.view.ControlPanelMediator;
	import org.robotlegs.demos.acmewidgetfactory.shell.view.ControlPanelView;
	import org.robotlegs.demos.acmewidgetfactory.shell.view.LoggerHolderMediator;
	import org.robotlegs.demos.acmewidgetfactory.shell.view.LoggerHolderView;
	import org.robotlegs.demos.acmewidgetfactory.shell.view.LoggerModuleMediator;
	import org.robotlegs.demos.acmewidgetfactory.shell.view.WidgetHolderMediator;
	import org.robotlegs.demos.acmewidgetfactory.shell.view.WidgetHolderView;
	import org.robotlegs.demos.acmewidgetfactory.shell.view.WidgetModuleMediator;
	import org.robotlegs.mvcs.Context;
	
	public class AcmeWidgetFactoryContext extends Context
	{
		
		override public function startup():void
		{
			// Controller
			commandMap.mapEvent(ShellWidgetEvent.CREATE_WIDGET, CreateWidgetCommand, ShellWidgetEvent);
			commandMap.mapEvent(ShellWidgetEvent.POKE_WIDGET, PokeWidgetCommand, ShellWidgetEvent);
			commandMap.mapEvent(ShellWidgetEvent.REMOVE_WIDGET, RemoveWidgetCommand, ShellWidgetEvent);
			commandMap.mapEvent(ShellWidgetEvent.REMOVE_WIDGET_COMPLETE, UnregisterWidgetCommand, ShellWidgetEvent);
			commandMap.mapEvent(ShellLoggerEvent.CREATE_LOGGER, CreateLoggerCommand, ShellLoggerEvent);
			
			// Model
			injector.mapSingleton(ActiveWidgetModel);
			
			// View
			injector.mapValue(AcmeWidgetFactory, contextView);
			mediatorMap.mapView(ControlPanelView, ControlPanelMediator);
			mediatorMap.mapView(LoggerHolderView, LoggerHolderMediator);
			mediatorMap.mapView(WidgetHolderView, WidgetHolderMediator);
			
			// Modules - notice FQCN::string style mapping
			mediatorMap.mapView('org.robotlegs.demos.acmewidgetfactory.modules.logger::LoggerModule', LoggerModuleMediator, ILoggerModule);
			mediatorMap.mapView('org.robotlegs.demos.acmewidgetfactory.modules.widget::WidgetModule', WidgetModuleMediator, IWidgetModule);
			
			// Ready
			super.startup();
		}
	
	}
}