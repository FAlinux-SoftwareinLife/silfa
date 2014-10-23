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
		
		protected function get headerName():String {
		
			return GoogleHTTPRequestInfo.HEADER_NAME;
		
		}
		
		protected function get headerValue():String {
			
			return GoogleHTTPRequestInfo.HEADER_VALUE;
			
		}
		
	}
}
