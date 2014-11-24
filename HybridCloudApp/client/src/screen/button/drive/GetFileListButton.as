package screen.button.drive {
	
	import abstracts.ButtonAbstract;
	
	import controller.apps.AppsController;
	
	import identifier.ButtonName;
	import identifier.ControllerName;
	
	import manager.controller.ControllerManager;

	public class GetFileListButton extends ButtonAbstract {
		
		private const BUTTON_NAME:String = ButtonName.GET_FILE_LIST;
		
		public function GetFileListButton() {
			
			super(BUTTON_NAME);
			
		}

		override protected function mouseDownHandler():void {
			
			var _executeObj:Object = {type: name};

			appsControllerObj.setExecute(_executeObj);

		}

		private function get appsControllerObj():AppsController {

			return ControllerManager.controllerManagerObj.getController(ControllerName.APPS) as AppsController;

		}

	}
}
