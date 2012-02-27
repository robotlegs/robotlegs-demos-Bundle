package org.robotlegs.demos.cafetownsend.list.service
{
	import flash.events.IEventDispatcher;
	import flash.xml.XMLNode;

	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	import org.robotlegs.demos.cafetownsend.detail.model.vo.Employee;
	import org.robotlegs.demos.cafetownsend.list.model.EmployeeListModel;
	import org.robotlegs.demos.cafetownsend.list.service.interfaces.IEmployeeListService;
	import org.robotlegs.demos.cafetownsend.main.model.events.SystemAlertEvent;
	import org.robotlegs.demos.cafetownsend.main.model.vo.SystemAlert;
	import org.robotlegs.demos.cafetownsend.main.service.interfaces.IResourceManagerService;

	[ResourceBundle("EmployeeListService")]
/** @author Jonathan Toland */
public class EmployeeListService implements IEmployeeListService, IResponder
{
	[Inject] public var eventDispatcher : IEventDispatcher;

	[Inject]
	public var employeeListModel:EmployeeListModel;
	[Inject]
	public var resourceManagerService:IResourceManagerService;
	[Inject]
	public var httpService:HTTPService;
	
	public function loadEmployees():void
	{
		httpService.send().addResponder(this);
	}
	
	public function result(data:Object):void
	{
		for each (var employee:Employee in ResultEvent(data).result)
		{
			employeeListModel.mapEmployee(employee);
		}
	}
	
	public function fault(info:Object):void
	{
		eventDispatcher.dispatchEvent(new SystemAlertEvent(SystemAlertEvent.ALERT,
			new SystemAlert(FaultEvent(info).fault.faultString, resourceManagerService.getString(this, 'loadFailureTitle'))));
	}
	
	[PostConstruct]
	public function loadConfiguration():void
	{
		httpService.url = resourceManagerService.getString(this, 'location');
		httpService.xmlDecode = decodeXML;
	}
	
	private function decodeXML(dataNode:XMLNode):Object
	{
		const result:Array = [];
		for each (var item:XML in XML(dataNode).employee)
		{
			result.push(new Employee(item.firstname, item.lastname, item.email,
				new Date(Date.parse(item.startdate)), item.emp_id));
		}
		return result;
	}
	
}
}