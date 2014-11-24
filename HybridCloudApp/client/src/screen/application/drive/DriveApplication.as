package screen.application.drive {

	import com.greensock.TweenNano;
	import com.greensock.easing.Sine;

	import flash.display.MovieClip;

	import abstracts.ApplicationAbstract;

	import events.TitleAreaMouseEvent;

	import identifier.ApplicationName;
	import identifier.DataName;
	import identifier.ProxyName;
	import identifier.ScreenName;

	import manager.model.ModelManager;
	import manager.screen.ScreenManager;

	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.DriveListInfoData;

	import screen.loading.LoadingMediator;

	import utils.ContentScroll;

	public class DriveApplication extends ApplicationAbstract {

		private const APP_NAME:String = ApplicationName.DRIVE;

		private var driveFileArea:MovieClip;
		private var driveMask:MovieClip;

		private var driveFileInfoList:Vector.<Object>;
		private var driveFile_num:int;

		private const FILE_DIFFER_HEIGHT:Number = 5;

		private var contentScroll:ContentScroll;

		private var driveFileAreaOldY:Number;

		public function DriveApplication() {

			super(APP_NAME);

		}

		override protected function initDisplayObj():void {

			driveFileArea = appArea.getChildByName("driveFileArea") as MovieClip;
			driveMask = appArea.getChildByName("driveMask") as MovieClip;

			contentScroll = new ContentScroll();
			contentScroll.init(appArea.scrollBar, appArea.scrollBg, driveFileArea, driveMask);

			driveFileAreaOldY = driveFileArea.y;

		}

		override public function startApp():void {
			trace(this, "startApp");
			startMotion();

		}

		override public function exitApp():void {
			trace(this, "exitApp");
			outMotion();

		}

		//===================== set drive file =====================

		/**
		 * Set 'DriveFile' list
		 *
		 */
		private function initDriveFileList():void {

			driveFileInfoList = driveListInfoDataObj.getFileList() as Vector.<Object>;
			driveFile_num = driveFileInfoList.length;

			//drvie file 없을 경우 체크

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

			}

		}

		private function refreshFileName():void {

			var _driveFileAreaNum:uint = driveFileArea.numChildren;

			for (var j:uint = 0; j < _driveFileAreaNum; j++)
				driveFileArea.getChildAt(j).name = "driveFile" + String(j);

		}

		//===================== drive file position =====================

		private function setPosition():void {

			driveFile_num = driveFileArea.numChildren;

			for (var i:uint = 0; i < driveFile_num; i++) {

				var _driveFile:DriveFile = driveFileArea.getChildAt(i) as DriveFile;
				var _prevDriveFile:DriveFile = driveFileArea.getChildAt(i == 0 ? i : i - 1) as DriveFile;

				var _titleArea:MovieClip = _driveFile.getChildByName("titleArea") as MovieClip;
				var _contentArea:MovieClip = _driveFile.getChildByName("contentArea") as MovieClip;

				_driveFile.prevFile = _prevDriveFile;

				_driveFile.tx = 0;

				if (i != 0) {

					if (_prevDriveFile.isOpen) {

						_driveFile.ty = _prevDriveFile.ty + _prevDriveFile.titleArea.height + _prevDriveFile.contentArea.height + FILE_DIFFER_HEIGHT;


					} else {

						_driveFile.ty = _prevDriveFile.ty + _prevDriveFile.titleArea.y + _prevDriveFile.titleArea.height + FILE_DIFFER_HEIGHT;
							//_driveFile.y = _prevDriveFile.y + _prevDriveFile.titleArea.y + _prevDriveFile.titleArea.height + FILE_DIFFER_HEIGHT;
					}

				} else {

					_driveFile.ty = 0;

				}

			}

		}

		private function initPosition(driveFileList:Array):void {

			var driveFileList_num:uint = driveFileList.length;
			driveFile_num = driveFileArea.numChildren;

			for (var i:uint = 0; i < driveFile_num; i++) {

				var _driveFile:DriveFile = driveFileArea.getChildAt(i) as DriveFile;

				for (var j:uint = 0; j < driveFileList_num; j++) {

					var _selDriveFile:DriveFile = driveFileList[j] as DriveFile;
					var _prevSelDriveFile:DriveFile = _selDriveFile.prevFile as DriveFile;
					var _titleArea:MovieClip = _selDriveFile.getChildByName("titleArea") as MovieClip;
					var _contentArea:MovieClip = _selDriveFile.getChildByName("contentArea") as MovieClip;

					if (_driveFile == _selDriveFile) {

						_selDriveFile.x = _selDriveFile.width;

						_selDriveFile.y = (_titleArea.height + FILE_DIFFER_HEIGHT) * i;

					}

				}

			}

		}

		//===================== drive file Motion =====================

		private function TAPosition(delay:Number = 0, completeOpen:Boolean = false):void {

			driveFile_num = driveFileArea.numChildren;

			for (var i:uint = 0; i < driveFile_num; i++) {

				var _driveFile:DriveFile = driveFileArea.getChildAt(i) as DriveFile;

				TweenNano.to(_driveFile, .4, {alpha: 1, delay: 0.1 * i + delay, ease: Sine.easeOut,

						onComplete: i == driveFile_num - 1 && completeOpen ? loadingMediatorObj.closeLoading : null

					});

			}

		}

		private function TXPosition(delay:Number = 0, completeOpen:Boolean = false):void {

			driveFile_num = driveFileArea.numChildren;

			for (var i:uint = 0; i < driveFile_num; i++) {

				var _driveFile:DriveFile = driveFileArea.getChildAt(i) as DriveFile;

				TweenNano.to(_driveFile, .4, {x: _driveFile.tx, delay: 0.1 * i + delay, ease: Sine.easeOut,

						onComplete: i == driveFile_num - 1 && completeOpen ? loadingMediatorObj.closeLoading : null

					});

			}

		}

		private function TYPosition(delay:Number = 0, downOpen:Boolean = false, completeOpen:Boolean = false):void {

			driveFile_num = driveFileArea.numChildren;

			for (var i:uint = 0; i < driveFile_num; i++) {

				var _driveFile:DriveFile = driveFileArea.getChildAt(i) as DriveFile;

				var _delay:Number = downOpen ? 0.1 * ((driveFile_num - 1) - i) + delay : delay;


				TweenNano.to(_driveFile, .4, {y: _driveFile.ty, delay: _delay, ease: Sine.easeOut,

						onComplete: i == driveFile_num - 1 && completeOpen ? loadingMediatorObj.closeLoading : null

					});

			}

		}

		private function driveFileOpen(delay:Number = 0, completeOpen:Boolean = false):void {

			contentScroll.visibleScroll(false);
			
			driveFile_num = driveFileArea.numChildren;

			for (var i:uint = 0; i < driveFile_num; i++) {

				var _driveFile:DriveFile = driveFileArea.getChildAt(i) as DriveFile;
				var _titleArea:MovieClip = _driveFile.getChildByName("titleArea") as MovieClip;
				var _contentArea:MovieClip = _driveFile.getChildByName("contentArea") as MovieClip;

				var _targetY:Number = _driveFile.isOpen ? _titleArea.height : -_contentArea.height + _titleArea.height;

				TweenNano.to(_contentArea, .4, {y: _targetY, delay: delay, ease: Sine.easeOut,

						onComplete: driveFileOpenComplete, onCompleteParams: [i, completeOpen]

					});

			}

		}

		private function driveFileOpenComplete(checkNum:uint, completeOpen:Boolean):void {
			
			contentScroll.visibleScroll(true);
			
			if (checkNum == driveFile_num - 1 && completeOpen) {

				loadingMediatorObj.closeLoading();

			}

		}

		private function driveFileDelete(delList:Vector.<DriveFile>):void {

			var driveFile_num:uint = delList.length;

			for (var i:uint = 0; i < driveFile_num; i++)
				TweenNano.to(delList[i], .3, {alpha: 0, x: delList[i].x + 30, y: delList[i].y + 30, scaleX: .8, scaleY: .8, ease: Sine.easeOut, onComplete: i == driveFile_num - 1 ? removeComplete : null, onCompleteParams: [delList[i]]});

		}

		//===================== add remove drive file =====================

		/**
		 * Add 'DriveFile'
		 * @param idList 'DriveFile' ID list.
		 *
		 */
		public function addDriveFile(idList:Array):void {

			var _addList:Vector.<Object> = new Vector.<Object>();

			var _driveFileList:Array = new Array();

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
				var _titleArea:MovieClip = _driveFile.getChildByName("titleArea") as MovieClip;
				var _contentArea:MovieClip = _driveFile.getChildByName("contentArea") as MovieClip;

				_driveFile.alpha = 0;
				_contentArea.y = -_contentArea.height + _titleArea.height;

				_driveFileList.push(_driveFile);

				driveFileArea.addChildAt(_driveFile, 0);

				_driveFile.addEventListener(TitleAreaMouseEvent.TITLE_AREA_CLICK, titleAreaMouseHandler);

			}

			refreshFileName();

			visibleDriveFile();

			setPosition();

			initPosition(_driveFileList);


			loadingMediatorObj.openLoading();

			TAPosition(0);

			if (idList.length > 1) {

				TXPosition(0);
				TYPosition(0.8, true, false);
				driveFileOpen(1.1, true);

			} else {

				TYPosition(0);
				driveFileOpen(0);
				TXPosition(0, true);

			}

			TweenNano.to(driveFileArea, 0.6, {y: driveFileAreaOldY, ease: Sine.easeOut});

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

				var _deleteTX:Number = driveFileArea.x + _deleteDriveFile.x;
				var _deleteTY:Number = driveFileArea.y + _deleteDriveFile.y;

				appArea.addChildAt(_deleteDriveFile, appArea.getChildIndex(driveFileArea));

				_deleteDriveFile.x = _deleteTX;
				_deleteDriveFile.y = _deleteTY;

//				TweenNano.to(_deleteDriveFile, 1, {y: _deleteDriveFile.y + _deleteDriveFile.height, scaleY: 0, onComplete: removeComplete, onCompleteParams: [_deleteDriveFile]});

			}

			refreshFileName();

			visibleDriveFile();

			setPosition();


			loadingMediatorObj.openLoading();

			driveFileDelete(_deleteFileList);
			TYPosition(0);
			driveFileOpen(0);
			
			TweenNano.to(driveFileArea, 0.6, {y: driveFileAreaOldY, ease: Sine.easeOut});

		}

		private function removeComplete(delFile:DriveFile):void {

			appArea.removeChild(delFile);
			delFile = null;

			loadingMediatorObj.closeLoading();

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

			setPosition();
			TYPosition();
			driveFileOpen();

		}

		//===================== start, out motion =====================

		private function startMotion():void {

			appArea.visible = true;
			appArea.alpha = 1;

			startMotionComplete();

			//TweenNano.to(appArea, 1, {alpha: 1, onComplete: startMotionComplete});

		}

		private function outMotion():void {

			TweenNano.to(appArea, 1, {alpha: 0, onComplete: outMotionComplete});

		}

		//===================== start, out motion complete =====================

		private function startMotionComplete():void {

			inMotionFinished();

			initDriveFileList();

			contentScroll.visibleScroll(true);

		}

		private function outMotionComplete():void {

			resetDriveFile();

			appArea.visible = false;

			contentScroll.visibleScroll(false);

			outMotionFinished();

		}

		//===================== reset =====================


		public function resetDriveFile():void {

			removeAllDriveFile();

		}

		//===================== obj reference =====================

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

		private function get driveListInfoDataObj():DriveListInfoData {

			return googleInfoProxyObj.getData(DataName.DRIVE_LIST_INFO) as DriveListInfoData;

		}

		private function get loadingMediatorObj():LoadingMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOADING) as LoadingMediator;

		}



	}
}
