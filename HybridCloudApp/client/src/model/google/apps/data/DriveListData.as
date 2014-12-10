package model.google.apps.data {

	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLVariables;

	import abstracts.AppsDataAbstract;

	import identifier.DataName;
	import identifier.ProxyName;

	import manager.model.IData;
	import manager.model.ModelManager;

	import model.google.apps.GoogleAppsProxy;
	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.OAuthInfoData;

	public class DriveListData extends AppsDataAbstract implements IData {

		private const DATA_NAME:String = DataName.DRIVE_LIST;

		private const MAX_RESULTS:int = 5;
		private const CORPUS:String = "DEFAULT";
		private const PAGE_TOKEN:String = "";
		private const PROJECTION:String = "BASIC";
		private const QUERY:String = "trashed = false"

		private var result:Object;

		public function DriveListData() {

			result = {type: DATA_NAME, data: ""};

		}

		public function get name():String {

			return DATA_NAME;

		}

		public function requestData():void {

			requestDriveListData();

		}

		private function requestDriveListData():void {

			var _token:String;
			var _header:URLRequestHeader;
			var _requestVariables:URLVariables;
			var _request:URLRequest;
			var _loader:URLLoader;

			_token = oauthInfoDataObj.getAccessToken();

			_header = new URLRequestHeader();
			_header.name = headerNameAuth;
			_header.value = headerValueAuth + _token;

			_requestVariables = new URLVariables();
			_requestVariables.maxResults = MAX_RESULTS;
			_requestVariables.corpus = CORPUS;
			_requestVariables.pageToken = PAGE_TOKEN;
			_requestVariables.projection = PROJECTION;
			_requestVariables.q = QUERY;

			_request = new URLRequest();
			_request.url = driveListURL;
			_request.requestHeaders.push(_header);
			_request.data = _requestVariables;

			_loader = new URLLoader(_request);
			_loader.addEventListener(Event.COMPLETE, loaderComplete);
			_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);

		}

		private function httpStatusHandler(evt:HTTPStatusEvent):void {

			trace(evt.status);

		}

		private function errorHandler(evt:IOErrorEvent):void {
			trace(evt.errorID);
			result.data = evt.errorID;


			sendProxy();

		}

		private function loaderComplete(evt:Event):void {

			result.data = JSON.parse(evt.target.data);

			sendProxy();

		}

		private function sendProxy():void {

			googleAppsProxyObj.resultData(result);

		}

		public function parseData(data:Object):void {
		}


		//===================== obj reference =====================


		private function get oauthInfoDataObj():OAuthInfoData {

			return googleInfoProxyObj.getData(DataName.OAUTH_INFO) as OAuthInfoData;

		}

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

		private function get googleAppsProxyObj():GoogleAppsProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_APPS) as GoogleAppsProxy;

		}

	}
}
