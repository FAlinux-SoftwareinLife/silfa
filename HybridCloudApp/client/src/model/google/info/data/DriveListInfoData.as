package model.google.info.data {

	import identifier.DataName;

	import manager.model.IData;

	public dynamic class DriveListInfoData implements IData {

		private static const DATA_NAME:String = DataName.DRIVE_LIST_INFO;

		private const FILE_TYPE_LIST:Vector.<String> = Vector.<String>(["document", "spreadsheet", "presentation", "other"]);

		private const FILE_TYPE_DEFINED:String = "mimeType";
		private const EXPORT_LINKS_DEFINED:String = "exportLinks";
		private const PDF_DOWNLOAD_DEFINED:String = "application/pdf";
		private const THUMBNAIL_LINK:String = "thumbnailLink";
		private const MODIFIED_DATE:String = "modifiedDate";

		private const THUMBNAIL_SIZE_LIST:Object = {document: 230, spreadsheet: 230, presentation: 300, other: 230};
		private const THUMBNAIL_GENERAL_ICON_URL:String = "https://ssl.gstatic.com/docs/doclist/images/icon_10_generic_xl128.png";

		private var defiendObj:Object;
		private var file_list:Vector.<Object>;


		public function DriveListInfoData() {

			defiendObj = {id: "", title: "", modifiedDate: "", fileType: "", alternateLink: "", embedLink: "", thumbnailLink: THUMBNAIL_GENERAL_ICON_URL, pdfLink: "", isOpen: false};

			file_list = new Vector.<Object>();

		}

		public function get name():String {

			return DATA_NAME;

		}

		public function requestData():void {
		}

		public function parseData(data:Object):void {

			file_list = new Vector.<Object>();

			for each (var _item:Object in data.items)
				file_list.push(parseItem(_item));

		}

		private function parseItem(item:Object):Object {

			var _parseObj:Object = cloneObj(defiendObj);

			for (var _itemName:String in item) {

				for (var _infoName:String in _parseObj) {

					var _transInfoName:String = _infoName;

					switch (_infoName) {

						case "fileType":

							_transInfoName = FILE_TYPE_DEFINED;

							break;

						case "pdfLink":

							_transInfoName = EXPORT_LINKS_DEFINED;

							break;

					}

					if (_transInfoName == _itemName)
						_parseObj[_infoName] = getTransItem(_itemName, item);

				}
			}

			return _parseObj;

		}

		//===================== parse file data =====================

		private function getTransItem(itemName:String, obj:Object):String {

			var _transItem:String;

			switch (itemName) {

				case FILE_TYPE_DEFINED:

					_transItem = getFileType(obj[itemName]);

					break;

				case EXPORT_LINKS_DEFINED:

					_transItem = obj[EXPORT_LINKS_DEFINED][PDF_DOWNLOAD_DEFINED];

					break;

				case THUMBNAIL_LINK:

					_transItem = parseThumbnail(getFileType(obj[FILE_TYPE_DEFINED]), obj[THUMBNAIL_LINK]);

					break;

				case MODIFIED_DATE:

					_transItem = replaceModifyDate(obj[MODIFIED_DATE]);

					break;

				default:
					_transItem = obj[itemName];

			}

			return _transItem;

		}

		private function getFileType(mimeType:String):String {

			var _selFileType:String = FILE_TYPE_LIST[FILE_TYPE_LIST.length - 1];

			for each (var _fileType:String in FILE_TYPE_LIST)
				if (mimeType.search(_fileType) != -1)
					_selFileType = _fileType;

			return _selFileType;

		}

		private function parseThumbnail(fileType:String, thumbnailLink:String):String {

			var _thumbnailURL:String;

			var _thumbSize:String = String(THUMBNAIL_SIZE_LIST[fileType]);

			_thumbnailURL = thumbnailLink.substring(

				0,

				thumbnailLink.indexOf("s220")).concat("s" + _thumbSize);

			_thumbnailURL = _thumbnailURL.search("http") == -1 ? THUMBNAIL_GENERAL_ICON_URL : _thumbnailURL;

			return _thumbnailURL;

		}

		private function replaceModifyDate(modifiedDate:String):String {

			var _replaceDate:String;
			var _replacePattern:RegExp = /T/gi;
			var _replaceStr:String = " ";
			var _cutStr:String = ":";

			_replaceDate = modifiedDate.substring(0, modifiedDate.lastIndexOf(_cutStr));
			_replaceDate = _replaceDate.replace(_replacePattern, _replaceStr);

			return _replaceDate;

		}

		//===================== get set data =====================

		public function getFileList():Vector.<Object> {

			return file_list;

		}

		public function setFileOpen(id:String, b:Boolean):void {

			for each (var _infoObj:Object in file_list)
				if (id == _infoObj.id)
					_infoObj.isOpen = b;

		}

		public function getOpenFile():Object {

			var _openFileObj:Object;

			for each (var _infoObj:Object in file_list)
				if (_infoObj.isOpen)
					_openFileObj = _infoObj;

			return _openFileObj;

		}

		//===================== add remove data =====================

		public function addFileData(data:Object):void {

			file_list.unshift(parseItem(data));

			//Tracer.log("trace", file_list);

		}

		public function removeFileData(id:String):void {

			for each (var _infoObj:Object in file_list)
				if (_infoObj.id == id)
					file_list.splice(file_list.indexOf(_infoObj), 1);

		}

		//===================== utils =====================

		private function cloneObj(copyObj:Object):Object {

			var _parseObj:Object = {};

			for (var _name:String in copyObj)
				_parseObj[_name] = copyObj[_name];

			return _parseObj;

		}

	}
}
