/**
 * @author Cotton Hou
 */
package org.robotlegs.demos.helloflashstrict.view
{

import flash.display.Sprite;
import flash.text.TextField;


public class Readout extends Sprite
{

    public function Readout ()
    {
        this.init();
    }

    protected var textField:TextField;

    public function setText (str:String):void
    {
        textField.text = str;
    }

    protected function init ():void
    {
        textField = new TextField();
        
        addChild(textField);
    }

}
}

