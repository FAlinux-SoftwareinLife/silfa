package screen.button.drive {

	import flash.display.MovieClip;

	import abstracts.ButtonAbstract;

	import controller.apps.AppsController;

	import identifier.ControllerName;
	import identifier.FileName;

	import manager.controller.ControllerManager;

	public class CreatePreButton extends ButtonAbstract {

		public function CreatePreButton(name:String, button:MovieClip) {

			super(name, button);

		}

		override protected function mouseDownHandler():void {

			var _executeObj:Object = {type: name, param: FileName.PRESENTATION};

			appsControllerObj.setExecute(_executeObj);

		}

		private function get appsControllerObj():AppsController {

			return ControllerManager.controllerManagerObj.getController(ControllerName.APPS) as AppsController;

		}


	}
}
