package abstracts {

	import flash.display.MovieClip;

	public class MeasureAbstract {

		private var _name:String;
		private var _measureArea:MovieClip;

		public function MeasureAbstract(name:String) {

			this._name = name;

		}

		public function init(measureArea:MovieClip):void {

			this._measureArea = measureArea;

		}

		public function setMeasureValue(valueObj:Object):void {


		}

		public function get name():String {

			return _name;

		}

	}
}
