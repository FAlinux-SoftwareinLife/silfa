package abstracts {

	public class SendLogAbstract {

		protected var sendLogList:Vector.<Object>;

		protected var _logName:String;

		public function SendLogAbstract() {



		}

		public function getLog(reqName:String):String {

			var _selMessage:String;

			for each (var _sendLogObj:Object in sendLogList)
				if (_sendLogObj.name == reqName)
					_selMessage = _sendLogObj.message;

			return _selMessage;

		}

		public function get name():String {

			return _logName;

		}

	}
}
