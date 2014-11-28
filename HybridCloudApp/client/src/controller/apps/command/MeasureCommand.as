package controller.apps.command {

	import abstracts.CommandAbstract;

	import events.AppsEvent;

	import identifier.ApplicationName;
	import identifier.CommandName;
	import identifier.DataName;
	import identifier.ScreenName;

	import manager.controller.ICommand;
	import manager.screen.ScreenManager;

	import screen.application.ApplicationMediator;
	import screen.loading.LoadingMediator;

	public class MeasureCommand extends CommandAbstract implements ICommand {

		private static const COMMAND_NAME:String = CommandName.MEASURE;

		public function MeasureCommand() {

		}

		public function get name():String {
			return COMMAND_NAME;
		}

		public function execute(obj:Object = null):void {

			loadingMediatorObj.openLoading();
			requestExecute(true);

		}

		override protected function requestExecute(executeOpen:Boolean):void {

			applicationMediatorObj.setApp(ApplicationName.MEASURE);

			loadingMediatorObj.closeLoading();

		}


		// ------------------------ get obj ------------------------

		private function get loadingMediatorObj():LoadingMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOADING) as LoadingMediator;

		}

		private function get applicationMediatorObj():ApplicationMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.APPLICATION) as ApplicationMediator;

		}


	}
}
