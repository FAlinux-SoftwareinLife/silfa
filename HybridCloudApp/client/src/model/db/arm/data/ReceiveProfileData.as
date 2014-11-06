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

	import model.db.arm.ArmProxy;
	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.ProfileInfoData;

	public class ReceiveProfileData implements IData {

		private const DATA_NAME:String = DataName.RECEIVE_PROFILE;

		private var result:Object;

		public function ReceiveProfileData() {

			result = {type: DATA_NAME, data: ""};

		}

		public function get name():String {

			return DATA_NAME;

		}

		public function requestData():void {

			requestProfileData();

		}

		private function requestProfileData():void {

			var _loader:URLLoader;
			var _request:URLRequest;
			var _userId:String = profileInfoDataObj.getUserId();

			_request = new URLRequest(ArmHTTPRequestInfo.HOST_URL + ArmHTTPRequestInfo.USERS + _userId);
			_request.method = URLRequestMethod.GET;

			_loader = new URLLoader(_request);
			_loader.addEventListener(Event.COMPLETE, loadComplete);

		}

		public function parseData(data:Object):void {
		}

		private function loadComplete(evt:Event):void {

			trace("Receive Arm Server - Profile");

			var _data:Object = JSON.parse(evt.target.data);
			
			result.data = _data.data;

			sendProxy();

		}

		private function sendProxy():void {

			armProxyObj.resultData(result);

		}


		private function get googleInfoProxObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

		private function get profileInfoDataObj():ProfileInfoData {

			return googleInfoProxObj.getData(DataName.PROFILE_INFO) as ProfileInfoData;

		}

		private function get armProxyObj():ArmProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.ARM) as ArmProxy;

		}
		
	}
}
