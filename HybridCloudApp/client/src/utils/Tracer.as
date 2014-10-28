package utils {

	public class Tracer {

		private static var _tracer:Tracer;

		private static var _data:Object;

		public function Tracer(blockTracer:BlockTracer) {
		}

		public static function log(type:String, data:Object):void {

			_data = data;

			switch (type) {

				case "trace":

					spreadTrace();

					break;

			}

		}

		private static function spreadTrace():void {

			trace("\n\n============ Trace log : start ============\n");

			try {

				var _num:uint = _data.length == "undefined" ? _data.length : _data.items.length;

				trace("item num = " + _num);

			} catch (msg:Error) {

				trace(msg.message);

			}


			for (var i:Object in _data) {

				trace("\n----- first -----");

				var _subObj:Object = _data[i];

				trace("\n" + i + " = " + _subObj);


				for (var j:Object in _subObj) {

					//trace("\n--- second ---");

					var _trdObj:Object = _subObj[j];

					trace("\n" + j + " = " + _trdObj);

					for (var h:Object in _trdObj) {

						//	trace("\n-- third --");

						var _fourthObj:Object = _trdObj[h];

						trace("\n" + h + " = " + _fourthObj);

						for (var k:Object in _fourthObj) {

							//trace("\n- fourth -");

							var _fifthObj:Object = _fourthObj[k];

							trace("\n" + k + " = " + _fifthObj);

						}

					}
				}

			}

			trace("\n\n============ Trace log : end ============");

		}

	}
}

class BlockTracer {
}
