package screen.button {

	import flash.display.MovieClip;

	import frame.ScreenFrame;

	import identifier.ButtonName;
	import identifier.ScreenName;

	import manager.screen.IScreen;

	import screen.button.arm.*;
	import screen.button.auth.*;
	import screen.button.drive.*;

	/**
	 *
	 * Test Button Group.
	 *
	 */
	public class ButtonMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = ScreenName.BUTTON;

		private const buttonArea:MovieClip = button_area;

		private const BUTTON_GROUP_LIST:Vector.<Object> = Vector.<Object>([

			{name: ButtonName.AUTH, buttonList: [

				{name: ButtonName.LOGIN, button: LoginButton},

					{name: ButtonName.RP_GMAIL, button: RPGmailButton},

					{name: ButtonName.RP_DRIVE_CALENDAR, button: RPDriveCalendarButton},

					{name: ButtonName.REFRESH_TOKEN, button: RefreshTokenButton},

					{name: ButtonName.GET_USER_PROFILE, button: GetUserProfileButton}

				]},

			{name: ButtonName.DRIVE, buttonList: [

				{name: ButtonName.GET_FILE_LIST, button: GetFileListButton},

					{name: ButtonName.CREATE_DOC, button: CreateDocButton},

					{name: ButtonName.CREATE_SPR, button: CreateSprButton},

					{name: ButtonName.CREATE_PRE, button: CreatePreButton}

				]},

			{name: ButtonName.ARM, buttonList: [

				{name: ButtonName.PROFILE_INFO, button: ProfileInfoButton},

					{name: ButtonName.DRIVE_FILE_INFO, button: DriveFileInfoButton}

				]}

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
				var _buttonList:Vector.<Object> = Vector.<Object>(_buttonGroupObj.buttonList);

				var _groupArea:MovieClip = buttonArea.getChildByName(_groupName + "BtnArea") as MovieClip;

				for each (var _buttonObj:Object in _buttonList) {

					var _buttonName:String = _buttonObj.name;
					var _ButtonClass:Class = _buttonObj.button as Class;
					var _button:MovieClip = _groupArea.getChildByName(_buttonName + "Btn") as MovieClip;

					new _ButtonClass(_buttonName, _button);

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

	}
}
