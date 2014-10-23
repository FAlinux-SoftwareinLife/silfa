package model.google.info.data {

	import identifier.DataName;

	import manager.model.IData;

	import utils.URLStringParser;

	public class OAuthInfoData implements IData {

		private static const DATA_NAME:String = DataName.OAUTH_INFO;

		private var oauthInfoObj:Object;

		public function OAuthInfoData() {

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
			var _scope:Vector.<String> = urlStringParserObj.getScopeList(_queryObj.scope);
			var _scopeNum:int = _scope.length;

			oauthInfoObj.tokenType = _queryObj.token_type;
			oauthInfoObj.accessToken = _queryObj.access_token;
			oauthInfoObj.expireTime = _queryObj.expires_in;
			oauthInfoObj.state = _queryObj.state;
			oauthInfoObj.scope = _scopeNum != 0 ? _scope : oauthInfoObj.scope;

		}

		//토큰을 획득한지 확인 (토큰획득이 안되어 있으면 요청)
		//access token 요청시 유효성 검사 (유효하지 않은 토큰이면 재요청)		
		public function getAccessToken():String {

			return oauthInfoObj.accessToken;

		}

		public function getExpireTime():int {

			return oauthInfoObj.expireTime;

		}

		public function getScope():Vector.<String> {

			return oauthInfoObj.scope;

		}

		private function get urlStringParserObj():URLStringParser {

			return URLStringParser.urlStringParserObj as URLStringParser;

		}


	}
}
