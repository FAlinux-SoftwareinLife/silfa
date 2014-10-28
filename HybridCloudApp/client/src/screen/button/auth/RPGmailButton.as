package screen.button.auth {

	import flash.display.MovieClip;

	import abstracts.ButtonAbstract;

	import controller.web.WebController;

	import identifier.ButtonName;
	import identifier.ControllerName;

	import manager.controller.ControllerManager;

	public class RPGmailButton extends ButtonAbstract {

		public function RPGmailButton(name:String, button:MovieClip) {

			super(name, button);

		}

		override protected function mouseDownHandler():void {

			webControllerObj.setExecute(ButtonName.RP_GMAIL);

		}

		private function get webControllerObj():WebController {

			return ControllerManager.controllerManagerObj.getController(ControllerName.WEB) as WebController;

		}

	}
}
