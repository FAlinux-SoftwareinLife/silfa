package screen.log.top.log {

	import abstracts.SendLogAbstract;

	import identifier.IssueName;
	import identifier.TopLogName;

	public class WebTopLog extends SendLogAbstract {

		private const LOG_NAME:String = TopLogName.WEB;

		public function WebTopLog() {

			_logName = LOG_NAME;

			sendLogList = Vector.<Object>([

				{name: IssueName.START_WEBVIEW_LOGIN, message:"start google login"},
				
				{name: IssueName.REQUEST_LOGIN, message: "request login"},
				
				{name: IssueName.REQUEST_LOGIN_COMPLETE, message: "request login complete"},

				{name: IssueName.OPEN_WEB_VIEW, message: "open the webview"},

				{name: IssueName.START_END_POINT, message: "start endpoint notification"},

				{name: IssueName.COMPLETE_END_POINT, message: "complete endpoint notification"},
				
				{name: IssueName.SAVE_OAUTH_INFO, message: "save oauth information in application"},
				
				{name: IssueName.LOGIN_COMPLETE, message: "google login complete"}

				]);

		}

	}
}
