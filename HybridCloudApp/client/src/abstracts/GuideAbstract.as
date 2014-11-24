package abstracts {

	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;

	import flash.display.MovieClip;

	public class GuideAbstract {

		private var _name:String;
		private var _guideArea:MovieClip;

		public function GuideAbstract(name:String) {

			this._name = name;

		}

		public function init(guideArea:MovieClip):void {

			this._guideArea = guideArea;

		}

		public function get name():String {

			return _name;

		}

		protected function get guideArea():MovieClip {

			return _guideArea;

		}

		public function openGuide():void {
			
			TweenMax.to(_guideArea, 0.6, {autoAlpha: 1, yoyo: true, repeat: 1, repeatDelay: 0, ease: Sine.easeOut});

		}

	}
}
