package controller.arm.command {

	import abstracts.CommandAbstract;

	import controller.arm.ArmController;

	import events.ArmEvent;

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

	import screen.loading.LoadingMediator;
	import screen.log.LogMediator;

	public class InsertProfileCommand extends CommandAbstract implements ICommand {

		private static const COMMAND_NAME:String = CommandName.INSERT_PROFILE;

		public function InsertProfileCommand() {
		}

		public function get name():String {
			return COMMAND_NAME;
		}

		public function execute(obj:Object = null):void {

			// tracking
			logMediatorObj.log("Request insert data in arm server /  profile info");

			loadingMediatorObj.openLoading();

			checkRequirement(COMMAND_NAME);

		}

		override protected function requestExecute(executeOpen:Boolean):void {

			if (executeOpen) {

				armProxyObj.addEventListener(ArmEvent.INSERT_PROFILE_COMPLETE, insertProfileComplete);
				armProxyObj.requestData(DataName.INSERT_PROFILE);

			} else {

				setGuide(GuideName.PROFILE);

			}

		}

		override protected function setGuide(guideType:String):void {

			super.setGuide(guideType);

			loadingMediatorObj.closeLoading();

		}

		private function insertProfileComplete(evt:ArmEvent):void {

			// tracking
			logMediatorObj.log("Complete insert data");

			armProxyObj.removeEventListener(ArmEvent.INSERT_PROFILE_COMPLETE, insertProfileComplete);

			loadingMediatorObj.closeLoading();

			var _executeObj:Object = {type: CommandName.REQUEST_PROFILE};

			armControllerObj.setExecute(_executeObj);

		}

		//===================== obj reference =====================

		private function get armProxyObj():ArmServerProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.ARM_SERVER) as ArmServerProxy;

		}

		private function get armControllerObj():ArmController {

			return ControllerManager.controllerManagerObj.getController(ControllerName.ARM) as ArmController;

		}

		private function get loadingMediatorObj():LoadingMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOADING) as LoadingMediator;

		}

		private function get logMediatorObj():LogMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOG) as LogMediator;

		}

	}
}
