package screen.application {

	import flash.display.MovieClip;

	import abstracts.ApplicationAbstract;

	import events.MotionEvent;

	import frame.ScreenFrame;

	import identifier.ScreenName;

	import manager.screen.IScreen;

	import screen.application.drive.DriveApplication;
	import screen.application.profile.ProfileApplication;

	/**
	 * Application layout.
	 *
	 */
	public class ApplicationMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = ScreenName.APPLICATION;

		private const APPLICATION_LIST:Vector.<ApplicationAbstract> = Vector.<ApplicationAbstract>([

			new ProfileApplication, new DriveApplication

			]);

		private var currentApp:String;
		private var nextApp:String;

		public function ApplicationMediator() {

			super();

			init();

		}

		private function init():void {

			initApp();

		}

		private function initApp():void {

			for each (var _app:ApplicationAbstract in APPLICATION_LIST) {

				var _contentArea:MovieClip = app_area.getChildByName("contentArea") as MovieClip;
				var _appArea:MovieClip = _contentArea.getChildByName(_app.name + "Area") as MovieClip;

				_app.addEventListener(MotionEvent.IN_MOTION_FINISHED, inMotionFinishedHandler);
				_app.addEventListener(MotionEvent.OUT_MOTION_FINISHED, outMotionFinishedHandler);

				_app.init(_appArea);

			}

		}

		public function reset():void {

		}

		public function get name():String {

			return SCREEN_NAME;

		}

		public function setApp(appName:String):void {

			nextApp = appName;
			
			trace("appName = " + appName);
			trace("currentApp = " + currentApp);
			
			currentApp != null ? exit() : start();

		}

		public function exit():void {

			for each (var _app:ApplicationAbstract in APPLICATION_LIST)
				if (_app.name == currentApp)
					_app.exitApp();

		}

		public function exitAll():void {

			for each (var _app:ApplicationAbstract in APPLICATION_LIST)
				_app.exitApp();

		}

		private function start():void {

			for each (var _app:ApplicationAbstract in APPLICATION_LIST)
				if (_app.name == nextApp)
					_app.startApp();

		}

		private function inMotionFinishedHandler(evt:MotionEvent):void {
			
			trace(this, evt);
			
			currentApp = nextApp;
			nextApp = null;

		}

		private function outMotionFinishedHandler(evt:MotionEvent):void {
			
			trace(this, evt);
			
			currentApp = null;

			if (nextApp != null)
				start();

		}


	}
}