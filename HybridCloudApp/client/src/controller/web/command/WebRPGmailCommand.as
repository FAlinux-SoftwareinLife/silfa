package controller.web.command {

	import events.OAuthEvent;
	import events.WebviewEvent;

	import frame.ScreenFrame;

	import identifier.CommandName;
	import identifier.DataName;
	import identifier.EndPointName;
	import identifier.ProxyName;
	import identifier.ScreenName;
	import identifier.ViewName;

	import manager.controller.ICommand;
	import manager.model.ModelManager;
	import manager.screen.ScreenManager;

	import model.google.info.GoogleInfoProxy;
	import model.google.oauth.GoogleOAuthProxy;

	import screen.web.WebMediator;

	import utils.WebviewNotification;

	public class WebRPGmailCommand implements ICommand {

		private static const COMMAND_NAME:String = CommandName.WEB_RP_GMAIL;

		public function WebRPGmailCommand() {

			initAddEvent();

		}

		private function initAddEvent():void {

			googleOAuthProxyObj.addEventListener(OAuthEvent.REQUEST_GMAIL_COMPLETE, requestGmailComplete);

		}

		public function get name():String {
			
			return COMMAND_NAME;
			
		}

		public function execute(obj:Object = null):void {

			googleOAuthProxyObj.requestData(DataName.PERMISSION_GMAIL);

		}

		private function requestGmailComplete(evt:OAuthEvent):void {

			webMediatorObj.view = {name: ViewName.GMAIL, url: evt.param.data};

			webNotiUtilObj.addEventListener(WebviewEvent.END_POINT_COMPLETE, endPointComplete);
			webNotiUtilObj.arriveOfAddress(ScreenFrame.webview, EndPointName.GMAIL_END_POINT);

		}

		private function endPointComplete(evt:WebviewEvent):void {

			webNotiUtilObj.removeEventListener(WebviewEvent.END_POINT_COMPLETE, endPointComplete);

			var _dataObj:Object = {name: DataName.OAUTH_INFO, data: evt.param.query};

			googleInfoProxyObj.setData(_dataObj);

			webMediatorObj.closeView = {name: ViewName.GMAIL};

		}

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

	}
}
