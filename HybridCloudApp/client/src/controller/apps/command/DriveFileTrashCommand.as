package controller.apps.command {

	import events.AppsEvent;

	import identifier.ApplicationName;
	import identifier.CommandName;
	import identifier.DataName;
	import identifier.ProxyName;
	import identifier.ScreenName;

	import manager.controller.ICommand;
	import manager.model.ModelManager;
	import manager.screen.ScreenManager;

	import model.google.apps.GoogleAppsProxy;
	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.DriveListInfoData;

	import screen.application.ApplicationMediator;
	import screen.application.drive.DriveApplication;

	public class DriveFileTrashCommand implements ICommand {

		private static const COMMAND_NAME:String = CommandName.DRIVE_FILE_TRASH;

		public function DriveFileTrashCommand() {

		}

		public function get name():String {
			return COMMAND_NAME;
		}

		public function execute(obj:Object = null):void {

			googleAppsProxyObj.addEventListener(AppsEvent.DRIVE_FILE_TRASH_COMPLETE, driveFileTrashComplete);

			var _dataObj:Object = {name: DataName.DRIVE_FILE_TRASH, data: obj};

			googleAppsProxyObj.setData(_dataObj);

		}

		private function driveFileTrashComplete(evt:AppsEvent):void {

			googleAppsProxyObj.removeEventListener(AppsEvent.DRIVE_FILE_TRASH_COMPLETE, driveFileTrashComplete);

			var _deleteFileId:String = evt.param.id;

			driveListInfoDataObj.removeFileData(_deleteFileId);
			driveApplicationObj.removeDriveFile([_deleteFileId]);

		}

		private function get googleAppsProxyObj():GoogleAppsProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_APPS) as GoogleAppsProxy;

		}

		private function get googleInfoProxy():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

		private function get driveListInfoDataObj():DriveListInfoData {

			return googleInfoProxy.getData(DataName.DRIVE_LIST_INFO) as DriveListInfoData;

		}


		private function get applicationMediatorObj():ApplicationMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.APPLICATION) as ApplicationMediator;

		}

		private function get driveApplicationObj():DriveApplication {

			return applicationMediatorObj.getApplication(ApplicationName.DRIVE) as DriveApplication;

		}



	}
}
