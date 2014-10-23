package screen.button.drive {
	
	import flash.display.MovieClip;
	
	import abstracts.ButtonAbstract;
	
	import controller.apps.AppsController;
	
	import identifier.ButtonName;
	import identifier.ControllerName;
	
	import manager.controller.ControllerManager;

	public class CreateDocButton extends ButtonAbstract {
		
		public function CreateDocButton(name:String, button:MovieClip) {
			
			super(name, button);
			
		}
		
		override protected function mouseDownHandler():void {
			
			appsControllerObj.setExecute(ButtonName.CREATE_DOC);
			
		}
		
		private function get appsControllerObj():AppsController {
			
			return ControllerManager.controllerManagerObj.getController(ControllerName.APPS) as AppsController;
			
		}

		
	}
}
