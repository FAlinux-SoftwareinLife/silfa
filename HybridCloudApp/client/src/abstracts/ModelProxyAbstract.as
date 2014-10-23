package abstracts {
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class ModelProxyAbstract extends EventDispatcher {
		
		public function ModelProxyAbstract(target:IEventDispatcher = null) {
			super(target);
		}
		
	}
}
