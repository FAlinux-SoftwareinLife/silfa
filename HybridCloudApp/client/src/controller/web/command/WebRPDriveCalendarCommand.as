package controller.web.command {

	import abstracts.CommandAbstract;

	import events.OAuthEvent;
	import events.WebviewEvent;

	import frame.ScreenFrame;

	import identifier.CommandName;
	import identifier.DataName;
	import identifier.EndPointName;
	import identifier.LoadingName;
	import identifier.ProxyName;
	import identifier.ScreenName;
	import identifier.ViewName;

	import info.WebViewInfo;

	import manager.controller.ICommand;
	import manager.model.ModelManager;
	import manager.screen.ScreenManager;

	import model.google.info.GoogleInfoProxy;
	import model.google.oauth.GoogleOAuthProxy;

	import screen.guide.GuideMediator;
	import screen.loading.LoadingMediator;
	import screen.loading.block.BlockLoading;
	import screen.loading.circle.CircleLoading;
	import screen.log.LogMediator;
	import screen.web.WebMediator;

	import utils.WebviewNotification;

	public class WebRPDriveCalendarCommand extends CommandAbstract implements ICommand {

		private const COMMAND_NAME:String = CommandName.WEB_RP_DRIVE_CALENDAR;

		public function WebRPDriveCalendarCommand() {

		}

		public function get name():String {

			return COMMAND_NAME;

		}

		public function execute(obj:Object = null):void {
			
			// tracking
			logMediatorObj.log("Request for drive, calendar permission");
			
			executeObj = obj;

			loadingMediatorObj.openLoading();

			checkRequirement(COMMAND_NAME);
		}

		override protected function setGuide(guideType:String):void {

			super.setGuide(guideType);

			loadingMediatorObj.closeLoading();

		}

		override protected function requestExecute(executeOpen:Boolean):void {

			if (executeOpen) {

				googleOAuthProxyObj.addEventListener(OAuthEvent.REQUEST_DRIVE_CALENDAR_COMPLETE, requestDriveCalendarComplete);
				googleOAuthProxyObj.requestData(DataName.PERMISSION_DRIVE_CALENDAR);

				// tracking
				logMediatorObj.log("Request for drive, calendar permission");

			} else {

				loadingMediatorObj.closeLoading();

				// tracking
				logMediatorObj.log("You have a already permission");

			}

		}

		private function requestDriveCalendarComplete(evt:OAuthEvent):void {

			googleOAuthProxyObj.removeEventListener(OAuthEvent.REQUEST_DRIVE_CALENDAR_COMPLETE, requestDriveCalendarComplete);

			webNotiUtilObj.addEventListener(WebviewEvent.FIRST_POINT_COMPLETE, firstPointComplete);
			webNotiUtilObj.firstOfAddress(ScreenFrame.webview);

			webMediatorObj.view = {name: ViewName.DRIVE_CALENDAR, url: evt.param.data};

		}

		private function firstPointComplete(evt:WebviewEvent):void {

			webNotiUtilObj.removeEventListener(WebviewEvent.FIRST_POINT_COMPLETE, firstPointComplete);

			webMediatorObj.openWebView = {name: ViewName.DRIVE_CALENDAR, height: WebViewInfo.HEIGHT_DRIVE_CALENDAR};

			webNotiUtilObj.addEventListener(WebviewEvent.END_POINT_COMPLETE, endPointComplete);
			webNotiUtilObj.arriveOfAddress(ScreenFrame.webview, EndPointName.DRIVE_CALENDAR_END_POINT);

			circleLoadingObj.close();

		}

		private function endPointComplete(evt:WebviewEvent):void {

			webNotiUtilObj.removeEventListener(WebviewEvent.END_POINT_COMPLETE, endPointComplete);

			webMediatorObj.closeView = {name: ViewName.DRIVE_CALENDAR};

			var _dataObj:Object = {name: DataName.OAUTH_INFO, data: evt.param.query};
			googleInfoProxyObj.setData(_dataObj);

			blockLoadingObj.close();

			// tracking
			logMediatorObj.log("Request permission complete");

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

		private function get loadingMediatorObj():LoadingMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOADING) as LoadingMediator;

		}

		private function get circleLoadingObj():CircleLoading {

			return loadingMediatorObj.getLoading(LoadingName.CIRCLE) as CircleLoading;

		}

		private function get blockLoadingObj():BlockLoading {

			return loadingMediatorObj.getLoading(LoadingName.BLOCK) as BlockLoading;

		}

		private function get guideMediatorObj():GuideMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.GUIDE) as GuideMediator;

		}

		private function get logMediatorObj():LogMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOG) as LogMediator;

		}

	}
}
