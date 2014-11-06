package info {

	public class GoogleHTTPRequestInfo {
		
		public static const HEADER_NAME_AUTH:String = "Authorization";
		public static const HEADER_VALUE_AUTH:String = "Bearer ";
		
		public static const PROFILE:String = "https://www.googleapis.com/plus/v1/people/me";
		public static const TOKEN_VALIDATION:String = "https://www.googleapis.com/oauth2/v1/tokeninfo";		
		public static const DRIVE_LIST:String = "https://www.googleapis.com/drive/v2/files";
		public static const DRIVE_FILE_TRASH:String = "https://www.googleapis.com/drive/v2/files/fileId/trash";
		public static const DRIVE_FILE:String = "https://www.googleapis.com/upload/drive/v2/files";
		
		public static const MIME_TYPE_DOC:String = "application/vnd.google-apps.document";
		public static const MIME_TYPE_SPR:String = "application/vnd.google-apps.spreadsheet";
		public static const MIME_TYPE_PRE:String = "application/vnd.google-apps.presentation";
		
		public function GoogleHTTPRequestInfo() {
			
		}
		
	}
}
