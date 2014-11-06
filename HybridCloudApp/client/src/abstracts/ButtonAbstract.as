package abstracts {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class ButtonAbstract {

		private var _name:String;

		private var _button:MovieClip;

		public function ButtonAbstract(name:String, button:MovieClip) {

			this._name = name;
			this._button = button;

			initButton();
			initAddEvent();

		}

		protected function initButton():void {

			this._button.buttonMode = true;
			this._button.mouseChildren = false;

		}

		protected function initAddEvent():void {

			this._button.addEventListener(MouseEvent.MOUSE_DOWN, buttonMouseHandler);

		}

		protected function buttonMouseHandler(evt:MouseEvent):void {

			switch (evt.type) {

				case "mouseDown":

					mouseDownHandler();

					break;

			}

		}


		protected function get name():String {

			return _name;

		}

		protected function mouseDownHandler():void {


		}

	}
}
