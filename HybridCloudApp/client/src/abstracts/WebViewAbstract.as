package abstracts {

	import com.gskinner.motion.GTween;
	import com.gskinner.motion.easing.Sine;

	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;

	import frame.ScreenFrame;

	public class WebViewAbstract {

		private var _name:String;

		private var viewPortRect:Rectangle;

		private const SWV_RATIO:Number = 0.12;
		private const SHAWDOW_RATIO:Number = 0.05;

		private var rectTween:GTween;
		private var shadowTween:GTween;

		public function WebViewAbstract(name:String) {

			this._name = name;

			viewPortRect = new Rectangle(0, 0, hcmStage.width, 0);

			rectTween = new GTween();
			shadowTween = new GTween();
		}

		public function onWebview(urlOpen:Boolean, source:String):void {

			webview[urlOpen ? "loadURL" : "loadString"](source);

		}

		public function openWebView(height:Number):void {

			viewPortRect.height = height;
			viewPortRect.y = -viewPortRect.height;

			webview.viewPort = viewPortRect;
			setShadow();

			setSWVRect(0, 1);

		}

		public function offWebview():void {

			setSWVRect(-viewPortRect.height, 0);

		}

		private function setSWVRect(swvTY:Number, shadowTA:Number):void {

			shadowTween.paused = true;
			shadowTween = new GTween(swvShadow, .6, {y: swvTY, alpha: shadowTA}, {ease: Sine.easeOut});

			rectTween.paused = true;
			rectTween = new GTween(viewPortRect, .6, {y: swvTY}, {ease: Sine.easeOut});
			rectTween.onChange = setSWV;

		}

		private function setSWV(tween:GTween):void {

			webview.viewPort = viewPortRect;

		}

		private function setShadow():void {

			swvShadow.x = viewPortRect.x;
			swvShadow.y = viewPortRect.y;
			swvShadow.width = viewPortRect.width;
			swvShadow.height = viewPortRect.height;

		}

		// ------------------------ get obj ------------------------

		protected function get hcmStage():HCMStage {

			return ScreenFrame.hcm_stage;

		}

		protected function get webview():StageWebView {

			return ScreenFrame.webview;

		}

		protected function get swvShadow():MovieClip {

			return hcmStage.swvShadow;

		}

		public function get name():String {

			return this._name;

		}

	}
}
