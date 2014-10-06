package model.google.drive {
	import manager.model.IModel;

	public class GoogleDriveData implements IModel {

		private const MODEL_NAME:String = "drive";
		
		

		public function GoogleDriveData() {



		}

		public function get name():String {

			return MODEL_NAME;

		}

	}
}
