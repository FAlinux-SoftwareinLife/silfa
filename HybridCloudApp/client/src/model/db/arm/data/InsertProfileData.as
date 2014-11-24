package model.db.arm.data {

	import flash.events.Event;
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
	import model.google.info.data.OAuthInfoData;
	import model.google.info.data.ProfileInfoData;

	public class InsertProfileData implements IData {

		private static const DATA_NAME:String = DataName.INSERT_PROFILE;

		private var result:Object;

		public function InsertProfileData() {

			result = {type: DATA_NAME, data: ""};

		}

		public function get name():String {

			return DATA_NAME;

		}

		public function requestData():void {

			insertProfileData();

		}

		private function insertProfileData():void {

			var _loader:URLLoader;
			var _request:URLRequest;
			var _variables:URLVariables;

			_variables = new URLVariables();

			_variables.userId = String(profileInfoDataObj.getUserId());
			_variables.photo = String(profileInfoDataObj.getUserImageURL());
			_variables.gender = String(profileInfoDataObj.getUserGender());
			_variables.email = String(profileInfoDataObj.getUserEmail());
			_variables.language = String(profileInfoDataObj.getUserLanguage());
			_variables.authorize = String(oauthInfoDataObj.getScope());

			_request = new URLRequest(ArmHTTPRequestInfo.HOST_URL + ArmHTTPRequestInfo.USERS);
			_request.data = _variables;
			_request.method = URLRequestMethod.POST;

			_loader = new URLLoader(_request);
			_loader.addEventListener(Event.COMPLETE, loadComplete);

		}

		public function parseData(data:Object):void {
		}

		private function loadComplete(evt:Event):void {

			trace("Insert Arm Server - Profile");

			sendProxy();

		}

		private function sendProxy():void {

			armProxyObj.resultData(result);

		}

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

		private function get profileInfoDataObj():ProfileInfoData {

			return googleInfoProxyObj.getData(DataName.PROFILE_INFO) as ProfileInfoData;

		}

		private function get oauthInfoDataObj():OAuthInfoData {

			return googleInfoProxyObj.getData(DataName.OAUTH_INFO) as OAuthInfoData;

		}

		private function get armProxyObj():ArmServerProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.ARM_SERVER) as ArmServerProxy;

		}

	}
}
