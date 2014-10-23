package screen.button.auth {

	import flash.display.MovieClip;

	import abstracts.ButtonAbstract;

	import controller.apps.AppsController;

	import identifier.ButtonName;
	import identifier.ControllerName;

	import manager.controller.ControllerManager;

	public class GetUserProfileButton extends ButtonAbstract {

		public function GetUserProfileButton(name:String, button:MovieClip) {

			super(name, button);

		}

		override protected function mouseDownHandler():void {

			appsControllerObj.setExecute(ButtonName.GET_USER_PROFILE);

		}

		private function get appsControllerObj():AppsController {

			return ControllerManager.controllerManagerObj.getController(ControllerName.APPS) as AppsController;

		}

	}
}
