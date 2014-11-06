package model.google.apps {

	import abstracts.ModelProxyAbstract;

	import events.AppsEvent;

	import identifier.DataName;
	import identifier.ProxyName;

	import manager.model.IData;
	import manager.model.IModel;

	import model.google.apps.data.DocFileData;
	import model.google.apps.data.DriveFileTrashData;
	import model.google.apps.data.DriveListData;
	import model.google.apps.data.PreFileData;
	import model.google.apps.data.ProfileData;
	import model.google.apps.data.SprFileData;

	public class GoogleAppsProxy extends ModelProxyAbstract implements IModel {

		private const MODEL_NAME:String = ProxyName.GOOGLE_APPS;

		private const APPS_DATA_LIST:Vector.<Object> = Vector.<Object>([

			new ProfileData, new DriveListData, new DriveFileTrashData, new DocFileData, new SprFileData, new PreFileData

			]);

		public function GoogleAppsProxy() {

		}

		public function get name():String {

			return MODEL_NAME;

		}

		/**
		 * Apps information.
		 * @param type Request type name.
		 *
		 */
		public function requestData(name:String):void {

			for each (var _data:IData in APPS_DATA_LIST)
				if (name == _data.name)
					_data.requestData();

		}

		/**
		 * Result Drive data for 'Data Class'.
		 * @param result
		 * result value.
		 *
		 */
		public function resultData(result:Object):void {

			switch (result.type) {

				case DataName.PROFILE:

					dispatchEvent(new AppsEvent(AppsEvent.REQUEST_PROFILE_COMPLETE, result));

					break;

				case DataName.DRIVE_LIST:

					dispatchEvent(new AppsEvent(AppsEvent.REQUEST_DRIVE_LIST_COMPLETE, result));

					break;

				case DataName.DRIVE_FILE_TRASH:

					dispatchEvent(new AppsEvent(AppsEvent.DRIVE_FILE_TRASH_COMPLETE, result.data));

					break;

				case DataName.DOC_FILE:

					dispatchEvent(new AppsEvent(AppsEvent.CREATE_DOC_FILE, result.data));

					break;

				case DataName.SPR_FILE:

					dispatchEvent(new AppsEvent(AppsEvent.CREATE_SPR_FILE, result.data));

					break;

				case DataName.PRE_FILE:

					dispatchEvent(new AppsEvent(AppsEvent.CREATE_PRE_FILE, result.data));

					break;

			}

		}

		public function setData(dataObj:Object):void {

			for each (var _data:IData in APPS_DATA_LIST)
				if (dataObj.name == _data.name)
					_data.parseData(dataObj.data);

		}

		public function getData(name:String):IData {

			var _selData:IData;

			for each (var _data:IData in APPS_DATA_LIST)
				if (name == _data.name)
					_selData = _data;

			return _selData;

		}



	}
}
