package manager.model {

	/**
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
		public function addProxy(proxy:IModel):void {

			var _obj:Object = {name: proxy.name, model: proxy};
			modelList.push(_obj);

		}

		/**
		 * Remove data in 'modelList' instance.
		 * @param data Data instance;
		 * 
		 */
		public function removeProxy(data:IModel):void {

			var _list_num:int = modelList.length;
			
			for (var i:uint = 0; i < _list_num; i++) {

				var _obj:Object = modelList[i];

				if (data == _obj.model)
					modelList.splice(i, 1);

			}

		}

		/**
		 * @param name
		 * @return Select model data.
		 *
		 */
		public function getProxy(name:String):IModel {

			var _proxy:IModel;

			for each (var obj:Object in modelList) {

				if (name == obj.name)
					_proxy = obj.model;
			}

			return _proxy;

		}

		public function getModelList():Vector.<Object> {

			return modelList;

		}

		/**
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
 *
 */
class BlockModelManager {
}
