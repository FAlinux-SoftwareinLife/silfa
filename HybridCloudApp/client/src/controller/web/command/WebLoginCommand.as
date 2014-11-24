package controller.web.command {

	import abstracts.CommandAbstract;

	import events.OAuthEvent;
	import events.WebviewEvent;

	import frame.ScreenFrame;

	import identifier.ButtonName;
	import identifier.CommandName;
	import identifier.DataName;
	import identifier.EndPointName;
	import identifier.IssueName;
	import identifier.LoadingName;
	import identifier.LogName;
	import identifier.ProxyName;
	import identifier.ScreenName;
	import identifier.TopLogName;
	import identifier.ViewName;

	import info.WebViewInfo;

	import manager.controller.ICommand;
	import manager.model.ModelManager;
	import manager.screen.ScreenManager;

	import model.google.info.GoogleInfoProxy;
	import model.google.oauth.GoogleOAuthProxy;

	import screen.button.ButtonMediator;
	import screen.button.auth.LoginButton;
	import screen.loading.LoadingMediator;
	import screen.loading.block.BlockLoading;
	import screen.loading.circle.CircleLoading;
	import screen.log.LogMediator;
	import screen.web.WebMediator;

	import utils.Tracer;
	import utils.WebviewNotification;

	public class WebLoginCommand extends CommandAbstract implements ICommand {

		private static const COMMAND_NAME:String = CommandName.WEB_LOGIN;

		public function WebLoginCommand() {

		}

		public function get name():String {

			return COMMAND_NAME;

		}

		public function execute(obj:Object = null):void {

			loadingMediatorObj.openLoading();

			googleOAuthProxyObj.addEventListener(OAuthEvent.REQUEST_LOGIN_COMPLETE, requestLoginComplete);
			googleOAuthProxyObj.requestData(DataName.GOOGLE_LOGIN);

			// tracking
			logMediatorObj.log("Request login");

		}

		private function requestLoginComplete(evt:OAuthEvent):void {


			googleOAuthProxyObj.removeEventListener(OAuthEvent.REQUEST_LOGIN_COMPLETE, requestLoginComplete);

			webNotiUtilObj.addEventListener(WebviewEvent.FIRST_POINT_COMPLETE, firstPointComplete);
			webNotiUtilObj.firstOfAddress(ScreenFrame.webview);

			webMediatorObj.view = {name: ViewName.LOGIN, url: evt.param.data};

		}

		private function firstPointComplete(evt:WebviewEvent):void {

			webNotiUtilObj.removeEventListener(WebviewEvent.FIRST_POINT_COMPLETE, firstPointComplete);

			webMediatorObj.openWebView = {name: ViewName.LOGIN, height: WebViewInfo.HEIGHT_LOGIN};

			webNotiUtilObj.addEventListener(WebviewEvent.END_POINT_COMPLETE, endPointComplete);
			webNotiUtilObj.arriveOfAddress(ScreenFrame.webview, EndPointName.LOGIN_END_POINT);

			circleLoadingObj.close();

		}

		private function endPointComplete(evt:WebviewEvent):void {

			webNotiUtilObj.removeEventListener(WebviewEvent.END_POINT_COMPLETE, endPointComplete);

			webMediatorObj.closeView = {name: ViewName.LOGIN};
			
			var _dataObj:Object = {name: DataName.OAUTH_INFO, data: evt.param.query};
			googleInfoProxyObj.addEventListener(OAuthEvent.SET_LOGIN_COMPLETE, setLoginComplete);
			googleInfoProxyObj.setData(_dataObj);
			
			// tracking
			logMediatorObj.log("Login complete");

		}

		private function setLoginComplete(evt:OAuthEvent):void {
			
			var _resultObj:Object = evt.param.data;

			if (_resultObj.takeToken)
				loginButtonObj.disableButton();

			blockLoadingObj.close();
			
		}


		// ------------------------ get obj ------------------------

		private function get googleOAuthProxyObj():GoogleOAuthProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_OAUTH) as GoogleOAuthProxy;

		}

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

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

		private function get circleLoadingObj():CircleLoading {

			return loadingMediatorObj.getLoading(LoadingName.CIRCLE) as CircleLoading;

		}

		private function get blockLoadingObj():BlockLoading {

			return loadingMediatorObj.getLoading(LoadingName.BLOCK) as BlockLoading;

		}

		private function get logMediatorObj():LogMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOG) as LogMediator;

		}

	}
}
