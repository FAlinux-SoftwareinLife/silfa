package abstracts {

	import flash.media.StageWebView;

	import frame.ScreenFrame;

	public class WebViewAbstract {

		private var _name:String;

		public function WebViewAbstract(name:String) {
			this._name = name;
		}

		protected function initAddEvent():void {

		}

		protected function onWebview(urlOpen:Boolean, source:String):void {

			trace("web view url = " + source);

			webview[urlOpen ? "loadURL" : "loadString"](source);



		}

		public function openWebView(src:String):void {



		}

		public function offWebview():void {

			ScreenFrame.removeWebview();

		}

		protected function get webview():StageWebView {

			return ScreenFrame.webview;

		}

		public function get name():String {

			return this._name;

		}

	}
}
