/**
 * @author Cotton Hou
 */
package org.robotlegs.demos.helloflashstrict.controller
{

import flash.events.Event;

import org.robotlegs.demos.helloflashstrict.model.ItemVO;


public class HelloFlashEvent extends Event
{

    public static const BALL_CLICKED:String = "ball_clicked";
    public static const BALL_CREATED:String = "ball_created";

    public function HelloFlashEvent(type:String, itemVO:ItemVO = null)
    {
        super(type);

        _itemVO = itemVO;
    }

    private var _itemVO:ItemVO;

    public function get itemVO ():ItemVO
    {
        return _itemVO;
    }

    override public function clone():Event
    {
        return new HelloFlashEvent(type, itemVO);
    }

}
}
