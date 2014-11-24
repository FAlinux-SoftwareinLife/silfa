package screen.log.window {
	
	import abstracts.LogAbstract;
	
	import identifier.LogName;

	public class WindowLog extends LogAbstract {
		
		private const LOG_NAME:String = LogName.WINDOW;
		
		public function WindowLog() {
			
			super(LOG_NAME);
			
		}
		
	}
}
