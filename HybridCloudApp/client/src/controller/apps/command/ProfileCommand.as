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

	import screen.application.ApplicationMediator;

	public class ProfileCommand implements ICommand {

		private static const COMMAND_NAME:String = CommandName.PROFILE;

		public function ProfileCommand() {

		}

		public function get name():String {

			return COMMAND_NAME;

		}

		public function execute(obj:Object = null):void {

			googleAppsProxyObj.addEventListener(AppsEvent.REQUEST_PROFILE_COMPLETE, requestProfileComplete);
			googleAppsProxyObj.requestData(DataName.PROFILE);

		}

		private function requestProfileComplete(evt:AppsEvent):void {

			googleAppsProxyObj.removeEventListener(AppsEvent.REQUEST_PROFILE_COMPLETE, requestProfileComplete);

			var _dataObj:Object = {name: DataName.PROFILE_INFO, data: evt.param.data};

			googleInfoProxyObj.setData(_dataObj);

			applicationMediatorObj.setApp(ApplicationName.PROFILE);

		}

		private function get googleAppsProxyObj():GoogleAppsProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_APPS) as GoogleAppsProxy;

		}

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

		private function get applicationMediatorObj():ApplicationMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.APPLICATION) as ApplicationMediator;

		}


	}
}
