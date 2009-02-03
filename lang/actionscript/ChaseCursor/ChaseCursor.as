package{
    import flash.events.*;
    import flash.display.*;

    public class ChaseCursor extends Sprite {
        // スピード
        private var s:Number = 10;
        // 矢印オブジェクト
        private var a:Arrow;

        public function ChaseCursor(){
            init();
        }

        private function init():void{
            // フレーム更新イベントを設定
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
            // 矢印オブジェクトを生成
            a = new Arrow();
            // 矢印オブジェクトと画面に追加
            addChild(a);
        }

        // フレームイベント
        private function onEnterFrame(e:Event):void{
            // 矢印の座標とマウスカーソルの座標との差分を算出
            var dx:Number = mouseX - a.x, dy:Number = mouseY - a.y;
            // 矢印の座標とマウスカーソルの座標との角度を算出
            var d:Number = Math.atan2(dy, dx);
            // 矢印オブジェクトの速度を算出
            var vx:Number = Math.cos(d) * s, vy:Number = Math.sin(d) * s;
            // 速度に基づいて矢印の位置を更新
            a.x += vx, a.y += vy;
            // 矢印オブジェクトの角度を設定
            a.rotation = d / Math.PI * 180.0;
        }
    }
}
