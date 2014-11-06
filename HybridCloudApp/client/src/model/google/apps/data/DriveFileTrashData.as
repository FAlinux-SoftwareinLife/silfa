package model.google.apps.data {

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;

	import abstracts.AppsDataAbstract;

	import identifier.DataName;
	import identifier.ProxyName;

	import manager.model.IData;
	import manager.model.ModelManager;

	import model.google.apps.GoogleAppsProxy;
	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.OAuthInfoData;

	public class DriveFileTrashData extends AppsDataAbstract implements IData {

		private const DATA_NAME:String = DataName.DRIVE_FILE_TRASH;

		private var result:Object;

		private const TRASH_REG_EXP:RegExp = /fileid/gi;

		public function DriveFileTrashData() {

			result = {type: DATA_NAME, data: ""};

		}

		public function get name():String {
			return DATA_NAME;
		}

		public function requestData():void {

		}

		public function parseData(data:Object):void {

			var _token:String;
			var _header:URLRequestHeader;
			var _request:URLRequest;
			var _loader:URLLoader;

			_token = oauthInfoDataObj.getAccessToken();

			_header = new URLRequestHeader();
			_header.name = headerNameAuth;
			_header.value = headerValueAuth + _token;

			_request = new URLRequest();
			_request.url = driveFileTrashURL.replace(TRASH_REG_EXP, data.id);
			_request.method = URLRequestMethod.POST;
			_request.requestHeaders.push(_header);

			_loader = new URLLoader(_request);
			_loader.addEventListener(Event.COMPLETE, loaderComplete);

		}

		private function loaderComplete(evt:Event):void {

			var _data:Object = {id: JSON.parse(evt.target.data).id};

			result.data = _data;

			sendProxy();

		}

		private function sendProxy():void {

			googleAppsProxyObj.resultData(result);

		}

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
