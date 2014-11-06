package screen.button.arm {

	import flash.display.MovieClip;
	
	import abstracts.ButtonAbstract;
	
	import controller.arm.ArmController;
	
	import identifier.ControllerName;
	
	import manager.controller.ControllerManager;

	public class DriveFileInfoButton extends ButtonAbstract {

		public function DriveFileInfoButton(name:String, button:MovieClip) {
			
			super(name, button);
			
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
