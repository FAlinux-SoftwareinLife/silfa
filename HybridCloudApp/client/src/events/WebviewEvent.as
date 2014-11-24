package events {
	
	import abstracts.EventAbstract;

	public class WebviewEvent extends EventAbstract {
		
		public static const REQUEST_LOAD:String = "load";
		public static const FIRST_POINT_COMPLETE:String = "firstPointComplete";
		public static const END_POINT_COMPLETE:String = "endPointComplete";
		
		public function WebviewEvent(type:String, paramObj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			
			super(type, paramObj, bubbles, cancelable);
				
		}
		
	}
}
