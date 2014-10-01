package screen.googleapps {

	import manager.screen.IScreen;

	import screen.ScreenFrame;

	/**
	 *
	 * @author mini
	 * Google apps icon group.
	 *
	 */
	public class GoogleAppsMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = "googleapps";

		public function GoogleAppsMediator() {
			
			super();
			
		}

		public function reset():void {
			
			
		}

		public function get name():String {

			return SCREEN_NAME;

		}

	}
}
