package model.google.oauth {

	import flash.events.Event;
	import flash.media.StageWebView;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	import manager.model.IModel;
	import manager.screen.ScreenManager;

	import screen.web.WebMediator;

	public class GoogleOAuthData implements IModel {

		private const MODEL_NAME:String = "oauth";

		private const GOOGLE_OAUTH_URL:String = "https://accounts.google.com/o/oauth2/auth?";
		private const RESPONSE_TYPE:String = "token";
		private const CLIENT_ID:String = "584043853239-9ln3a7lteu6ha06mmoppd62i1oan7ag5.apps.googleusercontent.com";
		private const REDIRECT_URI:String = "http://localhost/google/redirect_page.php";
		private const SCOPE:String = "https://www.googleapis.com/auth/drive https://www.googleapis.com/auth/gmail.compose https://www.googleapis.com/auth/calendar";
		private const STATE:String = "modulescreenstate";
		private const APPROVAL_PROMPT:String = "auto";
		private const LOGIN_HINT:String = "Your Login Info";
		private const INCLUDE_GRANTED_SCOPES:String = "true";

		public function GoogleOAuthData() {

		}

		public function get name():String {

			return MODEL_NAME;

		}

		/**
		 * Authorization information.
		 * @return
		 * access_token, expire_in.
		 *
		 */
		public function get authInfo():Object {

			return requestOAuth();

		}

		private function requestOAuth():Object {

			var _urlLoader:URLLoader;
			var _urlRequest:URLRequest;
			var _urlVariables:URLVariables = new URLVariables();

			_urlVariables.response_type = RESPONSE_TYPE;
			_urlVariables.client_id = CLIENT_ID;
			_urlVariables.redirect_uri = REDIRECT_URI;
			_urlVariables.scope = SCOPE;
			_urlVariables.state = STATE;
			_urlVariables.login_hint = LOGIN_HINT;
			_urlVariables.include_granted_scopes = INCLUDE_GRANTED_SCOPES;

			_urlRequest = new URLRequest();
			_urlRequest.url = GOOGLE_OAUTH_URL;
			_urlRequest.data = _urlVariables;
			
			
			var _sw:WebMediator = ScreenManager.screenManagerObj.getMediator("web") as WebMediator;
			
			_sw.setWebView(true, _urlRequest.url + _urlRequest.data);
			
			/*
			_urlLoader = new URLLoader(_urlRequest);
			_urlLoader.addEventListener(Event.COMPLETE, function(evt:Event):void {

				trace("oauth data = " + evt.target.data);


			});
			*/
			
			return new Object();

		}

	/*
	private function getOAuthInfo(oauthData:String):String {

		return oauthData;

	}
	*/

	}
}
