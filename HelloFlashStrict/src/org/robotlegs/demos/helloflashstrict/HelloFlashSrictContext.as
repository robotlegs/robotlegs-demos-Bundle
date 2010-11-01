/**
 * @author Cotton Hou
 */
package org.robotlegs.demos.helloflashstrict
{

import flash.display.DisplayObjectContainer;

import org.robotlegs.base.ContextEvent;
import org.robotlegs.demos.helloflashstrict.controller.CreateBallCommand;
import org.robotlegs.demos.helloflashstrict.controller.DisplayBallCommand;
import org.robotlegs.demos.helloflashstrict.controller.HelloFlashEvent;
import org.robotlegs.demos.helloflashstrict.controller.StartupCommand;
import org.robotlegs.demos.helloflashstrict.model.IItemContainer;
import org.robotlegs.demos.helloflashstrict.model.ItemContainer;
import org.robotlegs.demos.helloflashstrict.view.Ball;
import org.robotlegs.demos.helloflashstrict.view.BallMediator;
import org.robotlegs.demos.helloflashstrict.view.Readout;
import org.robotlegs.demos.helloflashstrict.view.ReadoutMediator;
import org.robotlegs.mvcs.Context;


public class HelloFlashSrictContext extends Context
{

    public function HelloFlashSrictContext (contextView:DisplayObjectContainer)
    {
        super(contextView);
    }

    override public function startup ():void
    {
        commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartupCommand, ContextEvent);
        commandMap.mapEvent(HelloFlashEvent.BALL_CLICKED, CreateBallCommand, HelloFlashEvent);
        commandMap.mapEvent(HelloFlashEvent.BALL_CREATED, DisplayBallCommand, HelloFlashEvent);

        injector.mapSingletonOf(IItemContainer, ItemContainer);

        mediatorMap.mapView(Ball, BallMediator);
        mediatorMap.mapView(Readout, ReadoutMediator);

        super.startup();
    }

}
}
