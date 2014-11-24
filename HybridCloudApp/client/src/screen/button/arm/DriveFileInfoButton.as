package screen.button.arm {
	
	import abstracts.ButtonAbstract;
	
	import controller.arm.ArmController;
	
	import identifier.ButtonName;
	import identifier.ControllerName;
	
	import manager.controller.ControllerManager;

	public class DriveFileInfoButton extends ButtonAbstract {

		private const BUTTON_NAME:String = ButtonName.DRIVE_FILE_INFO;
		
		public function DriveFileInfoButton() {
			
			super(BUTTON_NAME);
			
		}

		override protected function mouseDownHandler():void {
			
			var _executeObj:Object = {type: name};
			
			armControllerObj.setExecute(_executeObj);
			
		}
		
		private function get armControllerObj():ArmController {
			
			return ControllerManager.controllerManagerObj.getController(ControllerName.ARM) as ArmController;
			
		}


	}
}
