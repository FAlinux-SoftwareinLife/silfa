package screen.database.tables {

	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import abstracts.TableAbstract;
	
	import identifier.DataName;
	import identifier.ProxyName;
	import identifier.TableName;
	
	import manager.model.ModelManager;
	
	import model.db.info.InfoProxy;
	import model.db.info.data.ADFInfoData;

	public class FileTable extends TableAbstract {

		private const TABLE_NAME:String = TableName.FILE;
		private const VALUE_AREA_NAME:String = "valueArea";
		private const LIST_MAX:uint = 4;		
		private const DIFFER_HEIGHT:Number = 10;

		public function FileTable() {

			super(TABLE_NAME);

		}

		override public function updateField():void {
			
			var _valueArea:MovieClip = tableArea.getChildByName(VALUE_AREA_NAME) as MovieClip;
			var _listNum:uint = _valueArea.numChildren;
			
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

			if(LIST_MAX > _listNum)
				addFile(_fileValueTextArea);
			
		}
		
		private function addFile(textArea:FileValueTextArea):void {
		
			
			
		
		}
		
		//===================== obj reference =====================

		private function get infoProxyObj():InfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.INFO) as InfoProxy;

		}

		private function get adfInfoDataObj():ADFInfoData {

			return infoProxyObj.getData(DataName.ARM_DRIVE_FILE_INFO) as ADFInfoData;

		}

	}
}
