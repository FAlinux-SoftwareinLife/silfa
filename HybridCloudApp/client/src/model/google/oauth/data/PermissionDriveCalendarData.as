package model.google.oauth.data {

	import flash.net.URLRequest;
	import flash.net.URLVariables;

	import abstracts.OAuthDataAbstract;

	import identifier.DataName;
	import identifier.ProxyName;

	import manager.model.IData;
	import manager.model.ModelManager;

	import model.google.oauth.GoogleOAuthProxy;

	/**
	 * Request Drive&Calendar.
	 *
	 */
	public class PermissionDriveCalendarData extends OAuthDataAbstract implements IData {

		private const DATA_NAME:String = DataName.PERMISSION_DRIVE_CALENDAR;

		private var result:Object;

		public function PermissionDriveCalendarData() {

			result = {type: DATA_NAME, data: ""};

		}

		public function get name():String {

			return DATA_NAME;

		}

		public function requestData():void {

			result.data = setDriveCalendarData();
			
			sendProxy();

		}

		private function sendProxy():void {

			googleOAuthProxyObj.resultData(result);

		}

		private function setDriveCalendarData():String {

			var _url:String;
			var _urlRequest:URLRequest;
			var _urlVariables:URLVariables;

			_urlVariables = new URLVariables();
			_urlVariables.response_type = responseType;
			_urlVariables.client_id = clientId;
			_urlVariables.redirect_uri = redirectURI;
			_urlVariables.scope = scopeDriveCalendar;
			_urlVariables.state = state;
			_urlVariables.login_hint = loginHint;
			_urlVariables.include_granted_scopes = includeGrantedScopes;

			_urlRequest = new URLRequest();
			_urlRequest.url = oauthURL;
			_urlRequest.data = _urlVariables;

			_url = _urlRequest.url + _urlRequest.data;

			return _url;

		}


		public function parseData(data:Object):void {

		}

		private function get googleOAuthProxyObj():GoogleOAuthProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_OAUTH) as GoogleOAuthProxy;

		}

	}
}
