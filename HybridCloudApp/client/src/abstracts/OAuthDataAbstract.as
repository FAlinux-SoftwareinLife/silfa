package abstracts {
	
	import info.GoogleClientInfo;
	import info.GoogleHTTPRequestInfo;

	public class OAuthDataAbstract {
		
		public function OAuthDataAbstract() {
		}
		
		protected function get oauthURL():String {
		
			return GoogleHTTPRequestInfo.GOOGLE_OAUTH_URL;
		
		}
		
		protected function get responseType():String {
			
			return GoogleClientInfo.RESPONSE_TYPE;
			
		}
		 
		protected function get clientId():String {
			
			return GoogleClientInfo.CLIENT_ID;
			
		}
		
		protected function get redirectURI():String {
			
			return GoogleClientInfo.REDIRECT_URI;
			
		}
		
		protected function get state():String {
			
			return GoogleClientInfo.STATE;
			
		}
		
		protected function get approvalPrompt():String {
			
			return GoogleClientInfo.APPROVAL_PROMPT;
			
		}
		
		protected function get loginHint():String {
			
			return GoogleClientInfo.LOGIN_HINT;
			
		}
		
		protected function get includeGrantedScopes():String {
			
			return GoogleClientInfo.INCLUDE_GRANTED_SCOPES;
			
		}		
		
		protected function get scopeProfile():String {
			
			return GoogleClientInfo.SCOPE_PROFILE;
			
		}
		
		protected function get scopeGmail():String {
			
			return GoogleClientInfo.SCOPE_GMAIL;
			
		}
		
		protected function get scopeDrive():String {
			
			return GoogleClientInfo.SCOPE_DRIVE;
			
		}
		
		protected function get scopeDriveCalendar():String {
			
			return GoogleClientInfo.SCOPE_DRIVE_CALENDAR;
			
		}
		
		protected function get scopeCalendar():String {
			
			return GoogleClientInfo.SCOPE_CALENDAR;
			
		}
		
		
	}
}
