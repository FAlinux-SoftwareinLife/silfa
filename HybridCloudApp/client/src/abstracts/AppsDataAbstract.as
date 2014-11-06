package abstracts {
	import info.GoogleHTTPRequestInfo;

	public class AppsDataAbstract {
		
		public function AppsDataAbstract() {
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
		
		protected function get driveFileTrashURL():String {
			
			return GoogleHTTPRequestInfo.DRIVE_FILE_TRASH;
			
		}
		
	}
}
