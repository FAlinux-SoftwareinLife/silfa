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
	import screen.database.tables.ProfileTable;
	
	public class RequestProfileCommand implements ICommand {

		private static const COMMAND_NAME:String = CommandName.REQUEST_PROFILE;

		public function RequestProfileCommand() {

		}

		public function get name():String {
			return COMMAND_NAME;
		}

		public function execute(obj:Object = null):void {

			armProxyObj.addEventListener(ArmEvent.RECEIVE_PROFILE_COMPLETE, receiveProfileComplete);
			armProxyObj.requestData(DataName.RECEIVE_PROFILE);

		}

		private function receiveProfileComplete(evt:ArmEvent):void {

			armProxyObj.removeEventListener(ArmEvent.RECEIVE_PROFILE_COMPLETE, receiveProfileComplete);

			var _dataObj:Object = {name:DataName.ARM_PROFILE_INFO, data:evt.param};
			
			infoProxyObj.setData(_dataObj);

			profileTableObj.updateField();

		}

		private function get armProxyObj():ArmProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.ARM) as ArmProxy;

		}

		private function get infoProxyObj():InfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.INFO) as InfoProxy;

		}

		private function get databaseMediatorObj():DatabaseMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.DATABASE) as DatabaseMediator;

		}

		private function get profileTableObj():ProfileTable {

			return databaseMediatorObj.getTable(TableName.PROFILE) as ProfileTable;

		}


	}
}
