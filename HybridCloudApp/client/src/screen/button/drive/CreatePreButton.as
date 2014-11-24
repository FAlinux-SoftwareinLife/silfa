package screen.button.drive {
	
	import abstracts.ButtonAbstract;
	
	import controller.apps.AppsController;
	
	import identifier.ButtonName;
	import identifier.ControllerName;
	import identifier.FileName;
	
	import manager.controller.ControllerManager;

	public class CreatePreButton extends ButtonAbstract {
		
		private const BUTTON_NAME:String = ButtonName.CREATE_PRE;

		public function CreatePreButton() {

			super(BUTTON_NAME);

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
