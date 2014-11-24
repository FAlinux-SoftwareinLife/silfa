package screen.loading {

	import flash.display.MovieClip;

	import abstracts.LoadingAbstract;

	import frame.ScreenFrame;

	import identifier.ScreenName;

	import manager.screen.IScreen;

	import screen.loading.block.BlockLoading;
	import screen.loading.circle.CircleLoading;

	public class LoadingMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = ScreenName.LOADING;

		private const LOADING_LIST:Vector.<LoadingAbstract> = Vector.<LoadingAbstract>([

			new CircleLoading, new BlockLoading

			]);

		public function LoadingMediator() {

			init();

		}

		private function init():void {

			initLoading();

		}

		private function initLoading():void {

			for each (var _loading:LoadingAbstract in LOADING_LIST) {

				var _contentArea:MovieClip = loading_area.getChildByName("contentArea") as MovieClip;
				var _loadingArea:MovieClip = _contentArea.getChildByName(_loading.name + "Area") as MovieClip;

				_loading.init(_loadingArea);

			}

		}

		public function openLoading():void {

			for each (var _loading:LoadingAbstract in LOADING_LIST)
				_loading.open();

		}

		public function closeLoading():void {

			for each (var _loading:LoadingAbstract in LOADING_LIST)
				_loading.close();

		}

		public function reset():void {
		}

		public function get name():String {

			return SCREEN_NAME;

		}

		public function getLoading(loadingName:String):LoadingAbstract {

			var _selLoading:LoadingAbstract;

			for each (var _loading:LoadingAbstract in LOADING_LIST)
				if (_loading.name == loadingName)
					_selLoading = _loading;

			return _selLoading;
			
		}

	}
}
