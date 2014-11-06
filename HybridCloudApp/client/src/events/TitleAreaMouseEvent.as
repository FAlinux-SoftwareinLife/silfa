package events {
	
	import abstracts.EventAbstract;

	public class TitleAreaMouseEvent extends EventAbstract {
		
		public static const TITLE_AREA_CLICK:String = "titleAreaClick";
		
		public function TitleAreaMouseEvent(type:String, paramObj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, paramObj, bubbles, cancelable);
		}
	}
}
