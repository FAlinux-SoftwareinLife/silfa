package controller.apps.command {
	import identifier.ApplicationName;
	import identifier.CommandName;
	import identifier.ScreenName;

	import manager.controller.ICommand;
	import manager.screen.ScreenManager;

	import screen.application.ApplicationMediator;

	public class DocCommand implements ICommand {

		private static const COMMAND_NAME:String = CommandName.DOC;

		public function DocCommand() {
		}

		public function get name():String {
			return COMMAND_NAME;
		}

		public function execute():void {

			applicationMediatorObj.setApp(ApplicationName.DOC);

		}

		private function get applicationMediatorObj():ApplicationMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.APPLICATION) as ApplicationMediator;

		}
	}
}
