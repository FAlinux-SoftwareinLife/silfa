package screen.button.arm {	
	
	import abstracts.ButtonAbstract;
	
	import controller.arm.ArmController;
	
	import identifier.ButtonName;
	import identifier.ControllerName;
	
	import manager.controller.ControllerManager;

	public class ProfileInfoButton extends ButtonAbstract {
		
		private const BUTTON_NAME:String = ButtonName.PROFILE_INFO;
		
		public function ProfileInfoButton() {
			
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
