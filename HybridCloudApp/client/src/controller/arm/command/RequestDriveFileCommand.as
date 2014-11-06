package controller.arm.command {

	import events.ArmEvent;

	import identifier.CommandName;
	import identifier.DataName;
	import identifier.ProxyName;
	import identifier.ScreenName;
	import identifier.TableName;

	import manager.controller.ICommand;
	import manager.model.ModelManager;
	import manager.screen.ScreenManager;

	import model.db.arm.ArmProxy;
	import model.db.info.InfoProxy;

	import screen.database.DatabaseMediator;
	import screen.database.tables.FileTable;

	import utils.Tracer;

	public class RequestDriveFileCommand implements ICommand {

		private static const COMMAND_NAME:String = CommandName.REQUEST_DRIVE_FILE;

		public function RequestDriveFileCommand() {
		}

		public function get name():String {
			return COMMAND_NAME;
		}

		public function execute(obj:Object = null):void {

			armProxyObj.addEventListener(ArmEvent.RECEIVE_DRIVE_FILE_COMPLETE, receiveDriveFileComplete);
			armProxyObj.requestData(DataName.RECEIVE_DRIVE_FILE);

		}

		private function receiveDriveFileComplete(evt:ArmEvent):void {

			armProxyObj.removeEventListener(ArmEvent.RECEIVE_DRIVE_FILE_COMPLETE, receiveDriveFileComplete);

			var _dataObj:Object = {name: DataName.ARM_DRIVE_FILE_INFO, data: evt.param};
			
			infoProxyObj.setData(_dataObj);

			fileTableObj.updateField();

		}

		//===================== obj reference =====================

		private function get armProxyObj():ArmProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.ARM) as ArmProxy;

		}

		private function get infoProxyObj():InfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.INFO) as InfoProxy;

		}

		private function get databaseMediatorObj():DatabaseMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.DATABASE) as DatabaseMediator;

		}

		private function get fileTableObj():FileTable {

			return databaseMediatorObj.getTable(TableName.FILE) as FileTable;

		}


	}
}
