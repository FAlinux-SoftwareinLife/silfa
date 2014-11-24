package controller.web.command {

	import abstracts.CommandAbstract;
	
	import events.WebviewEvent;
	
	import frame.ScreenFrame;
	
	import identifier.ButtonName;
	import identifier.CommandName;
	import identifier.DataName;
	import identifier.EndPointName;
	import identifier.ProxyName;
	import identifier.ScreenName;
	import identifier.ViewName;
	
	import info.GoogleHTTPRequestInfo;
	
	import manager.controller.ICommand;
	import manager.model.ModelManager;
	import manager.screen.ScreenManager;
	
	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.OAuthInfoData;
	
	import screen.application.ApplicationMediator;
	import screen.button.ButtonMediator;
	import screen.button.auth.LoginButton;
	import screen.loading.LoadingMediator;
	import screen.log.LogMediator;
	import screen.web.WebMediator;
	
	import utils.WebviewNotification;

	public class WebLogoutCommand extends CommandAbstract implements ICommand {

		private static const COMMAND_NAME:String = CommandName.WEB_LOGOUT;

		public function WebLogoutCommand() {

			super();

		}

		public function get name():String {

			return COMMAND_NAME;

		}

		public function execute(obj:Object = null):void {
			
			if (oauthInfoDataObj.getState()) {

				loadingMediatorObj.openLoading();

				webMediatorObj.view = {name: ViewName.LOGOUT, url: GoogleHTTPRequestInfo.GOOGLE_LOGOUT_URL};

				webNotiUtilObj.addEventListener(WebviewEvent.END_POINT_COMPLETE, endPointComplete);
				webNotiUtilObj.arriveOfAddress(ScreenFrame.webview, EndPointName.LOGOUT_END_POINT);

			}

			// tracking
			logMediatorObj.log("Request logout");

		}

		private function endPointComplete(evt:WebviewEvent):void {

			webNotiUtilObj.removeEventListener(WebviewEvent.END_POINT_COMPLETE, endPointComplete);

			loginButtonObj.enableButton();

			loadingMediatorObj.closeLoading();

			//google info reset
			oauthInfoDataObj.reset();
			applicationMediatorObj.exitAll();
			
			// tracking
			logMediatorObj.log("Logout complete");
			
		}

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

		private function get oauthInfoDataObj():OAuthInfoData {

			return googleInfoProxyObj.getData(DataName.OAUTH_INFO) as OAuthInfoData;

		}

		private function get webMediatorObj():WebMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.WEB) as WebMediator;

		}

		private function get webNotiUtilObj():WebviewNotification {

			return WebviewNotification.webviewNotificationObj as WebviewNotification;

		}

		private function get buttonMediatorObj():ButtonMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.BUTTON) as ButtonMediator;

		}

		private function get loginButtonObj():LoginButton {

			return buttonMediatorObj.getButton(ButtonName.LOGIN) as LoginButton;

		}

		private function get loadingMediatorObj():LoadingMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOADING) as LoadingMediator;

		}

		private function get logMediatorObj():LogMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOG) as LogMediator;

		}

		private function get applicationMediatorObj():ApplicationMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.APPLICATION) as ApplicationMediator;

		}

	}
}
