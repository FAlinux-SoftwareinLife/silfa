package controller.arm.command {

	import abstracts.CommandAbstract;
	
	import events.ArmEvent;
	
	import identifier.CommandName;
	import identifier.DataName;
	import identifier.GuideName;
	import identifier.ProxyName;
	import identifier.ScreenName;
	import identifier.TableName;
	
	import manager.controller.ICommand;
	import manager.model.ModelManager;
	import manager.screen.ScreenManager;
	
	import model.db.arm.ArmServerProxy;
	import model.db.info.ArmInfoProxy;
	
	import screen.database.DatabaseMediator;
	import screen.loading.LoadingMediator;
	import screen.log.LogMediator;
	
	import utils.Tracer;

	public class RequestDriveFileCommand extends CommandAbstract implements ICommand {

		private static const COMMAND_NAME:String = CommandName.REQUEST_DRIVE_FILE;

		public function RequestDriveFileCommand() {
		}

		public function get name():String {
			return COMMAND_NAME;
		}

		public function execute(obj:Object = null):void {
			
			// tracking
			logMediatorObj.log("Request data for arm server /  google drive file info");
			
			loadingMediatorObj.openLoading();
			
			checkRequirement(COMMAND_NAME);

		}
		
		override protected function requestExecute(executeOpen:Boolean):void {
			
			if (executeOpen) {
				
				armProxyObj.addEventListener(ArmEvent.RECEIVE_DRIVE_FILE_COMPLETE, receiveDriveFileComplete);
				armProxyObj.requestData(DataName.RECEIVE_DRIVE_FILE);
				
			} else {
				
				setGuide(GuideName.LIST);
				
			}
			
		}
		
		override protected function setGuide(guideType:String):void {
			
			super.setGuide(guideType);
			
			loadingMediatorObj.closeLoading();
			
		}

		private function receiveDriveFileComplete(evt:ArmEvent):void {

			armProxyObj.removeEventListener(ArmEvent.RECEIVE_DRIVE_FILE_COMPLETE, receiveDriveFileComplete);
			
			loadingMediatorObj.closeLoading();

			var _dataObj:Object = {name: DataName.ARM_DRIVE_FILE_INFO, data: evt.param};

			infoProxyObj.setData(_dataObj);

			databaseMediatorObj.setTable(TableName.FILE);
			
			// tracking
			logMediatorObj.log("Complete receive data");
			logMediatorObj.log(Tracer.log(_dataObj.data));
			
		}

		//===================== obj reference =====================

		private function get armProxyObj():ArmServerProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.ARM_SERVER) as ArmServerProxy;

		}

		private function get infoProxyObj():ArmInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.ARM_INFO) as ArmInfoProxy;

		}

		private function get databaseMediatorObj():DatabaseMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.DATABASE) as DatabaseMediator;

		}
		
		private function get loadingMediatorObj():LoadingMediator {
			
			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOADING) as LoadingMediator;
			
		}
		
		private function get logMediatorObj():LogMediator {
			
			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOG) as LogMediator;
			
		}

	}
}
