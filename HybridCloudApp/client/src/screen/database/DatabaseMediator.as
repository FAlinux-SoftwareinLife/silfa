package screen.database {

	import flash.display.MovieClip;

	import abstracts.TableAbstract;

	import frame.ScreenFrame;

	import identifier.ScreenName;

	import manager.screen.IScreen;

	import screen.database.tables.FileTable;
	import screen.database.tables.ProfileTable;

	/**
	 * Database data info list.
	 *
	 */
	public class DatabaseMediator extends ScreenFrame implements IScreen {

		private const SCREEN_NAME:String = ScreenName.DATABASE;

		private const TABLE_LIST:Vector.<TableAbstract> = Vector.<TableAbstract>([

			new ProfileTable, new FileTable

			]);

		public function DatabaseMediator() {

			init();

		}

		private function init():void {

			initTable();

		}

		private function initTable():void {

			for each (var _table:TableAbstract in TABLE_LIST) {

				var _contentArea:MovieClip = database_area.getChildByName("contentArea") as MovieClip;
				var _tableArea:MovieClip = _contentArea.getChildByName(_table.name + "Area") as MovieClip;

				_table.init(_tableArea);

			}

		}

		public function reset():void {


		}

		public function get name():String {

			return SCREEN_NAME;

		}

		public function setTable(tableName:String):void {

			for each (var _table:TableAbstract in TABLE_LIST)
				_table.updateField();

		}

		public function getTable(tableName:String):TableAbstract {

			var _selTable:TableAbstract;

			for each (var _table:TableAbstract in TABLE_LIST)
				if (tableName == _table.name)
					_selTable = _table;

			return _selTable;

		}

	}
}
