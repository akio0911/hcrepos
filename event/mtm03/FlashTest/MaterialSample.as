package {

  import flash.display.*;
  import flash.events.*;
  import flash.geom.*;
  import flash.text.*;

  import org.papervision3d.scenes.*;
  import org.papervision3d.objects.*;
  import org.papervision3d.cameras.*;
  import org.papervision3d.materials.*;

  [SWF(width="400", height="400", backgroundColor="#000000", frameRate="30")]

  // BitmapMaterial と MovieMaterial (テキスト表示) のサンプル
  public class MaterialSample extends Sprite {

    private var container : Sprite;
    private var scene     : Scene3D;
    private var camera    : Camera3D;
    private var rootNode  : DisplayObject3D;

    private var obj:Array = new Array();

    // 3Dオブジェクト踊らせ用パラメータ
    private var valx    : Number = 0;
    private var valy    : Number = 0;

    // Bitmap
    private var bitmapdata:BitmapData;

    // Text
    private var text:TextField;
    private var material:MovieMaterial

    public function MaterialSample():void {

      // 画面いっぱいに表示(縦横比無視)したいときはコレを使う
      // stage.scaleMode = StageScaleMode.EXACT_FIT;

      // リサイズに対応(swfをブラウザで直接ひらいているときとか)
      stage.addEventListener(Event.RESIZE, onStageResize);

      // 定期的にイベント発生
      addEventListener(Event.ENTER_FRAME, myLoopEvent);

      // マウスクリックでイベント発生
      stage.addEventListener(MouseEvent.CLICK, myClick);

      // 表示用の Sprite オブジェクトを生成
      container = new Sprite();
      container.x = 400 / 2; // at center : swf width  = 400
      container.y = 400 / 2; // at center : swf height = 400
      addChild(container);

      // シーンオブジェクトを作る
      scene = new Scene3D(container);

      // カメラオブジェクトを作る
      camera = new Camera3D();
      camera.z = -200;
      camera.focus = 500;
      camera.zoom = 1;

      // ルートノードを作る
      rootNode = new DisplayObject3D();
      scene.addChild(rootNode);

      // いろんな3Dオブジェクトを作ってみて、配列に入れておく
      obj.push(createWireframePlane());
      obj.push(createBitmapPlane());
      obj.push(createTextPlane());
      obj.push(createTextCube());

      // 3Dオブジェクトをルートノードに追加
      for(var i:int; i<obj.length; i++){
        rootNode.addChild(obj[i]);
      }
    }

    private function createWireframePlane():DisplayObject3D {

      var material:WireframeMaterial = new WireframeMaterial();
      material.oneSide = false;
      material.lineColor = 0x00FF00;
      material.lineAlpha = 1;

      var planeSize:int = 200;
      var segment:int = 2;

      var plane:Plane = new Plane(
        material, planeSize, planeSize, segment, segment);
      plane.x =   0;
      plane.y =  180;
      plane.z =   0;
      return plane;
    }

    private function createBitmapPlane():DisplayObject3D {

      var bd:BitmapData = new BitmapData(100, 100, false);
      this.bitmapdata = bd; // using this
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
      this.material = material; // using this

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

      // using this
      var cube:Cube = new Cube(
        this.material, planeSize, planeSize, planeSize, segment, segment, segment);
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
      this.text = text; // using this
      return mc;
    }

    private static function createTextField():TextField{

      // 表示メッセージのスタイル
      var format:TextFormat = new TextFormat();
      format.bold = false;
      format.italic = false;
      format.size = 10;
      format.underline = false;
      format.font = "_等幅";

      // 表示メッセージ
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

    // 最初だけこんなの表示してみる
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

      // update Bitmap
      // Math.random: (0 <= n < 1)
      var x:int = (int)(Math.random() * 100);
      var y:int = (int)(Math.random() * 100);
      // bitmapdata.setPixel(x, y, 0xFF0000);
      var rect:Rectangle = new Rectangle(x, y, 20, 20);
      bitmapdata.fillRect(rect, 0xFF0000);

      // update Text
      text.border = !text.border; // ワクを付けたり消したり
      text.background = !text.background; // 背景を付けたり消したり

      text.text = "マウスを\nクリックした位置:\nLocation(" + container.mouseX + "," + container.mouseY + ")";
      material.updateBitmap(); // 更新を通知
      //scene.renderCamera(camera);
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
