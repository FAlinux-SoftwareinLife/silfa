package {

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import model.ModelBase;

	import screen.ScreenMediator;

	[SWF(frameRate = "32", width = "1200", height = "1000", backgroundColor = "0xFFFFFF", pageTitle = "Module Screen")]
	public class Module_Screen extends Sprite {
		
		public function Module_Screen() {

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
			
			var screenMediator:ScreenMediator = new ScreenMediator();
			addChild(screenMediator);


		}

	}
}
