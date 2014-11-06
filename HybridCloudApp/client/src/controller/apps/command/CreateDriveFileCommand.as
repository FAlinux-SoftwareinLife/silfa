package controller.apps.command {

	import events.AppsEvent;
	
	import identifier.ApplicationName;
	import identifier.CommandName;
	import identifier.DataName;
	import identifier.FileName;
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
	
	import utils.Tracer;

	public class CreateDriveFileCommand implements ICommand {

		private static const COMMAND_NAME:String = CommandName.CREATE_DRIVE_FILE;

		public function CreateDriveFileCommand() {
		}

		public function get name():String {
			return COMMAND_NAME;
		}

		public function execute(obj:Object = null):void {

			switch (obj) {

				case FileName.DOCUMENT:

					googleAppsProxyObj.addEventListener(AppsEvent.CREATE_DOC_FILE, createDocFileComplete);
					googleAppsProxyObj.requestData(DataName.DOC_FILE);

					break;

				case FileName.SPREADSHEET:

					googleAppsProxyObj.addEventListener(AppsEvent.CREATE_SPR_FILE, createSprFileComplete);
					googleAppsProxyObj.requestData(DataName.SPR_FILE);

					break;

				case FileName.PRESENTATION:
					
					googleAppsProxyObj.addEventListener(AppsEvent.CREATE_PRE_FILE, createPreFileComplete);
					googleAppsProxyObj.requestData(DataName.PRE_FILE);

					break;

			}

		}

		private function createDocFileComplete(evt:AppsEvent):void {

			googleAppsProxyObj.removeEventListener(AppsEvent.CREATE_DOC_FILE, createDocFileComplete);

			var _data:Object = evt.param;

			driveListInfoDataObj.addFileData(_data);
			driveApplicationObj.addDriveFile([_data.id]);

		}
		
		private function createSprFileComplete(evt:AppsEvent):void {
			
			googleAppsProxyObj.removeEventListener(AppsEvent.CREATE_SPR_FILE, createSprFileComplete);
			
			var _data:Object = evt.param;
			
			driveListInfoDataObj.addFileData(_data);
			driveApplicationObj.addDriveFile([_data.id]);
			
		}
		
		private function createPreFileComplete(evt:AppsEvent):void {
			
			googleAppsProxyObj.removeEventListener(AppsEvent.CREATE_PRE_FILE, createPreFileComplete);
			
			var _data:Object = evt.param;
			
			driveListInfoDataObj.addFileData(_data);
			driveApplicationObj.addDriveFile([_data.id]);
			
		}
		
		private function get applicationMediatorObj():ApplicationMediator {
			
			return ScreenManager.screenManagerObj.getMediator(ScreenName.APPLICATION) as ApplicationMediator;
			
		}
		
		private function get driveApplicationObj():DriveApplication {
			
			return applicationMediatorObj.getApplication(ApplicationName.DRIVE) as DriveApplication;
			
		}
		
		private function get googleInfoProxyObj():GoogleInfoProxy {
			
			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;
			
		}

		private function get driveListInfoDataObj():DriveListInfoData {

			return googleInfoProxyObj.getData(DataName.DRIVE_LIST_INFO) as DriveListInfoData;

		}

		private function get googleAppsProxyObj():GoogleAppsProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_APPS) as GoogleAppsProxy;

		}

	}
}
