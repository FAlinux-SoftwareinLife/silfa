package screen.loading.block {

	import com.greensock.TweenNano;
	import com.greensock.easing.Sine;
	
	import flash.display.MovieClip;
	
	import abstracts.LoadingAbstract;
	
	import identifier.LoadingName;

	public class BlockLoading extends LoadingAbstract {

		public const LOADING_NAME:String = LoadingName.BLOCK;

		private const LOADAREA_ALPHA_DURATION:Number = 1;

		public function BlockLoading() {

			super(LOADING_NAME);

		}
		
		override public function init(loadArea:MovieClip):void {
			
			super.loadArea = loadArea;
			super.loadArea.alpha = 0;
			
		}

		override public function open(areaSA:Number = 1):void {

			loadArea.visible = true;

			setVisible(areaSA);

		}

		override public function close():void {

			setVisible(0, false);

		}
		

		private function setVisible(targetA:Number, isClose:Boolean = true):void {
			
			TweenNano.killTweensOf(loadArea);
			
			TweenNano.to(loadArea, LOADAREA_ALPHA_DURATION, {

					alpha: targetA,

					delay: .2,

					ease: Sine.easeIn,

					onComplete: isClose ? null : closeComplete

				});

		}

		private function closeComplete():void {

			loadArea.visible = false;

		}

	}
}
