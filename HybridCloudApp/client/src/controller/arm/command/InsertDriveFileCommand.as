package controller.arm.command {

	import abstracts.CommandAbstract;
	
	import controller.arm.ArmController;
	
	import events.ArmEvent;
	
	import identifier.ApplicationName;
	import identifier.CommandName;
	import identifier.ControllerName;
	import identifier.DataName;
	import identifier.GuideName;
	import identifier.ProxyName;
	import identifier.ScreenName;
	
	import manager.controller.ControllerManager;
	import manager.controller.ICommand;
	import manager.model.ModelManager;
	import manager.screen.ScreenManager;
	
	import model.db.arm.ArmServerProxy;
	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.DriveListInfoData;
	
	import screen.application.ApplicationMediator;
	import screen.loading.LoadingMediator;
	import screen.log.LogMediator;

	public class InsertDriveFileCommand extends CommandAbstract implements ICommand {

		private static const COMMAND_NAME:String = CommandName.INSERT_DRIVE_FILE;

		public function InsertDriveFileCommand() {
		}

		public function get name():String {

			return COMMAND_NAME;

		}

		public function execute(obj:Object = null):void {
			
			// tracking
			logMediatorObj.log("Request insert data in arm server /  google drive file info");

			loadingMediatorObj.openLoading();

			checkRequirement(COMMAND_NAME);

		}

		override protected function requestExecute(executeOpen:Boolean):void {

			if (executeOpen) {

				armProxyObj.addEventListener(ArmEvent.INSERT_DRIVE_FILE_COMPLETE, insertDriveFileComplete);
				armProxyObj.requestData(DataName.INSERT_DRIVE_FILE);

			} else {

				var _selGuide:String;

				if (driveListInfoDataObj.getFileList().length <= 0)
					_selGuide = GuideName.FILE;

				if (applicationMediatorObj.currentApp !== ApplicationName.DRIVE)
					_selGuide = GuideName.LIST;

				setGuide(_selGuide);

			}

		}

		override protected function setGuide(guideType:String):void {

			super.setGuide(guideType);

			loadingMediatorObj.closeLoading();

		}

		private function insertDriveFileComplete(evt:ArmEvent):void {
			
			// tracking
			logMediatorObj.log("Complete insert data");
			
			armProxyObj.removeEventListener(ArmEvent.INSERT_DRIVE_FILE_COMPLETE, insertDriveFileComplete);

			loadingMediatorObj.closeLoading();

			var _executeObj:Object = {type: CommandName.REQUEST_DRIVE_FILE};

			armControllerObj.setExecute(_executeObj);

		}

		// ------------------------ get obj ------------------------


		private function get applicationMediatorObj():ApplicationMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.APPLICATION) as ApplicationMediator;

		}

		private function get loadingMediatorObj():LoadingMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOADING) as LoadingMediator;

		}

		private function get armProxyObj():ArmServerProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.ARM_SERVER) as ArmServerProxy;

		}

		private function get armControllerObj():ArmController {

			return ControllerManager.controllerManagerObj.getController(ControllerName.ARM) as ArmController;

		}

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

		private function get driveListInfoDataObj():DriveListInfoData {

			return googleInfoProxyObj.getData(DataName.DRIVE_LIST_INFO) as DriveListInfoData;

		}
		
		private function get logMediatorObj():LogMediator {
			
			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOG) as LogMediator;
			
		}


	}
}
