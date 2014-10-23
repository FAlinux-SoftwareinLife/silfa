package screen.info {

	import abstracts.WebViewAbstract;
	
	import frame.ScreenFrame;
	
	import identifier.ScreenName;
	
	import manager.screen.IScreen;

	/**
	 *
	 * @author mini
	 * Google apps icon group.
	 *
	 */
	public class InfoMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = ScreenName.INFO;

		public function InfoMediator() {

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
