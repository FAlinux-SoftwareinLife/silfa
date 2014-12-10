package model.db.arm.data {

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	import identifier.DataName;
	import identifier.ProxyName;

	import info.ArmHTTPRequestInfo;

	import manager.model.IData;
	import manager.model.ModelManager;

	import model.db.arm.ArmServerProxy;

	/**
	 * 
	 * Not used.
	 * 
	 */
	public class InsertMeasureData implements IData {

		private static const DATA_NAME:String = DataName.INSERT_MEASURE;

		private var result:Object;
		private var insertData:Object;
		private var insertCheck_num:uint;
		private var timer:Timer;
		private var startDelay:Number;
		private var checkDelay:Number;
		private var checkObj:Vector.<Object>;
		private var id_num:uint;

		public function InsertMeasureData() {

			result = {type: DATA_NAME, data: ""};

			timer = new Timer(20);

		}

		public function get name():String {
			return DATA_NAME;
		}

		public function requestData():void {
		}

		public function parseData(data:Object):void {

			insertData = data;

			checkObj = new Vector.<Object>();

			insertMeasureData();

		}

		private function insertMeasureData():void {

			var _insertNum:uint = insertData.num;
			var _loader:URLLoader;
			var _request:URLRequest;
			var _variables:URLVariables;
			
			_variables = new URLVariables();
			_variables.userId = insertData.userId + String(id_num++);
			
			_request = new URLRequest(ArmHTTPRequestInfo.HOST_URL + ArmHTTPRequestInfo.USERS);
			_request.data = _variables;
			_request.method = URLRequestMethod.POST;
			
			_loader = new URLLoader(_request);
			_loader.addEventListener(Event.COMPLETE, loadComplete);

		}

		private function loadComplete(evt:Event):void {

		}

		private function setCheckData(loader:URLLoader):void {

			for each (var _obj:Object in checkObj) {
				if (_obj.loader == loader) {
					_obj.time = getTimer() - startDelay

					trace(_obj.name, _obj.time / 1000);

				}


			}

		}

		private function checkComplete():void {

			result.data = checkObj;

			id_num = 0;
			insertCheck_num = 0;
			startDelay = checkDelay = 0;

			checkObj = new Vector.<Object>();

			sendProxy();

		}

		private function sendProxy():void {

			armServerProxyObj.resultData(result);

		}

		//===================== obj reference =====================

		private function get armServerProxyObj():ArmServerProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.ARM_SERVER) as ArmServerProxy;

		}



	}
}
