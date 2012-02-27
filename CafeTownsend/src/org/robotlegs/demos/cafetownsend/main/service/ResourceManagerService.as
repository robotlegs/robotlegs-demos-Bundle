package org.robotlegs.demos.cafetownsend.main.service
{
	import flash.utils.getQualifiedClassName;

	import mx.resources.IResourceManager;

	import org.robotlegs.demos.cafetownsend.main.service.interfaces.IResourceManagerService;

	/** @author Jonathan Toland */
public class ResourceManagerService implements IResourceManagerService
{
	private const parametersPattern:RegExp = /\{(\w+)\}/g;
	
	[Inject]
	public var resourceManager:IResourceManager;
	
	public function getString(bundle:*, resourceName:String, parameters:Object = null):String
	{
		if (!(bundle is String))
		{
			bundle = getUnqualifiedClassName(bundle);
		}
		return fillString(resourceManager.getString(bundle, resourceName, parameters as Array), parameters);
	}
	
	public function fillString(resource:String, parameters:Object):String
	{
		if (!parameters)
		{
			return resource;
		}
		return resource.replace(parametersPattern, function(str:String, p1:String, offset:int, s:String):String
		{
			return parameters[p1];
		});
	}
	
	private function getUnqualifiedClassName(value:*):String
	{
		return getQualifiedClassName(value).split('::').pop();
	}
	
}
}