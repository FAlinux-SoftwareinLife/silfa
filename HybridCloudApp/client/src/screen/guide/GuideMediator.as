package screen.guide {

	import flash.display.MovieClip;

	import abstracts.GuideAbstract;

	import frame.ScreenFrame;

	import identifier.ScreenName;

	import manager.screen.IScreen;

	import screen.guide.drive.DriveGuide;
	import screen.guide.file.FileGuide;
	import screen.guide.list.ListGuide;
	import screen.guide.login.LoginGuide;
	import screen.guide.profile.ProfileGuide;

	public class GuideMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = ScreenName.GUIDE;

		private const GUIDE_LIST:Vector.<GuideAbstract> = Vector.<GuideAbstract>([

			new LoginGuide, new DriveGuide, new ProfileGuide, new ListGuide, new FileGuide

			]);

		public function GuideMediator() {

			init();

		}

		private function init():void {

			initGuide();

		}

		private function initGuide():void {

			for each (var _guide:GuideAbstract in GUIDE_LIST) {

				var _contentArea:MovieClip = guide_area.getChildByName("contentArea") as MovieClip;
				var _guideArea:MovieClip = _contentArea.getChildByName(_guide.name + "Guide") as MovieClip;

				_guide.init(_guideArea);

			}

		}

		public function get name():String {

			return SCREEN_NAME;

		}

		public function reset():void {
		}


		public function open(guideName:String):void {
			
			for each (var _guide:GuideAbstract in GUIDE_LIST)
				if (_guide.name == guideName)
					_guide.openGuide();
				
		}

	}
}
