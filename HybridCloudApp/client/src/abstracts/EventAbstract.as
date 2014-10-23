package abstracts {
	
	import flash.events.Event;

	public class EventAbstract extends Event {
		
		protected var _paramObj:Object; 
		
		public function EventAbstract(type:String, paramObj:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
			
			super(type, bubbles, cancelable);
			
			_paramObj = paramObj;
			
		}

		/**
		 * Custom parameter data.
		 * @return Constructor parameter 'paramObj'.
		 *
		 */
		public function get param():Object {

			return _paramObj;

		}
		
	}
}
