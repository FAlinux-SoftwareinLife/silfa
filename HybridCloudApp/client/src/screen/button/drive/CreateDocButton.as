package screen.button.drive {
	
	import flash.display.MovieClip;
	
	import abstracts.ButtonAbstract;
	
	import controller.apps.AppsController;
	
	import identifier.ControllerName;
	import identifier.FileName;
	
	import manager.controller.ControllerManager;

	public class CreateDocButton extends ButtonAbstract {
		
		public function CreateDocButton(name:String, button:MovieClip) {
			
			super(name, button);
			
		}
		
		override protected function mouseDownHandler():void {
			
			var _executeObj:Object = {type: name, param:FileName.DOCUMENT};
			
			appsControllerObj.setExecute(_executeObj);			
			
		}
		
		private function get appsControllerObj():AppsController {
			
			return ControllerManager.controllerManagerObj.getController(ControllerName.APPS) as AppsController;
			
		}

		
	}
}
