package info {

	public class GoogleClientInfo {

		public static const RESPONSE_TYPE:String = "token";
		public static const CLIENT_ID:String = "584043853239-9ln3a7lteu6ha06mmoppd62i1oan7ag5.apps.googleusercontent.com";
		public static const REDIRECT_URI:String = "http://localhost/google/redirect_page.php";
		public static const STATE:String = "login";
		public static const APPROVAL_PROMPT:String = "auto";
		public static const LOGIN_HINT:String = "user";
		public static const INCLUDE_GRANTED_SCOPES:String = "true";

		public static const SCOPE_PROFILE:String = "profile email";
		public static const SCOPE_GMAIL:String = "https://www.googleapis.com/auth/gmail.compose";
		public static const SCOPE_DRIVE:String = "https://www.googleapis.com/auth/drive";
		public static const SCOPE_CALENDAR:String = "https://www.googleapis.com/auth/calendar";
		public static const SCOPE_DRIVE_CALENDAR:String = SCOPE_DRIVE + " " + SCOPE_CALENDAR;

		public function GoogleClientInfo() {

		}

	}
}
