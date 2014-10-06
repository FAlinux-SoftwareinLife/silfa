package screen.application {

	import manager.screen.IScreen;

	import screen.ScreenFrame;

	/**
	 *
	 * @author mini
	 * Application layout.
	 *
	 */
	public class ApplicationMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = "application";

		public function ApplicationMediator() {
			super();
		}

		public function reset():void {

		}

		public function get name():String {

			return SCREEN_NAME;

		}

	}
}
