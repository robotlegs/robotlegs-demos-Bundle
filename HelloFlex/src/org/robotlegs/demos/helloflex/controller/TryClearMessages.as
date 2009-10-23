package org.robotlegs.demos.helloflex.controller
{
	import org.robotlegs.demos.helloflex.model.MessageModel;
	import org.robotlegs.demos.helloflex.model.UserProxy;
	import org.robotlegs.demos.helloflex.view.LoginPage;
	import org.robotlegs.mvcs.Command;
	
	public class TryClearMessages extends Command
	{
		[Inject]
		public var event:SystemEvent;
		
		[Inject]
		public var userProxy:UserProxy;
		
		[Inject]
		public var messageModel:MessageModel;
		
		override public function execute():void
		{
			if (userProxy.userLoggedIn)
			{
				messageModel.clearMessages();
			}
			else
			{
				injector.mapValue(SystemEvent, event, 'LoginTrigger');
				contextView.addChild(new LoginPage());
			}
		}
	}
}