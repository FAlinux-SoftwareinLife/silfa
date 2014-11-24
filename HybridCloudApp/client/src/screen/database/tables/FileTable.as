package screen.database.tables {

	import flash.display.MovieClip;
	import flash.text.TextField;

	import abstracts.TableAbstract;

	import identifier.DataName;
	import identifier.ProxyName;
	import identifier.TableName;

	import manager.model.ModelManager;

	import model.db.info.ArmInfoProxy;
	import model.db.info.data.ADFInfoData;

	public class FileTable extends TableAbstract {

		private const TABLE_NAME:String = TableName.FILE;
		private const VALUE_AREA_NAME:String = "valueArea";
		private const LIST_MAX:uint = 4;
		private const DIFFER_HEIGHT:Number = 23;

		private var _valueArea:MovieClip;

		public function FileTable() {

			super(TABLE_NAME);

		}

		override public function init(tableArea:MovieClip):void {

			super.init(tableArea);

			_valueArea = tableArea.getChildByName(VALUE_AREA_NAME) as MovieClip;

		}

		override public function updateField():void {

			var _fileValueTextArea:FileValueTextArea = new FileValueTextArea();

			var _fileIdTxt:TextField = _fileValueTextArea.getChildByName("fileIdTxt") as TextField;
			var _fileNameTxt:TextField = _fileValueTextArea.getChildByName("fileNameTxt") as TextField;
			var _modifiedDateTxt:TextField = _fileValueTextArea.getChildByName("modifiedDateTxt") as TextField;
			var _thumbnailTxt:TextField = _fileValueTextArea.getChildByName("thumbnailTxt") as TextField;
			var _fileTypeTxt:TextField = _fileValueTextArea.getChildByName("fileTypeTxt") as TextField;

			_fileIdTxt.text = adfInfoDataObj.getFileId();
			_fileNameTxt.text = adfInfoDataObj.getFileName();
			_modifiedDateTxt.text = adfInfoDataObj.getModifiedDate();
			_thumbnailTxt.text = adfInfoDataObj.getThumbnail();
			_fileTypeTxt.text = adfInfoDataObj.getFileType();

			parseList(_fileValueTextArea);

			alignTextArea();

		}

		private function parseList(addTextArea:FileValueTextArea):void {

			var _listNum:uint = _valueArea.numChildren;

			if (LIST_MAX <= _listNum)
				removeFile();

			addFile(addTextArea);

		}

		private function addFile(addTextArea:FileValueTextArea):void {

			_valueArea.addChild(addTextArea);

		}

		private function removeFile():void {

			_valueArea.removeChildAt(0);

		}

		private function alignTextArea():void {

			var _listNum:uint = _valueArea.numChildren;

			for (var i:uint = 0; i < _listNum; i++) {

				var _subtractNum:uint = i + 1;
				var _textArea:FileValueTextArea = _valueArea.getChildAt(_listNum - _subtractNum) as FileValueTextArea;

				_textArea.y = (_textArea.height + DIFFER_HEIGHT) * i;

			}

		}

		//===================== obj reference =====================

		private function get infoProxyObj():ArmInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.ARM_INFO) as ArmInfoProxy;

		}

		private function get adfInfoDataObj():ADFInfoData {

			return infoProxyObj.getData(DataName.ARM_DRIVE_FILE_INFO) as ADFInfoData;

		}

	}
}
