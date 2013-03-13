package {
    import flash.display.Sprite;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import org.papervision3d.scenes.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.cameras.*;
    import org.papervision3d.materials.*;
    [SWF(width="400", height="400", backgroundColor="#000000", frameRate="30")]
    public class FlashTest extends Sprite {
	private var container : Sprite;
	private var scene     : Scene3D;
	private var camera    : Camera3D;
	private var rootNode  : DisplayObject3D;
	private var obj:Array = new Array();
	private var valx    : Number = 0;
	private var valy    : Number = 0;
	private var bitmapdata:BitmapData;
	private var text:TextField;
	private var material:MovieMaterial
        public function FlashTest() {
	    stage.addEventListener(Event.RESIZE, onStageResize);
	    addEventListener(Event.ENTER_FRAME, myLoopEvent);
        }
	private function myLoopEvent(event:Event):void {
	    valx += container.mouseX / 50;
	    valy += container.mouseY / 50;

	    for(var i:int; i<obj.length; i++){
		obj[i].rotationY = valx;
		obj[i].rotationX = valy;
	    }

	    scene.renderCamera(camera);
	}
	private function onStageResize(event:Event):void {
	    container.x = stage.stageWidth  / 2;
	    container.y = stage.stageHeight / 2;
	}
    }
}
