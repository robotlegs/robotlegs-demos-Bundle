/**
 * @author Cotton Hou
 */
package
{

import flash.display.Sprite;

import org.robotlegs.demos.helloflashstrict.HelloFlashSrictContext;


public class HelloFlashStrict extends Sprite
{

    protected var context:HelloFlashSrictContext;

    public function HelloFlashStrict ()
    {
        this.context = new HelloFlashSrictContext(this);
    }

}
}
