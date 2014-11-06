package events {
	
	import abstracts.EventAbstract;

	public class ArmEvent extends EventAbstract {
		
		public static const INSERT_PROFILE_COMPLETE:String = "insertProfileComplete";
		public static const RECEIVE_PROFILE_COMPLETE:String = "receiveProfileComplete";
		public static const INSERT_DRIVE_FILE_COMPLETE:String = "insertDriveFileComplete";
		public static const RECEIVE_DRIVE_FILE_COMPLETE:String = "receiveDriveFileComplete";
		
		public function ArmEvent(type:String, paramObj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			
			super(type, paramObj, bubbles, cancelable);
			
		}
		
	}
}
