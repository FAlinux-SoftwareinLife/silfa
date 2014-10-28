package screen.button.auth {
	
	import flash.display.MovieClip;
	
	import abstracts.ButtonAbstract;
	
	import controller.web.WebController;
	
	import identifier.ButtonName;
	import identifier.ControllerName;
	
	import manager.controller.ControllerManager;

	public class RPDriveCalendarButton extends ButtonAbstract {
		
		public function RPDriveCalendarButton(name:String, button:MovieClip) {
			super(name, button);			
		}
		
		override protected function mouseDownHandler():void {
			
			webControllerObj.setExecute(ButtonName.RP_DRIVE_CALENDAR);
			
		}
		
		private function get webControllerObj():WebController {
			
			return ControllerManager.controllerManagerObj.getController(ControllerName.WEB) as WebController;
			
		}
		
		
		
	}
}
