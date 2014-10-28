package abstracts {
	import info.GoogleHTTPRequestInfo;

	public class AppsDataAbstarct {
		
		public function AppsDataAbstarct() {
		}
		
		protected function get profileURL():String {
		
			return GoogleHTTPRequestInfo.PROFILE;
		
		}
		
		protected function get tokenValidationURL():String {
		
			return GoogleHTTPRequestInfo.TOKEN_VALIDATION;
		
		}
		
		protected function get headerNameAuth():String {
		
			return GoogleHTTPRequestInfo.HEADER_NAME_AUTH;
		
		}
		
		protected function get headerValueAuth():String {
			
			return GoogleHTTPRequestInfo.HEADER_VALUE_AUTH;
			
		}
		
		protected function get driveListURL():String {
			
			return GoogleHTTPRequestInfo.DRIVE_LIST;
			
		}
		
	}
}
