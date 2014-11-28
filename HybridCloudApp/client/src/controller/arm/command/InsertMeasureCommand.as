package controller.arm.command {
	import abstracts.CommandAbstract;
	import abstracts.MeasureAbstract;

	import controller.arm.ArmController;

	import events.ArmEvent;

	import identifier.ApplicationName;
	import identifier.CommandName;
	import identifier.ControllerName;
	import identifier.DataName;
	import identifier.ProxyName;
	import identifier.ScreenName;

	import manager.controller.ControllerManager;
	import manager.controller.ICommand;
	import manager.model.ModelManager;
	import manager.screen.ScreenManager;

	import model.db.arm.ArmServerProxy;
	import model.db.arm.data.InsertMeasureData;

	import screen.application.ApplicationMediator;
	import screen.application.measure.MeasureApplication;
	import screen.loading.LoadingMediator;

	import utils.Tracer;

	public class InsertMeasureCommand extends CommandAbstract implements ICommand {

		private static const COMMAND_NAME:String = CommandName.INSERT_MEASURE;

		public function InsertMeasureCommand() {

		}

		public function get name():String {

			return COMMAND_NAME;

		}

		public function execute(obj:Object = null):void {

			executeObj = obj;

			loadingMediatorObj.openLoading();

			var _dataObj:Object = {name: DataName.INSERT_MEASURE, data: executeObj};

			armServerProxyObj.addEventListener(ArmEvent.INSERT_MEASURE_COMPLETE, insertMeasureComplete);
			armServerProxyObj.setData(_dataObj);

		}

		private function insertMeasureComplete(evt:ArmEvent):void {

			loadingMediatorObj.closeLoading();

			measureApplicationObj.setResult(evt.param);

		}


		//===================== obj reference =====================

		private function get armServerProxyObj():ArmServerProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.ARM_SERVER) as ArmServerProxy;

		}

		private function get insertMeasureDataObj():InsertMeasureData {

			return armServerProxyObj.getData(DataName.INSERT_MEASURE) as InsertMeasureData;

		}

		private function get loadingMediatorObj():LoadingMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOADING) as LoadingMediator;

		}

		private function get applicationMediatorObj():ApplicationMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.APPLICATION) as ApplicationMediator;

		}

		private function get measureApplicationObj():MeasureApplication {

			return applicationMediatorObj.getApplication(ApplicationName.MEASURE) as MeasureApplication;

		}


	}
}
