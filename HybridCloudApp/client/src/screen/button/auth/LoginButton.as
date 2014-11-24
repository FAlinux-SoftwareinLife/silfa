package screen.button.auth {

	import abstracts.ButtonAbstract;
	
	import controller.web.WebController;
	
	import identifier.ButtonName;
	import identifier.ControllerName;
	
	import manager.controller.ControllerManager;

	public class LoginButton extends ButtonAbstract {
		
		private const BUTTON_NAME:String = ButtonName.LOGIN;

		public function LoginButton() {
			
			super(BUTTON_NAME);
			
		}

		override protected function mouseDownHandler():void {

			var _executeObj:Object = {type: name};

			webControllerObj.setExecute(_executeObj);

		}

		private function get webControllerObj():WebController {

			return ControllerManager.controllerManagerObj.getController(ControllerName.WEB) as WebController;

		}
		

	}
}
