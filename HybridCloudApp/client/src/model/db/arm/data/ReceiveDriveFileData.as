package model.db.arm.data {

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;

	import identifier.DataName;
	import identifier.ProxyName;

	import info.ArmHTTPRequestInfo;

	import manager.model.IData;
	import manager.model.ModelManager;

	import model.db.arm.ArmServerProxy;
	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.DriveListInfoData;

	public class ReceiveDriveFileData implements IData {

		private const DATA_NAME:String = DataName.RECEIVE_DRIVE_FILE;

		private var result:Object;

		public function ReceiveDriveFileData() {

			result = {type: DATA_NAME, data: ""};

		}

		public function get name():String {
			return DATA_NAME;
		}

		public function requestData():void {

			requestDriveFileData();
		}

		private function requestDriveFileData():void {

			var _loader:URLLoader;
			var _request:URLRequest;

			var _openFileObj:Object = driveListInfoDataObj.getOpenFile();

			var _fileId:String = _openFileObj.id;

			_request = new URLRequest(ArmHTTPRequestInfo.HOST_URL + ArmHTTPRequestInfo.FILES + _fileId);
			_request.method = URLRequestMethod.GET;

			_loader = new URLLoader(_request);
			_loader.addEventListener(Event.COMPLETE, loadComplete);

		}

		public function parseData(data:Object):void {
		}

		private function loadComplete(evt:Event):void {

			trace("Receive Arm Server - File");

			var _data:Object = JSON.parse(evt.target.data);

			result.data = _data.data;

			sendProxy();

		}

		private function sendProxy():void {

			armProxyObj.resultData(result);

		}

		//===================== obj reference =====================

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

		private function get driveListInfoDataObj():DriveListInfoData {

			return googleInfoProxyObj.getData(DataName.DRIVE_LIST_INFO) as DriveListInfoData;

		}

		private function get armProxyObj():ArmServerProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.ARM_SERVER) as ArmServerProxy;

		}

	}
}
