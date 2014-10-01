package manager.model {

	/**
	 *
	 * @author mini
	 *
	 * Model manager.
	 *
	 */

	public class ModelManager {

		private static var modelManager:ModelManager;

		private var modelList:Vector.<Object>;

		public function ModelManager(blockModelManager:BlockModelManager) {
			
			modelList = new Vector.<Object>();

		}

		/**
		 * Add data in 'modelList' instance.
		 * @param data Data instance.
		 *
		 */
		public function addData(data:IModel):void {

			var _obj:Object = {name: data.name, model: data};
			modelList.push(_obj);

		}

		public function removeData(data:IModel):void {


		}

		/**
		 *
		 * @param name
		 * @return Select model data.
		 *
		 */
		public function getData(name:String):IModel {

			var _data:IModel;

			for each (var obj:Object in modelList) {

				if (name == obj.name)
					_data = obj.model;
			}

			return _data;

		}

		public function getModelList():Vector.<Object> {

			return modelList;

		}

		/**
		 *
		 * Get ModelManager instance.
		 * @return Instance ModelManager.
		 *
		 */
		public static function get modelManagerObj():ModelManager {

			if (modelManager == null)
				modelManager = new ModelManager(new BlockModelManager());

			return modelManager;

		}



	}
}

/**
 *'ModelManager' is not possible to create an instance.
 * @author mini
 *
 */
class BlockModelManager {
}
