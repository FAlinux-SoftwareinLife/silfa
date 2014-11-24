package screen.web {

	import abstracts.WebViewAbstract;

	import frame.ScreenFrame;

	import identifier.ScreenName;

	import manager.screen.IScreen;

	import screen.web.view.DriveCalendarView;
	import screen.web.view.GmailView;
	import screen.web.view.LoginView;
	import screen.web.view.LogoutView;

	/**
	 * Shows the Web page. Activate the 'StageWebView'.
	 *
	 */
	public class WebMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = ScreenName.WEB;

		private const WEB_VIEW_LIST:Vector.<WebViewAbstract> = Vector.<WebViewAbstract>([

			new LoginView, new LogoutView, new GmailView, new DriveCalendarView

			]);

		public function WebMediator() {

		}

		public function set view(obj:Object):void {

			for each (var _view:WebViewAbstract in WEB_VIEW_LIST)
				if (_view.name == obj.name)
					_view.onWebview(true, obj.url);

		}

		public function set openWebView(obj:Object):void {

			for each (var _view:WebViewAbstract in WEB_VIEW_LIST)
				if (_view.name == obj.name)
					_view.openWebView(obj.height);

		}

		public function set closeView(obj:Object):void {

			for each (var _view:WebViewAbstract in WEB_VIEW_LIST)
				if (_view.name == obj.name)
					_view.offWebview();

		}
		
		public function reset():void {
			
		}
		
		public function get name():String {
			return SCREEN_NAME;
		}


	}
}
