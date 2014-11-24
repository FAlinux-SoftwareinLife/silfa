package controller.apps.command {

	import abstracts.CommandAbstract;

	import events.AppsEvent;

	import identifier.ApplicationName;
	import identifier.CommandName;
	import identifier.DataName;
	import identifier.GuideName;
	import identifier.ProxyName;
	import identifier.ScreenName;

	import manager.controller.ICommand;
	import manager.model.ModelManager;
	import manager.screen.ScreenManager;

	import model.google.apps.GoogleAppsProxy;
	import model.google.info.GoogleInfoProxy;

	import screen.application.ApplicationMediator;
	import screen.loading.LoadingMediator;
	import screen.log.LogMediator;

	import utils.Tracer;

	public class DriveListCommand extends CommandAbstract implements ICommand {

		private static const COMMAND_NAME:String = CommandName.DRIVE_LIST;

		public function DriveListCommand() {

		}

		public function get name():String {

			return COMMAND_NAME;

		}

		public function execute(obj:Object = null):void {

			// tracking
			logMediatorObj.log("Request for drive file list");

			loadingMediatorObj.openLoading();

			checkRequirement(COMMAND_NAME);

		}

		override protected function requestExecute(executeOpen:Boolean):void {

			if (executeOpen) {

				googleAppsProxyObj.addEventListener(AppsEvent.REQUEST_DRIVE_LIST_COMPLETE, requestDriveListComplete);
				googleAppsProxyObj.requestData(DataName.DRIVE_LIST);

			} else {

				setGuide(GuideName.DRIVE);

			}

		}

		override protected function setGuide(guideType:String):void {

			super.setGuide(guideType);

			loadingMediatorObj.closeLoading();

		}

		private function requestDriveListComplete(evt:AppsEvent):void {

			googleAppsProxyObj.removeEventListener(AppsEvent.REQUEST_DRIVE_LIST_COMPLETE, requestDriveListComplete);

			loadingMediatorObj.closeLoading();

			var _dataObj:Object = {name: DataName.DRIVE_LIST_INFO, data: evt.param.data};
			googleInfoProxyObj.setData(_dataObj);

			applicationMediatorObj.setApp(ApplicationName.DRIVE);

			// tracking
			logMediatorObj.log("Drive file list");
			logMediatorObj.log(Tracer.log(_dataObj.data));

		}


		// ------------------------ get obj ------------------------

		private function get googleAppsProxyObj():GoogleAppsProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_APPS) as GoogleAppsProxy;

		}

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

		private function get applicationMediatorObj():ApplicationMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.APPLICATION) as ApplicationMediator;

		}

		private function get loadingMediatorObj():LoadingMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOADING) as LoadingMediator;

		}

		private function get logMediatorObj():LogMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOG) as LogMediator;

		}


	}
}
