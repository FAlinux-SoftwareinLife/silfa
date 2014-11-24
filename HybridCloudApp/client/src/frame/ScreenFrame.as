package frame {

	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;

	/**
	 * Set DisplayObject bundle for Distributed to Mediator.
	 *
	 */
	public class ScreenFrame extends EventDispatcher {

		private static const HCM_STAGE:HCMStage = new HCMStage();

		private static var swv:StageWebView;

		public function ScreenFrame() {

		}

		/**
		 * The ModuleStage.
		 * @return ModuleStage movieclip.
		 *
		 */
		public static function get hcm_stage():HCMStage {

			return HCM_STAGE;

		}

		/**
		 * The test button area on the screen.
		 * @return testBtnArea movieclip.
		 *
		 */
		public static function get button_area():MovieClip {

			return hcm_stage.buttonArea;

		}

		/**
		 * The application area on the screen.
		 * @return appArea movieclip.
		 *
		 */
		public static function get app_area():MovieClip {

			return hcm_stage.applicationArea;

		}

		/**
		 * The googleApps icon area on the screen.
		 * @return googleAppsIconArea movieclip.
		 *
		 */
		public static function get googleAppsIcon_area():MovieClip {

			return hcm_stage.googleAppsIconArea;

		}

		/**
		 * The database area on the screen.
		 * @return databaseArea movieclip.
		 *
		 */
		public static function get database_area():MovieClip {

			return hcm_stage.databaseArea;

		}

		/**
		 * The log area on the screen.
		 * @return logArea movieclip.
		 *
		 */
		public static function get log_area():MovieClip {

			return hcm_stage.logArea;

		}

		/**
		 * The guide area on the screen.
		 * @return guideArea movieclip.
		 *
		 */
		public static function get guide_area():MovieClip {

			return hcm_stage.guideArea;

		}

		/**
		 * The loading area on the screen.
		 * @return loadingArea movieclip.
		 *
		 */
		public static function get loading_area():MovieClip {

			return hcm_stage.loadingArea;

		}

		public static function get webview():StageWebView {

			if (swv == null) {

				swv = new StageWebView();
				swv.viewPort = new Rectangle();
				swv.stage = HCM_STAGE.stage;

			}

			return swv;

		}

		public static function removeWebview():void {

			if (swv != null) {

				swv.dispose();
				swv = null;

			}

		}


	}
}
