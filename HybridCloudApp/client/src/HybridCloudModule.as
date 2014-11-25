package {

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import controller.ControllerBase;

	import model.ModelBase;

	import screen.ScreenBase;

	[SWF(frameRate = "64", width = "1300", height = "860", backgroundColor = "0xFFFFFF", pageTitle = "Hybrid Cloud Module")]
	public class HybridCloudModule extends Sprite {

		public function HybridCloudModule() {

			initStage();
			init();

		}

		/**
		 * Initialize root stage.
		 *
		 */
		private function initStage():void {

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

		}

		private function init():void {

			var modelBase:ModelBase = new ModelBase();
			var screenBase:ScreenBase = new ScreenBase();
			var controllerBase:ControllerBase = new ControllerBase();

			addChild(screenBase);

		}

	}
}
