/**
 * @author Cotton Hou
 */
package org.robotlegs.demos.helloflashstrict.view
{

import flash.events.MouseEvent;

import org.robotlegs.demos.helloflashstrict.controller.HelloFlashEvent;
import org.robotlegs.mvcs.Mediator;


public class BallMediator extends Mediator
{

    [Inject]
    public var view:Ball;

    override public function onRegister ():void
    {
        eventMap.mapListener(view, MouseEvent.CLICK, onClick);
        eventMap.mapListener(eventDispatcher, HelloFlashEvent.BALL_CREATED, onSomeBallClicked);
    }

    protected function onClick (event:MouseEvent):void
    {
        dispatch(new HelloFlashEvent(HelloFlashEvent.BALL_CLICKED));
    }

    protected function onSomeBallClicked (event:HelloFlashEvent):void
    {
        view.poke();
    }

}
}

