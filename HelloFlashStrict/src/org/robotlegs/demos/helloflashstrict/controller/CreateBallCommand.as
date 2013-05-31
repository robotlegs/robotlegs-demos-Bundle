/**
 * @author Cotton Hou
 */
package org.robotlegs.demos.helloflashstrict.controller
{

import org.robotlegs.demos.helloflashstrict.model.IItemContainer;
import org.robotlegs.demos.helloflashstrict.model.ItemVO;
import org.robotlegs.demos.helloflashstrict.view.Ball;
import org.robotlegs.mvcs.Command;


public class CreateBallCommand extends Command
{

    [Inject]
    public var container:IItemContainer;

    override public function execute ():void
    {
        var ball:Ball = new Ball();
            ball.x = Math.random() * 500;
            ball.y = Math.random() * 375;

        var itemVO:ItemVO = new ItemVO(ball);

        container.add(itemVO);
    }

}
}
