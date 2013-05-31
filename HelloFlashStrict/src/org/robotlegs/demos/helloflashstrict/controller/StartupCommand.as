/**
 * @author Cotton Hou
 */
package org.robotlegs.demos.helloflashstrict.controller
{

import org.robotlegs.demos.helloflashstrict.view.Readout;
import org.robotlegs.mvcs.Command;


public class StartupCommand extends Command
{

    override public function execute ():void
    {
        contextView.addChild(new Readout());

        dispatch(new HelloFlashEvent(HelloFlashEvent.BALL_CLICKED));
    }

}
}
