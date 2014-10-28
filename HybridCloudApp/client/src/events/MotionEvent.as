package events {
	
	import abstracts.EventAbstract;

	public class MotionEvent extends EventAbstract {
		
		public static const IN_MOTION_FINISHED:String = "inMotionFinished";
		public static const OUT_MOTION_FINISHED:String = "outMotionFinished";

		public function MotionEvent(type:String, paramObj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {

			super(type, paramObj, bubbles, cancelable);

		}
	}
}
