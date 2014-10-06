package screen.button {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import manager.model.ModelManager;
	import manager.screen.IScreen;

	import model.google.oauth.GoogleOAuthData;

	import screen.ScreenFrame;

	/**
	 *
	 * @author mini
	 * Test Button Group.
	 *
	 */
	public class ButtonMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = "button";

		private const buttonArea:MovieClip = testbtn_area;

		private var buttonGroupList:Vector.<Object>;

		public function ButtonMediator() {

			super();

			buttonGroupList = Vector.<Object>([

				{name: "auth", list: ["login", "rpGmail", "rpDriveCalendar", "refreshToken"]},

				{name: "drive", list: ["getFilelist", "createDoc", "createSpr", "createPre"]}

				]);

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

			var group_num:uint = buttonGroupList.length;

			for (var i:uint = 0; i < group_num; i++) {

				var buttonGroup:Object = buttonGroupList[i] as Object;


				var group_name:String = buttonGroup.name as String;
				var button_list:Vector.<String> = Vector.<String>(buttonGroup.list);
				var button_num:uint = button_list.length;

				var groupArea:MovieClip = buttonArea.getChildByName(group_name + "BtnArea") as MovieClip;

				for (var j:uint = 0; j < button_num; j++) {

					var btn_name:String = button_list[j];
					var btn:MovieClip = groupArea.getChildByName(btn_name + "Btn") as MovieClip;

					btn.buttonMode = true;
					btn.mouseChildren = false;
					btn.addEventListener(MouseEvent.MOUSE_DOWN, btnMouseHandler);

				}

			}

		}

		private function btnMouseHandler(evt:MouseEvent):void {

			switch (evt.type) {

				case "mouseDown":

					var _oauthData:GoogleOAuthData = ModelManager.modelManagerObj.getData("oauth") as GoogleOAuthData;

					trace(_oauthData.authInfo);

					break;

			}

		}

		public function reset():void {


		}

		public function get name():String {

			return SCREEN_NAME;

		}

	}
}
