package{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;

    public class ActionScriptTest extends Sprite{
        private var bd:BitmapData;
        public function ActionScriptTest():void{
        	const SIZE:int = 10;
        	for(var y:int = 0; y < 16; y ++){
	        	for(var x:int = 0; x < 16; x ++){
	        		var color:uint = (y*16)<<8 | (x*16);
        			graphics.beginFill(color);
        			graphics.drawCircle(SIZE*(x+0.5), SIZE*(y+0.5), SIZE/2.0);
        			graphics.endFill();
    	    	}
        	}
        }
    }
}
