package model.google.info.data {

	import identifier.DataName;
	import identifier.ProxyName;
	
	import manager.model.IData;
	import manager.model.ModelManager;
	
	import model.google.info.GoogleInfoProxy;
	
	import utils.URLStringParser;

	public class OAuthInfoData implements IData {

		private static const DATA_NAME:String = DataName.OAUTH_INFO;

		private var oauthInfoObj:Object;
		
		private var result:Object;

		public function OAuthInfoData() {
			
			result = {type: DATA_NAME, data: ""};

			oauthInfoObj = {

					tokenType: "",

					accessToken: "",

					expireTime: 0,

					state: "",

					scope: new Vector.<String>()

			}

		}

		public function get name():String {

			return DATA_NAME;

		}

		public function requestData():void {
		}

		public function parseData(data:Object):void {

			var _queryObj:Object = urlStringParserObj.getQueryObj(String(data));
			trace("_queryObj.access_token  = " + _queryObj.access_token);
			
			var _takeOpen:Boolean = _queryObj.access_token !== undefined;
			
			if (_takeOpen)
				setInfo(_queryObj);
			
			result.data = {takeToken:_takeOpen};
			
			sendProxy();
			
		}

		private function setInfo(queryObj:Object):void {

			var _scope:Vector.<String> = urlStringParserObj.getScopeList(queryObj.scope);
			var _scopeNum:int = _scope.length;

			oauthInfoObj.tokenType = queryObj.token_type;
			oauthInfoObj.accessToken = queryObj.access_token;
			oauthInfoObj.expireTime = queryObj.expires_in;
			oauthInfoObj.state = queryObj.state;
			oauthInfoObj.scope = _scopeNum != 0 ? _scope : oauthInfoObj.scope;

		}
		
		public function getAccessToken():String {

			return oauthInfoObj.accessToken;

		}

		public function getExpireTime():int {

			return oauthInfoObj.expireTime;

		}

		public function getState():String {

			return oauthInfoObj.state;

		}

		public function getScope():Vector.<String> {

			return oauthInfoObj.scope;

		}

		public function reset():void {

			oauthInfoObj = {

					tokenType: "",

					accessToken: "",

					expireTime: 0,

					state: "",

					scope: new Vector.<String>()

			}

		}
		
		private function sendProxy():void {
			
			googleInfoProxyObj.resultData(result);
			
		}
		
		
		// ------------------------ get obj ------------------------
		
		private function get urlStringParserObj():URLStringParser {
			
			return URLStringParser.urlStringParserObj as URLStringParser;
			
		}
		
		private function get googleInfoProxyObj():GoogleInfoProxy {
			
			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;
			
		}


	}
}
