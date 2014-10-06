package manager.screen {

	/**
	 *
	 * @author Softwareinlife inc.
	 * Screen mediator manager.
	 *
	 */

	public class ScreenManager {

		private static var screenManager:ScreenManager;

		private var screenList:Vector.<Object>;

		public function ScreenManager(blockScreenManager:BlockScreenManager) {
			
			screenList = new Vector.<Object>();
			
		}

		/**
		 * Add mediator in 'screenList' instance.
		 * @param mediator Mediator instance.
		 *
		 */
		public function addMediator(mediator:IScreen):void {

			var _obj:Object = {name: mediator.name, screen: mediator};
			screenList.push(_obj);

		}

		public function removeMediator(screen:IScreen):void {


		}

		/**
		 *
		 * @param name
		 * @return Select screen mediator;
		 *
		 */
		public function getMediator(name:String):IScreen {

			var _mediator:IScreen;

			for each (var obj:Object in screenList)
				if (name == obj.name)
					_mediator = obj.screen;

			return _mediator;

		}

		public function getScreenList():Vector.<Object> {

			return screenList;

		}

		private function parseMediator(screenName:String):Boolean {

			return true;

		}

		/**
		 *
		 * Get ScreenManager instance.
		 * @return Instance ScreenManager.
		 *
		 */
		public static function get screenManagerObj():ScreenManager {

			if (screenManager == null)
				screenManager = new ScreenManager(new BlockScreenManager());

			return screenManager;

		}



	}
}

/**
 * @author mini
 * 'ScreenManager' is not possible to create an instance.
 *
 */
class BlockScreenManager {
}
