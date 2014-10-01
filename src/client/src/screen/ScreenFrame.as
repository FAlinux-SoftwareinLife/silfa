package screen {

	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;

	/**
	 *
	 * @author mini
	 * @Description
	 * Set DisplayObject bundle for Distributed to Mediator.
	 *
	 */
	public class ScreenFrame {

		private static const MODULE_STAGE:ModuleStage = new ModuleStage();

		private static var sw:StageWebView;

		public function ScreenFrame() {

		}

		public static function testFunc():void {

		}

		/**
		 * The ModuleStage.
		 * @return ModuleStage movieclip.
		 *
		 */
		public static function get module_stage():ModuleStage {

			return MODULE_STAGE;

		}

		/**
		 * The test button area on the screen.
		 * @return testBtnArea movieclip.
		 *
		 */
		public static function get testbtn_area():MovieClip {

			return module_stage.testBtnArea;

		}

		/**
		 * The application area on the screen.
		 * @return appArea movieclip.
		 *
		 */
		public static function get app_area():MovieClip {

			return module_stage.appArea;

		}

		/**
		 * The googleApps icon area on the screen.
		 * @return googleAppsIconArea movieclip.
		 *
		 */
		public static function get googleAppsIcon_area():MovieClip {

			return module_stage.googleAppsIconArea;

		}

		/**
		 * The database area on the screen.
		 * @return databaseArea movieclip.
		 *
		 */
		public static function get database_area():MovieClip {

			return module_stage.databaseArea;

		}

		/**
		 * The connectInfo area on the screen.
		 * @return connectInfoArea movieclip.
		 *
		 */
		public static function get connectInfo_area():MovieClip {

			return module_stage.connectInfoArea;

		}

		public static function get webview():StageWebView {

			if (sw == null) {

				sw = new StageWebView();
				sw.viewPort = new Rectangle(0, 0, MODULE_STAGE.stage.stageWidth, MODULE_STAGE.stage.stageHeight);
				sw.stage = MODULE_STAGE.stage;
				trace(MODULE_STAGE.width);

			}

			return sw;

		}


	}
}

/**
 * @author mini
 * 'ScreenFrame' is not possible to create an instance.
 *
 */
class BlockScreenFrame {
}
