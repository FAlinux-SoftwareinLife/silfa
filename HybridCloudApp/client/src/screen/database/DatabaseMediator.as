package screen.database {

	import abstracts.WebViewAbstract;
	
	import frame.ScreenFrame;
	
	import identifier.ScreenName;
	
	import manager.screen.IScreen;

	/**
	 *
	 * @author mini
	 * Database data info list.
	 *
	 */
	public class DatabaseMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = ScreenName.DATABASE;

		public function DatabaseMediator() {
			
			super();
			
		}

		public function reset():void {
			
			
		}

		public function get name():String {
			
			return SCREEN_NAME;
			
		}
		
		public function set view(obj:Object):void {
			
		}
		
	}
}
