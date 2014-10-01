package screen.database {

	import manager.screen.IScreen;

	import screen.ScreenFrame;

	/**
	 *
	 * @author mini
	 * Database data info list.
	 *
	 */
	public class DatabaseMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = "database";

		public function DatabaseMediator() {
			
			super();
			
		}

		public function reset():void {
			
			
		}

		public function get name():String {
			
			return SCREEN_NAME;
			
		}
		
	}
}
