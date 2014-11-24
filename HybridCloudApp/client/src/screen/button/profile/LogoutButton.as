package screen.button.profile {

	import abstracts.ButtonAbstract;

	import controller.web.WebController;

	import identifier.ButtonName;
	import identifier.ControllerName;

	import manager.controller.ControllerManager;

	public class LogoutButton extends ButtonAbstract {

		private const BUTTON_NAME:String = ButtonName.LOGOUT;

		public function LogoutButton() {

			super(BUTTON_NAME);

		}

		override protected function mouseDownHandler():void {

			var _executeObj:Object = {type: name};

			webControllerObj.setExecute(_executeObj);

		}

		private function get webControllerObj():WebController {

			return ControllerManager.controllerManagerObj.getController(ControllerName.WEB) as WebController;

		}


	}
}
