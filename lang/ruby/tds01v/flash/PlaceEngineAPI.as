package PlaceEngineAPI
{
	import com.google.maps.LatLng;
	import com.google.maps.Map;
	
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Security;
	
	import mx.controls.Label;

	public class PlaceEngineAPI
	{
		//ラベルオブジェクト(ステータス表示用)
		private var labelObject:Label;

		//アプリケーションキー
		private var appk:String;

		private var findClientFunc:Function;
		private var getLocationFunc:Function;
		private var messageFunc:Function;
		
		private var debugMode:Boolean;
		
		//タイムスタンプ
		private var timeStamp:Date;

		//このライブラリのバージョン
		private const VERSION:String = "20080726";
		
		//コンストラクタ
		public function PlaceEngineAPI(label:Label, key:String, 
			findCliFunc:Function=null, getLocFunc:Function=null, mesFunc:Function=null,
			debug:Boolean=false)
		{
			//引数内容をローカル変数にコピー
			labelObject = label;
			appk = key;
			findClientFunc = findCliFunc;
			getLocationFunc = getLocFunc;
			messageFunc = mesFunc;
			debugMode = debug;
		}
		
		//PEクライアントの有無を確認する
		public function pingClient(str:String=null):void{

			//引数に文字列が指定されていたら
			if(str != null){
				//文字列を出力
				printMsg(str);
			}
			
			//クライアントが存在しているかを確認
			
			timeStamp = new Date();

			var URL:String = "http://localhost:5448/ackjs?t=";
				URL += timeStamp.milliseconds;
			var request:URLRequest = new URLRequest(URL);
			var loader:URLLoader = new URLLoader();

			setListeners(loader, "Ack");
			
			sendRequest(loader, request);
		}

		//PEクライアントに対するAckを投げて応答があったら呼ばれるイベントハンドラ
		private function completeHanderAck(event:Event):void{

			printMsg("PlaceEngineクライアントが見つかりました");
			
			var response:URLLoader = URLLoader(event.target);

			//冒頭の"ackRTAG(""と"");"を外す
			var tmpString:String = String(response.data);
			var ackRTAG:String = tmpString.substr(9, tmpString.length-13);
	
			//コールバック関数を呼ぶ
			if(findClientFunc != null){
				findClientFunc.call(findClientFunc, ackRTAG);
			}
		}

		//位置登録ページを開く
		//public fnction registerLocation():void{
		public function registerLocation(map:Map=null):void{

			var optionStr:String = "";

			//引数にGoogle MapのMapが指定されていたら
			if(map != null){
				var latlng:LatLng = map.getCenter();
				optionStr = "&x=" + latlng.lng().toString();
				optionStr += "&y=" + latlng.lat().toString();
				optionStr += "&z=" + map.getZoom().toString();
			}

			//PlaceEngineの位置登録ページを開く
			var url:URLRequest = new URLRequest("http://www.placeengine.com/map?regiloc=1" + optionStr);
			navigateToURL(url);
		}
		
		public function getLocation():void{
		
			printMsg("WiFi情報取得中...");
				
			//タイムスタンプとして現在時刻を取得
			timeStamp = new Date();
	
			//URL文字列を作成
			var URL:String = "http://localhost:5448/rtagjs?t=";
				URL += timeStamp.milliseconds + "&appk=";
				URL += appk;
			var request:URLRequest = new URLRequest(URL);
			var loader:URLLoader = new URLLoader();
			
			//イベントハンドラをセット
			setListeners(loader, "Client");
			
			//実際にリクエストを発行
			sendRequest(loader, request);

		}

		//イベントハンドラをセットする
		private function setListeners(dispatcher:IEventDispatcher, type:String):void {
			//電測と位置取得とAckでハンドラを切り替える処理
			if(type == "Client"){
	        	dispatcher.addEventListener(Event.COMPLETE, completeHandlerClient);
			}else if(type == "Server"){
				dispatcher.addEventListener(Event.COMPLETE, completeHandlerServer);
			}else if(type == "Ack"){
				dispatcher.addEventListener(Event.COMPLETE, completeHanderAck);
			}
			//共通で利用するハンドラ
	    	dispatcher.addEventListener(Event.OPEN, openHandler);
	    	dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
	    	dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
	    	dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
	    	dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}

	    //HTTP Request送信用メソッド
	    private function sendRequest(loader:URLLoader, request:URLRequest):void{
	    	try {
				loader.load(request);
			}catch(error:ArgumentError){
				debugPrintMsg("An ArgumentError has occurred.");	
			}catch(error:SecurityError){
				debugPrintMsg("A SecurityError has occurred.");	
			}
	    }
		//GETに対する応答が取得できたら呼ばれるハンドラ(クライアント)
		private function completeHandlerClient(event:Event):void{
			
			printMsg("PlaceEngineサーバに問い合わせ中...");
			
			var response:URLLoader = URLLoader(event.target);
	
			//冒頭の"recvRTAG"と");"を外して、パラメータを分解
			var recvRTAG:String = String(response.data);
			var rtagArray:Array = recvRTAG.substr(9, recvRTAG.length-12).split(",");
	
			//rtag, numapを取得
			var tmpString:String = rtagArray[0];
			var rtag:String = tmpString.substr(1, tmpString.length-2); //""を外す処理
			var numap:int = rtagArray[1];
			
			if(numap > 0){
				//電測が正常に取得できている場合
	
				//サーバアクセスに先立って、crossdomain.xmlの場所を指定
				Security.loadPolicyFile("http://www.placeengine.com/api/crossdomain.xml");
				
				//URL文字列を作成
				var URL2:String = "http://www.placeengine.com/api/loc?t=";
					URL2 += timeStamp.milliseconds + "&rtag=";
					URL2 += rtag + "&appk=";
					URL2 += appk + "&fmt=json";
				var request2:URLRequest = new URLRequest(URL2);
				var loader2:URLLoader = new URLLoader();
				
				//イベントハンドラをセット
				setListeners(loader2, "Server");
				
				//実際にリクエストを発行
				sendRequest(loader2, request2);

			}else{
				//電測でエラーの場合
				debugPrintMsg("電測でエラー発生 numap= " + numap);

				//callBack関数を呼ぶ
				if(getLocationFunc != null){
					getLocationFunc.call(getLocationFunc, 0, 0, numap, null);
				}
			}
		}
	
		//GETに対する応答が取得できたら呼ばれるハンドラ(サーバ)
		private function completeHandlerServer(event:Event):void{
			//返す値を初期化
			var lat:Number = 0;
			var lon:Number = 0;
			var range:int = 0;
			var info:Object = new Object();
			
			//レスポンスを取り出す
			var response2:URLLoader = URLLoader(event.target);
			
			//取得文字列を解析する
			var tmpMessage:String = String(response2.data);
			var recvMessage:String = tmpMessage.substr(1, tmpMessage.length-3);	//両側の[]を外す
			var param:Array = recvMessage.split(",");
			var param2:Array = recvMessage.split("{");
			
			if((param.length >= 4) && (param2.length >= 2)){
				lat = param[1];
				lon = param[0];
				range = param[2];

				//正常取得できている時
				if(range > 0){
					//infoの最後の"}"をはずす
					var tmpParam2:String = String(param2[1]);
					var infoArray:Array = tmpParam2.substr(0, tmpParam2.length-2).split(","); //-2なのは}を外すため

					//JSON形式を解析
					for(var i:int=0; i<infoArray.length; i++){
						//":"で前後に分割して
						var tmpArray:Array = String(infoArray[i]).split(":");
						var name:String = tmpArray[0].substr(1, tmpArray[0].length-2);
						var value:String = tmpArray[1];
						//連想配列に格納
						info[name] = value;
					}

					printMsg(info["addr"].substr(1, info["addr"].length-2));
	
				}else{
					//取得できていない時
					debugPrintMsg("getLoc Error occurred. " + String(param2[1]));
				}
			}
			//callBack関数を呼ぶ
			if(getLocationFunc != null){
				getLocationFunc.call(getLocationFunc, lat, lon, range, info);
			}
		}
		
		private function openHandler(event:Event):void {
	        debugPrintMsg("openHandler: " + event);
	    }
	
	    private function progressHandler(event:ProgressEvent):void {
	        debugPrintMsg("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
	    }
	
	    private function securityErrorHandler(event:SecurityErrorEvent):void {
	        debugPrintMsg("securityErrorHandler: " + event);
	    }
	
	    private function httpStatusHandler(event:HTTPStatusEvent):void {
	        debugPrintMsg("httpStatusHandler: " + event);
	    }
	
	    private function ioErrorHandler(event:IOErrorEvent):void {
	        debugPrintMsg("ioErrorHandler: " + event);
	    }
	    
	    //ラベルにメッセージを出力するサポートメソッド
	    private function printMsg(str:String):void{
	    	if(labelObject != null)	{
	    		labelObject.text = str;
	    	}
	    	//onMessagコールバック関数が定義されている場合にはそちらにも出力
	    	if(messageFunc != null){
	    		messageFunc.call(messageFunc, str);
	    	}
	    }
	    //デバッグ出力用
	    private function debugPrintMsg(str:String):void{
	    	//デバッグフラグがtrueでかつmessageFuncが指定されているときのみ
	    	if(debugMode && (messageFunc != null)){
	    		messageFunc.call(messageFunc, str);
	    	}
	    }
	    
	    //バージョン応答機能
	    private function getLibVersion():String{
	    	return(VERSION);
	    }
	}
}

