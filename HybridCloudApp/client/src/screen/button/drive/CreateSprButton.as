package screen.button.drive {
	
	import abstracts.ButtonAbstract;
	
	import controller.apps.AppsController;
	
	import identifier.ButtonName;
	import identifier.ControllerName;
	import identifier.FileName;
	
	import manager.controller.ControllerManager;

	public class CreateSprButton extends ButtonAbstract {
		
		private const BUTTON_NAME:String = ButtonName.CREATE_SPR;
		
		public function CreateSprButton() {
			
			super(BUTTON_NAME);
			
		}
		
		override protected function mouseDownHandler():void {
			
			var _executeObj:Object = {type: name, param:FileName.SPREADSHEET};
			
			appsControllerObj.setExecute(_executeObj);
			
		}
		
		private function get appsControllerObj():AppsController {
			
			return ControllerManager.controllerManagerObj.getController(ControllerName.APPS) as AppsController;
			
		}

		
	}
}
