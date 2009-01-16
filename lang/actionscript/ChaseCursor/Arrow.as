package{
    import flash.display.*;

    // 矢印クラス
    public class Arrow extends Sprite {
        public function Arrow(){
            init();
        }

        // 矢印を描画する
        public function init():void{
            // 枠のスタイルを設定
            graphics.lineStyle(2,0,1);
            // 塗りつぶしの色を設定
            graphics.beginFill(0xff0000);

            graphics.moveTo(-50,-25);
            graphics.lineTo(0,-25);
            graphics.lineTo(0,-50);
            graphics.lineTo(50,0);
            graphics.lineTo(0,50);
            graphics.lineTo(0,25);
            graphics.lineTo(-50,25);
            graphics.lineTo(-50,-25);
            graphics.endFill();
        }
    }
}
