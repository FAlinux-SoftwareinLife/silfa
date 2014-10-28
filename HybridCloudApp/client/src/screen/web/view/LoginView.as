package screen.web.view {

	import abstracts.WebViewAbstract;

	import identifier.ViewName;

	public class LoginView extends WebViewAbstract {

		private const VIEW_NAME:String = ViewName.LOGIN;

		public function LoginView() {

			super(VIEW_NAME);

		}

		override public function openWebView(src:String):void {

			//onWebview(true, "http://accounts.google.com/logout");
			onWebview(true, src);

		}

	}
}
