package controller.arm.command {

	import controller.arm.ArmController;
	
	import events.ArmEvent;
	
	import identifier.CommandName;
	import identifier.ControllerName;
	import identifier.DataName;
	import identifier.ProxyName;
	
	import manager.controller.ControllerManager;
	import manager.controller.ICommand;
	import manager.model.ModelManager;
	
	import model.db.arm.ArmProxy;

	public class InsertProfileCommand implements ICommand {

		private static const COMMAND_NAME:String = CommandName.INSERT_PROFILE;

		public function InsertProfileCommand() {
		}

		public function get name():String {
			return COMMAND_NAME;
		}

		public function execute(obj:Object = null):void {

			armProxyObj.addEventListener(ArmEvent.INSERT_PROFILE_COMPLETE, insertProfileComplete);
			armProxyObj.requestData(DataName.INSERT_PROFILE);

		}

		private function insertProfileComplete(evt:ArmEvent):void {

			armProxyObj.removeEventListener(ArmEvent.INSERT_PROFILE_COMPLETE, insertProfileComplete);
			
			var _executeObj:Object = {type: CommandName.REQUEST_PROFILE};
			
			armControllerObj.setExecute(_executeObj);

		}

		private function get armProxyObj():ArmProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.ARM) as ArmProxy;

		}
		
		private function get armControllerObj():ArmController {
		
			return ControllerManager.controllerManagerObj.getController(ControllerName.ARM) as ArmController;
		
		}

	}
}
