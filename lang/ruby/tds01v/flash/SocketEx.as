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
	private var myTimer:Timer;
        
        //コンストラクタ
        public function SocketEx() {
            //テキストフィールドの生成
            tfView=addTextField(10,10,220,160);
            tfSend=addTextField(10,180,220,20);
            
            //ソケットの生成
            socket=new Socket("localhost",12345);

            //???X?iリスナーの追加
            socket.addEventListener(Event.CONNECT,connectHandler);
            socket.addEventListener(Event.CLOSE, closeHandler);
            socket.addEventListener(ProgressEvent.SOCKET_DATA,socketDataHandler);
            socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
            socket.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
            tfSend.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);

	    myTimer = new Timer(100);
	    myTimer.addEventListener("timer", timerHandler);
	    myTimer.start();
        }

	private function timerHandler(evenr:TimerEvent):void{
	    updateDirection();
	}

        //キーダウンイベントの処理
        private function keyDownHandler(evt:KeyboardEvent):void {
            if (!socket.connected) return;
            if (evt.keyCode==Keyboard.ENTER) {
		//                socket.writeUTFBytes(tfSend.text);
                socket.writeByte(1);
                socket.writeByte(2);
                socket.writeByte(3);
                socket.writeByte(4);
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

	private function updateDirection():void{
	    socket.writeByte(1);
	    socket.writeByte(2);
	    socket.writeByte(3);
	    socket.writeByte(4);
	    socket.flush();

	    //            var text:String=socket.readUTFBytes(socket.bytesAvailable);
	    var d1:int = socket.readByte();
	    var d2:int = socket.readByte();
	    var d3:int = socket.readByte();
	    var d4:int = socket.readByte();
	    d1 -= 48;
	    d2 -= 48;
	    d3 -= 48;
	    d4 -= 48;
	    var d:int = d1 * 1000 + d2 * 100 + d3 * 10 + d4;
	    var s:String  = "";
	    if(d < 45*10){
		s += "北";
	    }else if(d < (90+45)*10){
		s += "東";
	    }else if(d < (90*2+45)*10){
		s += "南";
	    }else if(d < (90*3+45)*10){
		s += "西";
	    }else{
		s += "北";
	    }
	    //            tfView.text=d1.toString()+"\n"+tfView.text;
	    //            tfView.text=d2.toString()+"\n"+tfView.text;
	    //            tfView.text=d3.toString()+"\n"+tfView.text;
	    //            tfView.text=d4.toString()+"\n"+tfView.text;
            tfView.text=s + " : " + d.toString()+"\n"+tfView.text;
	}
    
        //読み込み中イベントの処理?f?
        private function socketDataHandler(evt:ProgressEvent):void {
	    //	    updateDirection();
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
