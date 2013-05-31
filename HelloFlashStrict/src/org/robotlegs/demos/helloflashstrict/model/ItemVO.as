/**
 * @author Cotton Hou
 */
package org.robotlegs.demos.helloflashstrict.model
{

import flash.display.DisplayObject;


public class ItemVO
{

    public function ItemVO (displayer:DisplayObject)
    {
        _displayer = displayer;
    }

    private var _displayer:DisplayObject;

    public function get displayer ():DisplayObject
    {
        return _displayer;
    }

}
}

