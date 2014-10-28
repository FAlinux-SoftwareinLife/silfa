package events {
	
	import abstracts.EventAbstract;

	public class AppsEvent extends EventAbstract {
		
		public static const REQUEST_PROFILE_COMPLETE:String = "requestProfileComplete";
		public static const REQUEST_DRIVE_LIST_COMPLETE:String = "requestDriveListComplete";
		
		public function AppsEvent(type:String, paramObj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			
			super(type, paramObj, bubbles, cancelable);
			
		}
	}
}
