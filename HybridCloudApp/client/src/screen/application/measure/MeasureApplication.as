package screen.application.measure {

	import com.greensock.TweenNano;
	import com.greensock.easing.Sine;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import abstracts.ApplicationAbstract;

	import controller.arm.ArmController;
	import controller.arm.command.InsertMeasureCommand;

	import identifier.ApplicationName;
	import identifier.CommandName;
	import identifier.ControllerName;
	import identifier.ProxyName;

	import manager.controller.ControllerManager;
	import manager.model.ModelManager;

	import model.db.arm.ArmServerProxy;

	import utils.Tracer;

	public class MeasureApplication extends ApplicationAbstract {

		private const APP_NAME:String = ApplicationName.MEASURE;

		private const MEASURE_BTN_LIST:Vector.<Object> = Vector.<Object>([

			{name: "insert", func: insertExecute}, {name: "receive", func: receiveExecute}, {name: "result", func: resultExecute}

			]);

		private const DATA_OBJ:Object = {userId: "", photo: "", gender: "", email: "", language: "", authorize: "", num: 0};

		private var resultObj:Object;

		public function MeasureApplication() {

			super(APP_NAME);

		}

		override protected function initDisplayObj():void {

			initButton();

			appArea.alpha = 0;

		}

		private function initButton():void {

			for each (var _btnObj:Object in MEASURE_BTN_LIST) {

				var _btnName:String = _btnObj.name;
				var _btnFunc:Function = _btnObj.func as Function;
				var _btn:MovieClip = appArea.getChildByName(_btnName + "Btn") as MovieClip;

				_btn.func = _btnFunc;

				_btn.buttonMode = true;
				_btn.mouseChildren = false;
				_btn.addEventListener(MouseEvent.MOUSE_DOWN, btnMouseHandler);

			}

		}

		private function btnMouseHandler(evt:MouseEvent):void {

			var _btn:MovieClip = evt.currentTarget as MovieClip;

			switch (evt.type) {

				case MouseEvent.MOUSE_DOWN:

					_btn.func();

					break;

			}

		}

		private function insertExecute():void {

			var _executeObj:Object = {type: CommandName.INSERT_MEASURE, param: dateObj};

			armControllerObj.setExecute(_executeObj);

		}

		private function receiveExecute():void {

			var _executeObj:Object = {type: "receiveMeasure", param: dateObj};

			armControllerObj.setExecute(_executeObj);



		}

		private function resultExecute():void {



		}

		private function get dateObj():Object {

			with (appArea) {

				DATA_OBJ.userId = userIdTxt.text;
				DATA_OBJ.photo = photoTxt.text;
				DATA_OBJ.gender = genderTxt.text;
				DATA_OBJ.email = emailTxt.text;
				DATA_OBJ.language = languageTxt.text;
				DATA_OBJ.authorize = authorizeTxt.text;
				DATA_OBJ.num = uint(1);

			}

			return DATA_OBJ;

		}

		public function setResult(obj:Object):void {

			resultObj = obj;

			Tracer.log(resultObj);

		}

		override public function startApp():void {

			appArea.visible = true;

			TweenNano.to(appArea, 1, {alpha: 1, ease: Sine.easeOut});

		}


		//===================== obj reference =====================

		private function get armControllerObj():ArmController {

			return ControllerManager.controllerManagerObj.getController(ControllerName.ARM) as ArmController;

		}




	}
}
