/**
 * @author Cotton Hou
 */
package org.robotlegs.demos.helloflashstrict.view
{

import org.robotlegs.demos.helloflashstrict.controller.HelloFlashEvent;
import org.robotlegs.demos.helloflashstrict.model.IItemContainer;
import org.robotlegs.mvcs.Mediator;


public class ReadoutMediator extends Mediator
{
    [Inject]
    public var view:Readout;

    [Inject]
    public var container:IItemContainer;

    override public function onRegister ():void
    {
        addContextListener(HelloFlashEvent.BALL_CREATED, onBallCreated);
    }

    protected function onBallCreated (event:HelloFlashEvent):void
    {
        view.setText("Click count: " + container.length);
    }

}
}