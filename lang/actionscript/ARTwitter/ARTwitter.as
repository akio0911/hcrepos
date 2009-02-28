package
{
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.text.*;
    import flash.filters.*;
    import mx.controls.*;

    [SWF(backgroundColor="#ffffff")]

    public class ARTwitter extends Sprite
    {
	private var container:Sprite;
	private var webcam:Camera;
	private var label:TextField;
	private var video:Video = new Video();

	static public const
	    TEXTURE_W:int = 240,
	    TEXTURE_H:int = 240;

	public function ARTwitter():void
	{
	    label = new TextField();
	    label.autoSize = TextFieldAutoSize.LEFT;
	    addChild(label);
	    label.text = "CameraTexture";

	    webcam = Camera.getCamera();
	    if(webcam != null){
		webcam.addEventListener(ActivityEvent.ACTIVITY, activityHandler);
		webcam.addEventListener(StatusEvent.STATUS, statusHandler);

		video.width = 320;
		video.height = 240;
		video.attachCamera(webcam);
		addChild(video);
	    }else{
		label.text = "カメラを利用できません";
	    }

	    init3D();

	    addEventListener(Event.ENTER_FRAME, loop3D);
	}

	private function activityHandler(evt:ActivityEvent):void{
	    if(evt.activating){
		label.text = "モーションの検知を開始";
	    }else{
		label.text = "モーションの検知を停止";
	    }
	}

	private function statusHandler(evt:StatusEvent):void{
	    if(webcam.muted){
		label.text = "カメラを利用できません";
	    }
	}

	private function init3D():void
	{
	    var bmpData:BitmapData = new BitmapData(TEXTURE_W, TEXTURE_H, true, 0x000000);
	    var filter:Array = new Array;
	    filter.push(new DropShadowFilter());
	}

	private function loop3D(event:Event):void
	{
	}
    }
}
