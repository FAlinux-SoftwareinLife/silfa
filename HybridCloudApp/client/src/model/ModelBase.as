package model {

	import manager.model.IModel;
	import manager.model.ModelManager;

	import model.google.drive.GoogleDriveData;
	import model.google.oauth.GoogleOAuthData;

	public class ModelBase {

		private const DATA_LIST:Vector.<IModel> = Vector.<IModel>([

			new GoogleOAuthData, new GoogleDriveData

			]);

		public function ModelBase() {

			initData();

		}

		private function initData():void {
			
			for each (var data:IModel in DATA_LIST)
				ModelManager.modelManagerObj.addData(data);

		}

	}
}
