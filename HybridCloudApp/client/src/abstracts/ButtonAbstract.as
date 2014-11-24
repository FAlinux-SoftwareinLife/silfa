package abstracts {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class ButtonAbstract {

		private var _name:String;
		private var _button:MovieClip;

		public function ButtonAbstract(name:String) {

			this._name = name;

		}

		public function init(button:MovieClip):void {

			this._button = button;
			this._button.buttonMode = true;
			this._button.mouseChildren = false;

			enableButton();

		}

		protected function buttonMouseHandler(evt:MouseEvent):void {

			switch (evt.type) {

				case "mouseDown":

					mouseDownHandler();

					break;

			}

		}

		public function enableButton():void {

			this._button.mouseEnabled = true;
			this._button.addEventListener(MouseEvent.MOUSE_DOWN, buttonMouseHandler);

		}

		public function disableButton():void {

			this._button.mouseEnabled = false;
			this._button.removeEventListener(MouseEvent.MOUSE_DOWN, buttonMouseHandler);

		}

		public function get name():String {

			return _name;

		}

		protected function mouseDownHandler():void {


		}

	}
}
