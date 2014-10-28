package events {
	
	import abstracts.EventAbstract;

	public class OAuthEvent extends EventAbstract {

		public static const REQUEST_INIT:String = "requestInit";
		public static const REQUEST_COMPLETE:String = "requestComplete";
		public static const REQUEST_LOGIN_COMPLETE:String = "requestLoginComplete";
		public static const REQUEST_GMAIL_COMPLETE:String = "requestGmailComplete";
		public static const REQUEST_DRIVE_CALENDAR_COMPLETE:String = "requestDriveCalendarComplete";
		
		public function OAuthEvent(type:String, paramObj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			
			super(type, paramObj, bubbles, cancelable);
			
		}
		
	}
}
