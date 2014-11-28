package model.db.arm.data {

	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	import identifier.DataName;
	import identifier.ProxyName;

	import info.ArmHTTPRequestInfo;

	import manager.model.IData;
	import manager.model.ModelManager;

	import model.db.arm.ArmServerProxy;
	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.DriveListInfoData;
	import model.google.info.data.ProfileInfoData;

	public class InsertDriveFileData implements IData {

		private static const DATA_NAME:String = DataName.INSERT_DRIVE_FILE;

		private var result:Object;

		public function InsertDriveFileData() {

			result = {type: DATA_NAME, data: ""};

		}

		public function get name():String {
			return DATA_NAME;
		}

		public function requestData():void {

			insertDriveFileData();

		}

		private function insertDriveFileData():void {

			var _loader:URLLoader;
			var _request:URLRequest;
			var _variables:URLVariables;

			_variables = new URLVariables();

			var _openFileObj:Object = driveListInfoDataObj.getOpenFile();

			_variables.fileId = String(_openFileObj.id);
			_variables.fileName = String(_openFileObj.title);
			_variables.fileType = String(_openFileObj.fileType);
			_variables.modifiedDate = String(_openFileObj.modifiedDate);
			_variables.thumbnail = String(_openFileObj.thumbnailLink);
			_variables.userId = String(profileInfoDataObj.getUserId());

			_request = new URLRequest(ArmHTTPRequestInfo.HOST_URL + ArmHTTPRequestInfo.FILES);
			_request.data = _variables;
			_request.method = URLRequestMethod.POST;

			_loader = new URLLoader(_request);
			_loader.addEventListener(Event.COMPLETE, loadComplete);
			_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);

		}

		private function httpStatusHandler(evt:HTTPStatusEvent):void {

			trace("status = " + evt.status);

		}

		private function errorHandler(evt:IOErrorEvent):void {

			trace("errorID = " + evt.errorID);
			result.data = evt.errorID;

			sendProxy();

		}

		private function loadComplete(evt:Event):void {

			trace("Insert Arm Server - File");

			sendProxy();

		}

		private function sendProxy():void {

			armServerProxyObj.resultData(result);

		}

		public function parseData(data:Object):void {
		}

		//===================== obj reference =====================


		private function get armServerProxyObj():ArmServerProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.ARM_SERVER) as ArmServerProxy;

		}

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

		private function get driveListInfoDataObj():DriveListInfoData {

			return googleInfoProxyObj.getData(DataName.DRIVE_LIST_INFO) as DriveListInfoData;

		}

		private function get profileInfoDataObj():ProfileInfoData {

			return googleInfoProxyObj.getData(DataName.PROFILE_INFO) as ProfileInfoData;

		}


	}
}
