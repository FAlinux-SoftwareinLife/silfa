package manager.controller {

	/**
	 *
	 * Controller manager.
	 *
	 */
	public class ControllerManager {

		private static var controllerManager:ControllerManager;

		private var controllerList:Vector.<Object>;

		public function ControllerManager(blockControllerManager:BlockControllerManager) {

			controllerList = new Vector.<Object>();

		}

		/**
		 * Add controller in 'controllerList' instance.
		 * @param controller Controller instance.
		 *
		 */
		public function addController(controller:IController):void {

			var _obj:Object = {name: controller.name, controller: controller};
			controllerList.push(_obj);

		}

		/**
		 * Remove controller in 'controllerList' instance.
		 * @param controller Controller instance;
		 * 
		 */
		public function removeController(controller:IController):void {

			var _list_num:int = controllerList.length;
			
			for (var i:uint = 0; i < _list_num; i++) {
				
				var _obj:Object = controllerList[i];
				
				if (controller == _obj.controller)
					controllerList.splice(i, 1);
				
			}

		}
		
		public function getControllerList():Vector.<Object> {
			
			return controllerList;
			
		}

		/**
		 * @param name
		 * @return Select controller.
		 *
		 */
		public function getController(name:String):IController {

			var _controller:IController;

			for each (var obj:Object in controllerList) {

				if (name == obj.name)
					_controller = obj.controller;
			}

			return _controller;

		}

		/**
		 * Get ControllerManager instance.
		 * @return Instance ControllerManager.
		 *
		 */
		public static function get controllerManagerObj():ControllerManager {

			if (controllerManager == null)
				controllerManager = new ControllerManager(new BlockControllerManager());

			return controllerManager;

		}

	}
}

/**
 *'ControllerManager' is not possible to create an instance.
 *
 */
class BlockControllerManager {
}
