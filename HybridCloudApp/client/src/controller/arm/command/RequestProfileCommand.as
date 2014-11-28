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

	public class RequestProfileCommand extends CommandAbstract implements ICommand {

		private static const COMMAND_NAME:String = CommandName.REQUEST_PROFILE;

		public function RequestProfileCommand() {

		}

		public function get name():String {
			return COMMAND_NAME;
		}

		public function execute(obj:Object = null):void {

			// tracking
			logMediatorObj.log("Request data for arm server /  profile info");

			loadingMediatorObj.openLoading();

			checkRequirement(COMMAND_NAME);
			
		}

		override protected function requestExecute(executeOpen:Boolean):void {

			if (executeOpen) {

				armProxyObj.addEventListener(ArmEvent.RECEIVE_PROFILE_COMPLETE, receiveProfileComplete);
				armProxyObj.requestData(DataName.RECEIVE_PROFILE);

			} else {

				setGuide(GuideName.PROFILE);

			}

		}

		override protected function setGuide(guideType:String):void {

			super.setGuide(guideType);

			loadingMediatorObj.closeLoading();

		}

		private function receiveProfileComplete(evt:ArmEvent):void {
			
			checkInsertComplete(evt.param);

		}
		
		private function checkInsertComplete(resultObj:Object):void {
			
			var _resultNum:int = int(resultObj);
			
			switch (_resultNum) {
				
				case 2032:
					
					failureInsert();
					
					break;
				
				default:
					
					successInsert(resultObj);
					
			}
			
		}
		
		private function successInsert(dataObj:Object):void {
			
			armProxyObj.removeEventListener(ArmEvent.RECEIVE_PROFILE_COMPLETE, receiveProfileComplete);
			
			loadingMediatorObj.closeLoading();
			
			var _dataObj:Object = {name: DataName.ARM_PROFILE_INFO, data: dataObj};
			
			infoProxyObj.setData(_dataObj);
			
			databaseMediatorObj.setTable(TableName.PROFILE);
			
			// tracking
			logMediatorObj.log("Complete receive data");
			logMediatorObj.log(Tracer.log(_dataObj.data));
			
		}
		
		private function failureInsert():void {
			
			// tracking
			logMediatorObj.log("Failure - Check the Arm Server");
			
			loadingMediatorObj.closeLoading();
			
		}


		// ------------------------ get obj ------------------------

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
