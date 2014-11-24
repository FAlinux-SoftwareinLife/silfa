package model.google.oauth.data {

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	import abstracts.OAuthDataAbstract;

	import identifier.DataName;
	import identifier.ProxyName;

	import info.GoogleHTTPRequestInfo;

	import manager.model.IData;
	import manager.model.ModelManager;

	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.OAuthInfoData;
	import model.google.oauth.GoogleOAuthProxy;

	public class OAuthValidationData extends OAuthDataAbstract implements IData {

		private const DATA_NAME:String = DataName.OAUTH_VALIDATION;

		private const REQUEST_LOGIN:String = "requestLogin";

		private var result:Object;

		public function OAuthValidationData() {

			result = {type: DATA_NAME, data: ""};

		}

		public function get name():String {

			return DATA_NAME;

		}

		public function requestData():void {

			if (oauthInfoDataObj.getAccessToken() == "") {

				result.data = {expires_in: REQUEST_LOGIN};

				sendProxy();

			} else {

				requestValidationData();

			}

		}

		public function parseData(data:Object):void {

		}

		private function requestValidationData():void {

			var _loader:URLLoader;

			_loader = new URLLoader(getURLRequest());
			_loader.addEventListener(Event.COMPLETE, requestValidationComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, requestErrorHandler);

		}

		private function requestErrorHandler(evt:IOErrorEvent):void {

			switch (evt.errorID) {

				case 2032:

					trace(this, "invalid token");

					result.data = {expires_in: 0};

					break;

			}

			sendProxy();

		}

		private function requestValidationComplete(evt:Event):void {

			evt.target.removeEventListener(Event.COMPLETE, requestValidationComplete);

			result.data = JSON.parse(evt.target.data);

			sendProxy();

			trace(this, "expires_in = " + result.data.expires_in);

		}

		private function getURLRequest():URLRequest {

			var _requestVariables:URLVariables;
			var _request:URLRequest;

			_requestVariables = new URLVariables();
			_requestVariables.access_token = oauthInfoDataObj.getAccessToken();

			_request = new URLRequest(GoogleHTTPRequestInfo.OAUTH_VALIDATION_URL);

			_request.data = _requestVariables;

			return _request;

		}

		private function sendProxy():void {

			googleOAuthProxyObj.resultData(result);

		}

		// ------------------------ get obj ------------------------

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

		private function get oauthInfoDataObj():OAuthInfoData {

			return googleInfoProxyObj.getData(DataName.OAUTH_INFO) as OAuthInfoData;

		}

		private function get googleOAuthProxyObj():GoogleOAuthProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_OAUTH) as GoogleOAuthProxy;

		}

	}
}
