package abstracts {

	import flash.display.MovieClip;

	public class TableAbstract {

		private var _name:String;
		private var _tableArea:MovieClip;

		public function TableAbstract(name:String) {

			this._name = name;

		}

		public function init(tableArea:MovieClip):void {

			this._tableArea = tableArea;

		}

		public function updateField():void {



		}

		public function deleteField(num:uint = 0):void {



		}

		public function get name():String {

			return this._name;

		}

		protected function get tableArea():MovieClip {

			return this._tableArea;

		}


	}
}
