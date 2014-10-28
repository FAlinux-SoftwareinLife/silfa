package screen.button.drive {
	
	import flash.display.MovieClip;
	
	import abstracts.ButtonAbstract;
	
	import controller.apps.AppsController;
	
	import identifier.ButtonName;
	import identifier.ControllerName;
	
	import manager.controller.ControllerManager;

	public class CreatePreButton extends ButtonAbstract {
		
		public function CreatePreButton(name:String, button:MovieClip) {
			
			super(name, button);
			
		}
		
		override protected function mouseDownHandler():void {
			
			appsControllerObj.setExecute(ButtonName.CREATE_PRE);
			
		}
		
		private function get appsControllerObj():AppsController {
			
			return ControllerManager.controllerManagerObj.getController(ControllerName.APPS) as AppsController;
			
		}

		
	}
}
