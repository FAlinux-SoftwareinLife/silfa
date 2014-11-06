package screen.application.drive {

	import com.greensock.TweenNano;

	import flash.display.MovieClip;

	import abstracts.ApplicationAbstract;

	import events.TitleAreaMouseEvent;

	import identifier.ApplicationName;
	import identifier.DataName;
	import identifier.ProxyName;

	import manager.model.ModelManager;

	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.DriveListInfoData;

	import utils.Tracer;

	public class DriveApplication extends ApplicationAbstract {

		private const APP_NAME:String = ApplicationName.DRIVE;

		private var driveFileArea:MovieClip;

		private var driveFileInfoList:Vector.<Object>;
		private var driveFile_num:int;

		private const FILE_DIFFER_HEIGHT:Number = 5;

		public function DriveApplication() {

			super(APP_NAME);

		}

		override protected function initDisplayObj():void {

			driveFileArea = appArea.getChildByName("driveFileArea") as MovieClip;

		}

		override public function startApp():void {

			removeAllDriveFile();

			initDriveFileList();

			startMotion();

		}

		override public function exitApp():void {

			TweenNano.to(appArea, 1, {alpha: 0, onComplete: outMotionComplete});

		}

		//===================== set drive file =====================

		/**
		 * Set 'DriveFile' list
		 *
		 */
		private function initDriveFileList():void {

			driveFileInfoList = driveListInfoDataObj.getFileList() as Vector.<Object>;
			driveFile_num = driveFileInfoList.length;

			var _addList:Array = new Array();

			for (var i:uint = 0; i < driveFile_num; i++)
				_addList.push(driveFileInfoList[i].id);

			addDriveFile(_addList);

		}

		//===================== align drive file =====================

		/**
		 * Select open 'DriveFile'
		 * @param selectFile openfile
		 *
		 */
		private function visibleDriveFile(selectFile:DriveFile = null):void {

			driveFile_num = driveFileArea.numChildren;

			for (var i:uint = 0; i < driveFile_num; i++) {

				var _driveFile:DriveFile = driveFileArea.getChildAt(i) as DriveFile;
				var _titleArea:MovieClip = _driveFile.getChildByName("titleArea") as MovieClip;
				var _contentArea:MovieClip = _driveFile.getChildByName("contentArea") as MovieClip;

				if (selectFile == null)
					selectFile = _driveFile;

				_driveFile.isOpen = _driveFile == selectFile;
				
				driveListInfoDataObj.setFileOpen(_driveFile.infoObj.id, _driveFile.isOpen);
				
				_contentArea.y = _driveFile.isOpen ? _titleArea.height : -_contentArea.height + _titleArea.height;

			}

		}

		private function alignDriveFile():void {

			driveFile_num = driveFileArea.numChildren;

			for (var i:uint = 0; i < driveFile_num; i++) {

				var _driveFile:DriveFile = driveFileArea.getChildAt(i) as DriveFile;
				var _prevDriveFile:DriveFile = driveFileArea.getChildAt(i == 0 ? i : i - 1) as DriveFile;

				var _titleArea:MovieClip = _driveFile.getChildByName("titleArea") as MovieClip;
				var _contentArea:MovieClip = _driveFile.getChildByName("contentArea") as MovieClip;
				var _contentMask:MovieClip = _driveFile.getChildByName("contentMask") as MovieClip;

				_driveFile.prevFile = _prevDriveFile;

				if (i != 0) {

					if (_prevDriveFile.isOpen) {

						_driveFile.y = _prevDriveFile.y + _prevDriveFile.height + FILE_DIFFER_HEIGHT;

					} else {

						_driveFile.y = _prevDriveFile.y + _prevDriveFile.titleArea.y + _prevDriveFile.titleArea.height + FILE_DIFFER_HEIGHT;

					}

				} else {

					_driveFile.y = 0;

				}

			}


		}

		private function refreshFileName():void {

			var _driveFileAreaNum:uint = driveFileArea.numChildren;

			for (var j:uint = 0; j < _driveFileAreaNum; j++)
				driveFileArea.getChildAt(j).name = "driveFile" + String(j);

		}

		public function resetDriveFile():void {

			removeAllDriveFile();
			visibleDriveFile();
			alignDriveFile();

		}

		//===================== add remove drive file =====================

		/**
		 * Add 'DriveFile'
		 * @param idList 'DriveFile' ID list.
		 *
		 */
		public function addDriveFile(idList:Array):void {

			startMotion();

			var _addList:Vector.<Object> = new Vector.<Object>();

			driveFileInfoList = driveListInfoDataObj.getFileList() as Vector.<Object>;

			for each (var _obj:Object in driveFileInfoList)
				for each (var _id:String in idList)
					if (_obj.id == _id)
						_addList.push(_obj);

			_addList.reverse();

			var _addNum:uint = _addList.length;

			for (var i:uint = 0; i < _addNum; i++) {

				var _driveFileInfo:Object = _addList[i] as Object;
				var _driveFile:DriveFile = new DriveFile(_driveFileInfo);

				driveFileArea.addChildAt(_driveFile, 0);

				_driveFile.addEventListener(TitleAreaMouseEvent.TITLE_AREA_CLICK, titleAreaMouseHandler);

			}

			refreshFileName();

			visibleDriveFile();
			alignDriveFile();

		}

		public function removeDriveFile(idList:Array):void {

			driveFile_num = driveFileArea.numChildren;

			var _idListNum:uint = idList.length;
			var _deleteFileList:Vector.<DriveFile> = new Vector.<DriveFile>();

			for (var i:uint = 0; i < driveFile_num; i++) {

				var _driveFile:DriveFile = driveFileArea.getChildAt(i) as DriveFile;
				var _id:String = _driveFile.infoObj.id;

				for (var j:uint = 0; j < _idListNum; j++)
					if (idList[j] == _id)
						_deleteFileList.push(_driveFile);

			}

			for each (var _deleteDriveFile:DriveFile in _deleteFileList) {

				driveFileArea.removeChild(_deleteDriveFile);
				_deleteDriveFile = null;

			}

			visibleDriveFile();
			alignDriveFile();

		}

		private function removeAllDriveFile():void {

			driveFile_num = driveFileArea.numChildren;

			var _deleteFileList:Vector.<DriveFile> = new Vector.<DriveFile>();

			for (var i:uint = 0; i < driveFile_num; i++) {

				var _driveFile:DriveFile = driveFileArea.getChildAt(0) as DriveFile;
				driveFileArea.removeChild(_driveFile);
				_driveFile = null;

			}

		}

		//===================== button =====================

		private function titleAreaMouseHandler(evt:TitleAreaMouseEvent):void {

			var _driveFile:DriveFile = evt.currentTarget as DriveFile;

			visibleDriveFile(_driveFile);
			alignDriveFile();

		}

		//===================== start, out motion =====================

		private function startMotion():void {

			appArea.visible = true;

			TweenNano.to(appArea, 1, {alpha: 1, onComplete: startMotionComplete});

		}

		private function outMotion():void {


		}

		//===================== start, out motion complete =====================

		private function startMotionComplete():void {

			inMotionFinished();

		}

		private function outMotionComplete():void {

			removeAllDriveFile();

			appArea.visible = false;

			outMotionFinished();

		}

		//===================== obj reference =====================
		
		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}
		
		private function get driveListInfoDataObj():DriveListInfoData {
			
			return googleInfoProxyObj.getData(DataName.DRIVE_LIST_INFO) as DriveListInfoData;
			
		}


	}
}
