package screen.loading.circle {

	import com.greensock.TweenNano;
	import com.greensock.easing.Back;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Mouse;

	import abstracts.LoadingAbstract;

	import identifier.LoadingName;

	public class CircleLoading extends LoadingAbstract {

		public const LOADING_NAME:String = LoadingName.CIRCLE;

		private const LOADAREA_SCALE_DURATION:Number = 1;
		private const LOADAREA_RATIO:Number = 0.2;

		public function CircleLoading() {

			super(LOADING_NAME);

		}

		override public function init(loadArea:MovieClip):void {

			super.loadArea = loadArea;
			super.loadArea.scaleX = super.loadArea.scaleY = 0;

		}

		override public function open(areaSA:Number = 1):void {

			Mouse.hide();

			loadArea.x = loadArea.stage.mouseX;
			loadArea.y = loadArea.stage.mouseY;

			loadArea.visible = true;

			setScale(areaSA);

			loadArea.addEventListener(Event.ENTER_FRAME, loadAreaEnterHandler);

		}

		override public function close():void {

			setScale(0, false);

		}

		private function loadAreaEnterHandler(evt:Event):void {

			loadAreaCursor();

		}

		private function setScale(targetS:Number, isClose:Boolean = true):void {

			TweenNano.killTweensOf(loadArea);

			TweenNano.to(loadArea, LOADAREA_SCALE_DURATION, {

					scaleX: targetS,

					scaleY: targetS,

					delay: .2,

					ease: isClose ? Back.easeOut : Back.easeIn,

					onComplete: isClose ? null : closeComplete

				});

		}

		private function closeComplete():void {

			loadArea.removeEventListener(Event.ENTER_FRAME, loadAreaEnterHandler);

			loadArea.visible = false;

			Mouse.show();

		}

		private function loadAreaCursor():void {

			loadArea.x += (loadArea.stage.mouseX - loadArea.x) * LOADAREA_RATIO;
			loadArea.y += (loadArea.stage.mouseY - loadArea.y) * LOADAREA_RATIO;

		}

	}
}
