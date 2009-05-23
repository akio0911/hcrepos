package {
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
 
    import org.papervision3d.scenes.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.objects.primitives.*;
    import org.papervision3d.cameras.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.materials.utils.*;
    import org.papervision3d.view.*;
    import org.papervision3d.render.*;
    import org.papervision3d.lights.*;
	
    public class SimpleCube extends PV3DARApp {
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
	    private var viewport  :Viewport3D;
	private var renderer  :BasicRenderEngine;

	public function SimpleCube() {
	    this.init('Data/camera_para.dat', 'Data/flarlogo.pat');
	    stage.addEventListener(Event.RESIZE, onStageResize);
	    addEventListener(Event.ENTER_FRAME, myLoopEvent);
	    stage.addEventListener(MouseEvent.CLICK, myClick);
	    container = new Sprite();
	    container.x = 400 / 2;
	    container.y = 400 / 2;
	    addChild(container);
	    scene = new Scene3D();
	    camera = new Camera3D();
	    camera.z = -200;
	    camera.focus = 500;
	    camera.zoom = 1;
	    rootNode = new DisplayObject3D();
	    scene.addChild(rootNode);
	    obj.push(createBitmapPlane());
	    obj.push(createTextPlane());
	    obj.push(createTextCube());
	    for(var i:int; i<obj.length; i++){
		rootNode.addChild(obj[i]);
	    }
	    viewport = new Viewport3D( stage.stageWidth, stage.stageHeight );
	    renderer = new BasicRenderEngine();
	}
	private function createBitmapPlane():DisplayObject3D {
 
	    var bd:BitmapData = new BitmapData(100, 100, false);
	    this.bitmapdata = bd;
	    var material:BitmapMaterial = new BitmapMaterial(bd);
 
	    material.oneSide = false;
	    material.lineColor = 0x00FF00;
	    material.lineAlpha = 1;
 
	    var planeSize:int = 200;
	    var segment:int = 2;
 
	    var plane:Plane = new Plane(
					material, planeSize, planeSize, segment, segment);
	    plane.x =  -180;
	    plane.y =  0;
	    plane.z =  0;
	    return plane;
	}

	private function createTextPlane():DisplayObject3D {
 
	    var asset:MovieClip = createMovieClip();
	    var transparent:Boolean = true;
	    var initObject:Object = {animated:true, doubleSided:true};
 
	    var material:MovieMaterial = new MovieMaterial(asset, transparent, initObject);
	    this.material = material;
 
	    var planeSize:int = 200;
	    var segment:int = 2;
 
	    var plane:Plane = new Plane(
					material, planeSize, planeSize, segment, segment);
	    plane.x =  180;
	    plane.y =  0;
	    plane.z =  0;
	    return plane;
	}

	private function createTextCube():DisplayObject3D {
 
	    var planeSize:int = 200;
	    var segment:int = 2;
 
	    var bam1:ColorMaterial = new ColorMaterial(0xF00000);
	    var bam2:ColorMaterial = new ColorMaterial(0x0F0000);
	    var bam3:ColorMaterial = new ColorMaterial(0x00F000);
	    var bam4:ColorMaterial = new ColorMaterial(0x000F00);
	    var bam5:ColorMaterial = new ColorMaterial(0x0000F0);
	    var bam6:ColorMaterial = new ColorMaterial(0x00000F);
	    var materialsList:MaterialsList = new MaterialsList();
	    bam1.smooth = bam2.smooth = bam3.smooth =bam4.smooth =bam5.smooth =bam6.smooth = true;
	    materialsList.addMaterial(bam1 ,"front");
	    materialsList.addMaterial(bam2 ,"back");
	    materialsList.addMaterial(bam3 ,"left");
	    materialsList.addMaterial(bam4 ,"right");
	    materialsList.addMaterial(bam5 ,"top");
	    materialsList.addMaterial(bam6 ,"bottom");

	    var cube:Cube = new Cube(
				     materialsList, planeSize, planeSize, planeSize, segment, segment, segment);
	    cube.x =  0;
	    cube.y =  0;
	    cube.z =  0;
	    return cube;
	}


	private function createMovieClip():MovieClip {
	    var mc:MovieClip = new MovieClip();
	    var text:TextField = createTextField();
	    text.text = getPropertiesString(mc);
	    mc.addChild(text);
	    this.text = text;
	    return mc;
	}

	private static function createTextField():TextField{
	    var format:TextFormat = new TextFormat();
	    format.bold = false;
	    format.italic = false;
	    format.size = 10;
	    format.underline = false;
	    format.font = "_等幅";
 
	    var text:TextField = new TextField();
	    text.autoSize = TextFieldAutoSize.LEFT;
	    text.selectable = false;
	    text.setTextFormat(format);
	    text.background = true;
	    text.backgroundColor = 0x000000;
	    text.border = false;
	    text.borderColor = 0xFFFFFF;
	    text.textColor = 0xFFFFFF;
 
	    return text;
	}
 
	private static function getPropertiesString(mc:MovieClip):String {
	    var str:String = ""
		+ "currentFrame: " + mc.currentFrame + "\n"
		+ "currentLabel: " + mc.currentLabel + "\n"
		+ "currentScene: " + mc.currentScene + "\n"
		+ "framesLoaded: " + mc.framesLoaded + "\n"
		+ "totalFrames: " + mc.totalFrames + "\n"
		+ "trackAsMenu: " + mc.trackAsMenu + "\n";
	    return str;
	}

	private function myClick(event:MouseEvent):void {
	    var x:int = (int)(Math.random() * 100);
	    var y:int = (int)(Math.random() * 100);
	    var rect:Rectangle = new Rectangle(x, y, 20, 20);
	    bitmapdata.fillRect(rect, 0xFF0000);
 
	    text.border = !text.border;
	    text.background = !text.background;
 
	    text.text = "マウスを\nクリックした位置:\nLocation(" + container.mouseX + "," + container.mouseY + ")";
	    material.updateBitmap();
	}

	private function myLoopEvent(event:Event):void {
 
	    valx += container.mouseX / 50;
	    valy += container.mouseY / 50;
 
	    for(var i:int; i<obj.length; i++){
		obj[i].rotationY = valx;
		obj[i].rotationX = valy;
	    }
	    renderer.renderScene( scene, camera, viewport );
	}


	private function onStageResize(event:Event):void {
	    container.x = stage.stageWidth  / 2;
	    container.y = stage.stageHeight / 2;
	}

	protected override function onInit():void {
	    super.onInit();
			
	    var light:PointLight3D = new PointLight3D();
	    light.x = 0;
	    light.y = 1000;
	    light.z = -1000;
			
	    this._baseNode.addChild(this.rootNode);
	}
    }
}