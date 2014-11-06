package model.db.info.data {

	import identifier.DataName;

	import manager.model.IData;

	public class ADFInfoData implements IData {

		private const DATA_NAME:String = DataName.ARM_DRIVE_FILE_INFO;

		private var driveFileInfoObj:Object;

		public function ADFInfoData() {

			driveFileInfoObj = {

					fileId: "", fileName: "", fileType: "", modifiedDate: "", thumbnail: "", userId: ""

				};

		}

		public function get name():String {

			return DATA_NAME;

		}

		public function requestData():void {
		}

		public function parseData(data:Object):void {
			
			driveFileInfoObj.fileId = String(data.fileId);
			driveFileInfoObj.fileName = String(data.fileName);
			driveFileInfoObj.fileType = String(data.fileType);
			driveFileInfoObj.modifiedDate = String(data.modifiedDate);
			driveFileInfoObj.thumbnail = String(data.thumbnail);

		}

		public function getFileId():String {

			return driveFileInfoObj.fileId;

		}

		public function getFileName():String {

			return driveFileInfoObj.fileName;

		}

		public function getFileType():String {

			return driveFileInfoObj.fileType;

		}

		public function getModifiedDate():String {

			return driveFileInfoObj.modifiedDate;

		}

		public function getThumbnail():String {

			return driveFileInfoObj.thumbnail;

		}

	}
}
