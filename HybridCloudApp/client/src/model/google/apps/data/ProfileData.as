package model.google.apps.data {

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;

	import abstracts.AppsDataAbstarct;

	import identifier.DataName;
	import identifier.ProxyName;

	import manager.model.IData;
	import manager.model.ModelManager;

	import model.google.apps.GoogleAppsProxy;
	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.OAuthInfoData;

	public class ProfileData extends AppsDataAbstarct implements IData {

		private const DATA_NAME:String = DataName.PROFILE;

		private var result:Object;

		public function ProfileData() {

			result = {type: DATA_NAME, data: ""};

		}

		public function get name():String {

			return DATA_NAME;

		}

		public function requestData():void {
			
			requestProfileData();

		}

		private function requestProfileData():void {

			var _token:String;
			var _header:URLRequestHeader;
			var _request:URLRequest;
			var _loader:URLLoader;

			_token = oauthInfoDataObj.getAccessToken();

			_header = new URLRequestHeader();
			_header.name = headerNameAuth;
			_header.value = headerValueAuth + _token;

			_request = new URLRequest();
			_request.url = profileURL;
			_request.requestHeaders.push(_header);

			_loader = new URLLoader(_request);
			_loader.addEventListener(Event.COMPLETE, loaderComplete);
			trace("_token = " + _token);
			trace("_header = " + _header);
			trace("_header.name = " + _header.name);
			trace("_header.value = " + _header.value);

		}

		public function parseData(data:Object):void {
		}

		private function loaderComplete(evt:Event):void {

			result.data = JSON.parse(evt.target.data);

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
