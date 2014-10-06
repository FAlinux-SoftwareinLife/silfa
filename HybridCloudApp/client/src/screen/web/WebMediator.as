package screen.web {

	import flash.events.Event;
	import flash.media.StageWebView;

	import manager.screen.IScreen;

	import screen.ScreenFrame;

	public class WebMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = "web";

		private var sw:StageWebView

		public function WebMediator() {

			init();

		}

		private function init():void {

		}

		public function reset():void {
		}

		public function get name():String {
			return SCREEN_NAME;
		}

		public function setWebView(urlOpen:Boolean, source:String):void {

			sw = webview as StageWebView;

			sw.addEventListener(Event.COMPLETE, loadCompleteHandler);

			sw[urlOpen ? "loadURL" : "loadString"](source);

		}

		private function loadCompleteHandler(evt:Event):void {



		}

	}
}
