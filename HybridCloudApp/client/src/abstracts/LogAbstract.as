package abstracts {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class LogAbstract {

		private var _name:String;
		private var _logArea:MovieClip;
		private var _logTxt:TextField;
		private var _logTxtOldY:Number;
		private var _logTxtOldH:Number;

		public function LogAbstract(name:String) {

			this._name = name;

		}

		public function init(logArea:MovieClip):void {

			this._logArea = logArea;
			this._logTxt = this._logArea.getChildByName("logTxt") as TextField;

			/*
			this._logArea.mouseChildren = false;
			this._logArea.buttonMode = true;
			this._logArea.addEventListener(MouseEvent.MOUSE_DOWN, logAreaMouseHandler);
			*/
			
			_logTxtOldY = this._logTxt.y;
			_logTxtOldH = this._logTxt.height;
			
			initButton();

		}
		
		protected function initButton():void {
			
		}

		/**
		 * @param log
		 *
		 */
		public function updateLog(log:String):void {


		}

		protected function clearLog():void {


		}

		protected function logAreaMouseHandler(evt:MouseEvent):void {


		}

		public function get name():String {

			return _name;

		}

		public function get logArea():MovieClip {

			return _logArea;

		}

		public function get logTxt():TextField {

			return _logTxt;

		}

		public function get logTxtOldY():Number {

			return _logTxtOldY;

		}

		public function get logTxtOldH():Number {

			return _logTxtOldH;

		}

	}
}
