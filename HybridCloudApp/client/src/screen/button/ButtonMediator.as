package screen.button {

	import flash.display.MovieClip;

	import abstracts.ButtonAbstract;

	import frame.ScreenFrame;

	import identifier.ButtonName;
	import identifier.ScreenName;

	import manager.screen.IScreen;

	import screen.button.arm.DriveFileInfoButton;
	import screen.button.arm.ProfileInfoButton;
	import screen.button.auth.LoginButton;
	import screen.button.auth.RPDriveCalendarButton;
	import screen.button.auth.RPGmailButton;
	import screen.button.auth.ValidationTokenButton;
	import screen.button.drive.CreateDocButton;
	import screen.button.drive.CreatePreButton;
	import screen.button.drive.CreateSprButton;
	import screen.button.drive.GetFileListButton;
	import screen.button.profile.GetUserProfileButton;
	import screen.button.profile.LogoutButton;

	/**
	 *
	 * Test Button Group.
	 *
	 */
	public class ButtonMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = ScreenName.BUTTON;

		private const buttonArea:MovieClip = button_area;

		private const BUTTON_GROUP_LIST:Vector.<Object> = Vector.<Object>([

			{name: ButtonName.AUTH, buttonList: Vector.<ButtonAbstract>([

					new LoginButton, new RPGmailButton, new RPDriveCalendarButton, new ValidationTokenButton

					])},

			{name: ButtonName.PROFILE, buttonList: Vector.<ButtonAbstract>([

					new GetUserProfileButton, new LogoutButton

					])},

			{name: ButtonName.DRIVE, buttonList: Vector.<ButtonAbstract>([

					new GetFileListButton, new CreateDocButton, new CreateSprButton, new CreatePreButton

					])},

			{name: ButtonName.ARM, buttonList: Vector.<ButtonAbstract>([

					new ProfileInfoButton, new DriveFileInfoButton //, new MeasureButton

					])}

			]);

		public function ButtonMediator() {

			super();

			init();

		}

		/**
		 * Initialize 'TestButton' Area.
		 *
		 */
		private function init():void {

			initBtn();

		}

		/**
		 * Initialize button.
		 *
		 */
		private function initBtn():void {

			var _groupNum:uint = BUTTON_GROUP_LIST.length;

			for each (var _buttonGroupObj:Object in BUTTON_GROUP_LIST) {

				var _groupName:String = _buttonGroupObj.name as String;
				var _buttonList:Vector.<ButtonAbstract> = _buttonGroupObj.buttonList as Vector.<ButtonAbstract>;

				var _groupArea:MovieClip = buttonArea.getChildByName(_groupName + "BtnArea") as MovieClip;

				for each (var _button:ButtonAbstract in _buttonList) {

					var _buttonArea:MovieClip = _groupArea.getChildByName(_button.name + "Btn") as MovieClip;

					_button.init(_buttonArea);

				}

			}

		}

		public function reset():void {


		}

		public function get name():String {

			return SCREEN_NAME;

		}

		public function set view(obj:Object):void {

		}

		public function getButton(buttonName:String):ButtonAbstract {

			var _selButton:ButtonAbstract;

			var _groupNum:uint = BUTTON_GROUP_LIST.length;

			for each (var _buttonGroupObj:Object in BUTTON_GROUP_LIST) {

				var _groupName:String = _buttonGroupObj.name as String;
				var _buttonList:Vector.<Object> = Vector.<Object>(_buttonGroupObj.buttonList);

				var _groupArea:MovieClip = buttonArea.getChildByName(_groupName + "BtnArea") as MovieClip;

				for each (var _button:ButtonAbstract in _buttonList)
					if (_button.name == buttonName)
						_selButton = _button;

			}

			return _selButton;

		}

	}
}
