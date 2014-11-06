package events {

	import abstracts.EventAbstract;

	public class AppsEvent extends EventAbstract {

		public static const REQUEST_PROFILE_COMPLETE:String = "requestProfileComplete";
		public static const REQUEST_DRIVE_LIST_COMPLETE:String = "requestDriveListComplete";
		public static const DRIVE_FILE_TRASH_COMPLETE:String = "driveFileTrashComplete";
		public static const CREATE_DOC_FILE:String = "createDocFile";
		public static const CREATE_SPR_FILE:String = "createSprFile";
		public static const CREATE_PRE_FILE:String = "createPreFile";

		public function AppsEvent(type:String, paramObj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {

			super(type, paramObj, bubbles, cancelable);

		}
	}
}
