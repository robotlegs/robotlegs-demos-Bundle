/**
 * @author Cotton Hou
 */
package org.robotlegs.demos.helloflashstrict.controller
{

import org.robotlegs.mvcs.Command;


public class DisplayBallCommand extends Command
{

    [Inject]
    public var event:HelloFlashEvent;

    override public function execute ():void
    {
        contextView.addChildAt(event.itemVO.displayer, 0);
    }

}
}
