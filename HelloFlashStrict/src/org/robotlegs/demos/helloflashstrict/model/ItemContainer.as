/**
 * @author Cotton Hou
 */
package org.robotlegs.demos.helloflashstrict.model
{

import org.robotlegs.demos.helloflashstrict.controller.HelloFlashEvent;
import org.robotlegs.mvcs.Actor;


public class ItemContainer extends Actor implements IItemContainer
{

    public function ItemContainer ()
    {
        init();
    }

    private var array:Array;

    public function add (itemVO:ItemVO):void
    {
        array.push(itemVO);

        dispatch(new HelloFlashEvent(HelloFlashEvent.BALL_CREATED, itemVO));
    }

    public function get length ():int
    {
        return array.length;
    }

    private function init ():void
    {
        array = [];
    }

}
}
