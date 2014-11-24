package screen.log {

	import flash.display.MovieClip;

	import abstracts.LogAbstract;

	import frame.ScreenFrame;

	import identifier.ScreenName;

	import manager.screen.IScreen;

	import screen.log.top.TopLog;

	/**
	 * Application log.
	 *
	 */
	public class LogMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = ScreenName.LOG;

		private const LOG_LIST:Vector.<LogAbstract> = Vector.<LogAbstract>([

			new TopLog

			]);

		public function LogMediator() {

			init();

		}

		private function init():void {

			initLog();

		}

		private function initLog():void {

			for each (var _log:LogAbstract in LOG_LIST) {

				var _contentArea:MovieClip = log_area.getChildByName("contentArea") as MovieClip;
				var _logArea:MovieClip = _contentArea.getChildByName(_log.name + "Area") as MovieClip;

				_log.init(_logArea);

			}

		}

		public function reset():void {


		}

		public function get name():String {

			return SCREEN_NAME;

		}
		
		public function log(logStr:String):void {
		
			LOG_LIST[0].updateLog(logStr);
		
		}

		public function getLog(logName:String):LogAbstract {

			var _selLog:LogAbstract;

			for each (var _log:LogAbstract in LOG_LIST)
				if (_log.name == logName)
					_selLog = _log;

			return _selLog;

		}


	}
}
