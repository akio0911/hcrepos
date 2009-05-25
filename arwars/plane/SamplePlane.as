//****************************************************************************
//SamplePlaneクラス
//@auther Masayuki Daijima
//****************************************************************************

package {
	import flash.display.*;
	import flash.events.*;
	
	//papervision3Dクラスをインポート
	import org.papervision3d.scenes.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.cameras.*;
	import org.papervision3d.materials.*;
	
	public class SamplePlane extends Sprite {
		// _______________________________________________________________________
		// メンバ定義
		private var container					: Sprite;
		private var scene 						: Scene3D;
		private var camera						: Camera3D;
		
		private var planeObj 					: DisplayObject3D;
		private var planeSize					: int = 300;//Planeオブジェクト1辺の長さ
		private var segment 					: int = 4;//面の分割数
		
		private var valX 						: Number = 0;
		private var valY						: Number = 0;
		
		
		// _______________________________________________________________________
		// コンストラクタ
		public function SamplePlane():void {
			//ステージ設定
			stage.frameRate = 60;
			stage.quality = "BEST";
			stage.scaleMode = "noScale";
			stage.align = StageAlign.TOP_LEFT;
			
			initialize3D();
		}
		
		// _______________________________________________________________________
		// 3D空間の初期設定
		private function initialize3D():void {
			//3D空間のベースとなるコンテナ生成
			container = new Sprite();
			addChild(this.container);
			container.x = this.stage.stageWidth / 2;
			container.y = this.stage.stageHeight / 2;
			
			//3Dシーン生成
			scene = new Scene3D( container );
			
			//カメラ設定
			camera = new Camera3D();
			camera.z = -planeSize;
			camera.focus = 500;
			camera.zoom = 1;
			
			//マテリアル設定
			var material = new BitmapFileMaterial( "images/sample.gif" );
			material.doubleSided = true;
			material.smooth = true;
						
			//Planeオブジェクト生成
			planeObj = new Plane( material, planeSize, planeSize, segment, segment);
			scene.addChild( planeObj );
			
			addEvents();
		}
		
		// _______________________________________________________________________
		// イベント設定
		private function addEvents():void {
			this.addEventListener(Event.ENTER_FRAME, update3D);
			this.stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		// _______________________________________________________________________
		// ENTER_FRAMEイベント処理
		private function update3D( event:Event ):void {
			//マウス座標でオブジェクトを回転
			valX += container.mouseX / 50;
			valY += container.mouseY / 50;
			planeObj.rotationY = valX;
			planeObj.rotationX = valY;
			
			//3Dシーンをレンダリング
			scene.renderCamera( camera );
		}
		
		// _______________________________________________________________________
		// ステージリサイズイベント処理
		private function onStageResize( event:Event ):void {
			container.x = this.stage.stageWidth / 2;
			container.y = this.stage.stageHeight / 2;
		}
	}
}
