package screen.web {

	import identifier.ScreenName;

	import manager.screen.IScreen;

	import frame.ScreenFrame;
	import screen.web.view.DriveCalendarView;
	import screen.web.view.GmailView;
	import screen.web.view.LoginView;
	import abstracts.WebViewAbstract;

	/**
	 * Shows the Web page. Activate the 'StageWebView'.
	 *
	 */
	public class WebMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = ScreenName.WEB;

		private const WEB_VIEW_LIST:Vector.<WebViewAbstract> = Vector.<WebViewAbstract>([

			new LoginView(), new GmailView(), new DriveCalendarView()

			]);

		public function WebMediator() {

		}

		public function reset():void {

		}

		public function get name():String {
			return SCREEN_NAME;
		}

		public function set view(obj:Object):void {

			for each (var _view:WebViewAbstract in WEB_VIEW_LIST)
				if (_view.name == obj.name)
					_view.openWebView(obj.url);

		}

		public function set closeView(obj:Object):void {

			for each (var _view:WebViewAbstract in WEB_VIEW_LIST)
				if (_view.name == obj.name)
					_view.offWebview();

		}

	}
}
