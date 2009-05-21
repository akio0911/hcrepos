package {
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.text.*

    //ソケットを使用する
    public class SocketEx extends Sprite {
        private var socket:Socket;   //ソケット
        private var tfView:TextField;//表示テキストフィールド
        private var tfSend:TextField;//送信テキストフィールド
        
        //コンストラクタ
        public function SocketEx() {
            //テキストフィールドの生成
            tfView=addTextField(10,10,220,160);
            tfSend=addTextField(10,180,220,20);
            
            //ソケットの生成
            socket=new Socket("localhost",16000);

            //???X?iリスナーの追加
            socket.addEventListener(Event.CONNECT,connectHandler);
            socket.addEventListener(Event.CLOSE, closeHandler);
            socket.addEventListener(ProgressEvent.SOCKET_DATA,socketDataHandler);
            socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
            socket.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
            tfSend.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
        }

        //キーダウンイベントの処理
        private function keyDownHandler(evt:KeyboardEvent):void {
            if (!socket.connected) return;
            if (evt.keyCode==Keyboard.ENTER) {
                socket.writeUTFBytes(tfSend.text);
                socket.flush();
                tfSend.text="";
            }
        }

        //接続イベントの処理
        private function connectHandler(evt:Event):void {
            trace("接続");
        }
    
        //??切断イベントの処理
        private function closeHandler(evt:Event):void {
            trace("切断");
        }
    
        //読み込み中イベントの処理?f?
        private function socketDataHandler(evt:ProgressEvent):void {
            var text:String=socket.readUTFBytes(socket.bytesAvailable);
            tfView.text=text+"\n"+tfView.text;
        }
    
        //セキュリティエラーイベントの処理?Z?L?????e?B?G???
        private function securityErrorHandler(evt:SecurityErrorEvent):void {
            trace("セキュリティエラー");
        }
    
        //IOエラーイベントの処理
        private function ioErrorHandler(evt:IOErrorEvent):void {
            trace("IOエラー");
        }

        //テキストフィールドの追加
        private function addTextField(x:int,y:int,w:uint,h:uint):TextField {
            var textField:TextField=new TextField();
            addChild(textField);
            textField.x=x;
            textField.y=y;
            textField.width=w;
            textField.height=h;
            textField.text="";
            textField.selectable=true;
            textField.border=true;
            textField.type=TextFieldType.INPUT;
            return textField;
        }
    }
}
