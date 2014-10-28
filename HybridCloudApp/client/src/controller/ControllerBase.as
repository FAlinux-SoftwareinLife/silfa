package controller {

	import controller.apps.AppsController;
	import controller.web.WebController;
	
	import manager.controller.ControllerManager;
	import manager.controller.IController;

	public class ControllerBase {
		
		private const CONTROLLER_LIST:Vector.<IController> = Vector.<IController>([
		
			new AppsController, new WebController
		
		]);
		
		public function ControllerBase() {
			
			initController();	
			
		}
		
		private function initController():void {
			
			for each(var _controller:IController in CONTROLLER_LIST)
				ControllerManager.controllerManagerObj.addController(_controller);
			
		}
		
	}
}
