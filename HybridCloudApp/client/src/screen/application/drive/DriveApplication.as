package screen.application.drive {

	import com.greensock.TweenNano;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;

	import abstracts.ApplicationAbstract;

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

		private const FILE_TYPE_LIST:Vector.<String> = Vector.<String>(["document", "spreadsheet", "presentation", "other"]);

		private const THUMBNAIL_SIZE_LIST:Object = {document: 230, spreadsheet: 230, presentation: 300, other: 230};
		private const THUMBNAIL_GENERAL_ICON_URL:String = "https://ssl.gstatic.com/docs/doclist/images/icon_10_generic_xl128.png";

		private const DOWNLOAD_TYPE:String = "application/pdf";

		private const FILE_DIFFER_HEIGHT:Number = 5;

		private var thumbnailCheck_num:int;

		public function DriveApplication() {

			super(APP_NAME);

		}

		override protected function initDisplayObj():void {

			driveFileArea = appArea.getChildByName("driveFileArea") as MovieClip;

		}

		override public function startApp():void {

			setDriveFileList();

			appArea.visible = true;
			TweenNano.to(appArea, 1, {alpha: 1, onComplete: startMotionComplete});

		}

		override public function exitApp():void {

			TweenNano.to(appArea, 1, {alpha: 0, onComplete: outMotionComplete});

		}

		//===================== set drive file =====================

		private var openNum:int;

		private function setDriveFileList():void {

			driveFileInfoList = driveListInfoDataObj.getFileList() as Vector.<Object>;
			driveFile_num = driveFileInfoList.length;

			Tracer.log("trace", driveFileInfoList);

			for (var i:uint = 0; i < driveFile_num; i++) {

				var _driveFileInfo:Object = driveFileInfoList[i] as Object;
				var _title:String = _driveFileInfo.title;
				var _modifiedDate:String = _driveFileInfo.modifiedDate;
				var _fileType:String = _driveFileInfo.fileType;
				var _alternateLink:String = _driveFileInfo.alternateLink;
				var _embedLink:String = _driveFileInfo.embedLink;
				var _thumbnailLink:String = _driveFileInfo.thumbnailLink;
				var _pdfLink:String = _driveFileInfo.pdfLink;

				var _driveFile:DriveFile = new DriveFile();
				driveFileArea.addChild(_driveFile);

				_driveFile.name = "driveFile" + String(i);

				_driveFile.infoObj = _driveFileInfo;
				_driveFile.isOpen = i == openNum;

				var _titleArea:MovieClip = _driveFile.getChildByName("titleArea") as MovieClip;
				var _fileIconArea:MovieClip = _titleArea.getChildByName("fileIconArea") as MovieClip;
				var _filenameTxt:TextField = _titleArea.getChildByName("filenameTxt") as TextField;

				var _contentArea:MovieClip = _driveFile.getChildByName("contentArea") as MovieClip;
				var _contentMask:MovieClip = _driveFile.getChildByName("contentMask") as MovieClip;
				var _thumbArea:MovieClip = _contentArea.getChildByName("thumbArea") as MovieClip;
				var _dateTxt:TextField = _contentArea.getChildByName("dateTxt") as TextField;
				var _openBtn:MovieClip = _contentArea.getChildByName("openBtn") as MovieClip;
				var _editBtn:MovieClip = _contentArea.getChildByName("editBtn") as MovieClip;
				var _downBtn:MovieClip = _contentArea.getChildByName("downBtn") as MovieClip;
				var _trashBtn:MovieClip = _contentArea.getChildByName("trashBtn") as MovieClip;

				_titleArea.mouseChildren = false;
				_titleArea.buttonMode = true;
				_titleArea.addEventListener(MouseEvent.CLICK, titleAreaMouseHandler);

				_filenameTxt.text = _title;
				_dateTxt.text = _modifiedDate;

				if (_embedLink != "") {
					_openBtn.buttonMode = true;
					_openBtn.openURL = _embedLink;
					_openBtn.addEventListener(MouseEvent.CLICK, openBtnMouseHandler);
				}

				if (_alternateLink != "") {
					_editBtn.buttonMode = true;
					_editBtn.openURL = _alternateLink;
					_editBtn.addEventListener(MouseEvent.CLICK, editBtnMouseHandler);
				}

				if (_pdfLink != "") {
					_downBtn.buttonMode = true;
					_downBtn.openURL = _pdfLink;
					_downBtn.addEventListener(MouseEvent.CLICK, downBtnMouseHandler);
				}

				_trashBtn.buttonMode = true;
				_trashBtn.openURL = _embedLink;
				_trashBtn.addEventListener(MouseEvent.CLICK, trashBtnnMouseHandler);

				setFileIcon(_fileIconArea, _fileType);
				setThumbnail(_thumbArea, _thumbnailLink);

			}

			visibleDriveFile(driveFileArea.getChildAt(0) as DriveFile);
			alignDriveFile();

		}

		private function visibleDriveFile(selectFile:DriveFile):void {

			driveFile_num = driveFileArea.numChildren;

			for (var i:uint = 0; i < driveFile_num; i++) {

				var _driveFile:DriveFile = driveFileArea.getChildAt(i) as DriveFile;
				var _titleArea:MovieClip = _driveFile.getChildByName("titleArea") as MovieClip;
				var _contentArea:MovieClip = _driveFile.getChildByName("contentArea") as MovieClip;

				_driveFile.isOpen = _driveFile == selectFile;
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

						_driveFile.y = _prevDriveFile.y + _prevDriveFile.height + 10;

					} else {

						_driveFile.y = _prevDriveFile.y + _prevDriveFile.titleArea.y + _prevDriveFile.titleArea.height + 10;

					}

				} else {

					_driveFile.y = 0;

				}

			}


		}

		//===================== parse file data =====================

		private function setFileIcon(fileIconArea:MovieClip, fileType:String):void {

			for each (var _icon:MovieClip in fileIconArea)
				_icon.visible = _icon.name == fileType ? true : false;


		}

		private function setThumbnail(thumbArea:MovieClip, thumbnailLink:String):void {

			thumbnailCheck_num = 0;

			var _loader:Loader = new Loader();
			thumbArea.addChild(_loader);

			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, thumbnailComplete);

			_loader.load(new URLRequest(thumbnailLink));

		}

		//===================== button =====================

		private function titleAreaMouseHandler(evt:MouseEvent):void {

			var _titleArea:MovieClip = evt.currentTarget as MovieClip;
			var _driveFile:DriveFile = _titleArea.parent as DriveFile;

			visibleDriveFile(_driveFile);
			alignDriveFile();

		}

		private function openBtnMouseHandler(evt:MouseEvent):void {

			var _openBtn:MovieClip = evt.currentTarget as MovieClip;
			var _openURL:String = _openBtn.openURL;

			navigateToURL(new URLRequest(_openURL));

		}

		private function editBtnMouseHandler(evt:MouseEvent):void {

			var _editBtn:MovieClip = evt.currentTarget as MovieClip;
			var _openURL:String = _editBtn.openURL;

			navigateToURL(new URLRequest(_openURL));

		}

		private function downBtnMouseHandler(evt:MouseEvent):void {

			var _downBtn:MovieClip = evt.currentTarget as MovieClip;
			var _openURL:String = _downBtn.openURL;

			navigateToURL(new URLRequest(_openURL));

		}

		private function trashBtnnMouseHandler(evt:MouseEvent):void {

			var _trashBtn:MovieClip = evt.currentTarget as MovieClip;

		}

		//===================== thumbnail load completed =====================

		private function thumbnailComplete(evt:Event):void {

			var _contentLoaderInfo:LoaderInfo = evt.currentTarget as LoaderInfo;
			var _loader:Loader = _contentLoaderInfo.loader as Loader;
			var _thumbnailImg:Bitmap = _loader.content as Bitmap;
			var _thumbArea:MovieClip = _loader.parent as MovieClip;
			var _imgArea:MovieClip = _thumbArea.getChildByName("imgArea") as MovieClip;
			var _thumbFrame:MovieClip = _thumbArea.getChildByName("thumbFrame") as MovieClip;
			var _thumbFrameShadow:MovieClip = _thumbArea.getChildByName("thumbFrameShadow") as MovieClip;

			_contentLoaderInfo.removeEventListener(Event.COMPLETE, thumbnailComplete);

			for each (var _bitmap:Bitmap in _imgArea)
				_imgArea.removeChild(_bitmap);

			_imgArea.addChild(_thumbnailImg);

			_thumbArea.removeChild(_loader);
			_loader = null;

			_thumbFrame.width = _imgArea.width + 3;
			_thumbFrame.height = _imgArea.height + 3;

			_thumbFrameShadow.width = _imgArea.width + 3;
			_thumbFrameShadow.height = _imgArea.height + 3;

			_imgArea.x = -_imgArea.width / 2;
			_imgArea.y = -_imgArea.height / 2;

			thumbnailCheck_num++;

			if (driveFile_num == thumbnailCheck_num) {

				startMotion();

			}

		}

		//===================== start, out motion =====================

		private function startMotion():void {

		}

		private function outMotion():void {


		}

		//===================== start, out mition complete =====================

		private function startMotionComplete():void {

			inMotionFinished();

		}

		private function outMotionComplete():void {

			appArea.visible = false;

			outMotionFinished();

		}

		//===================== obj reference =====================

		private function get driveListInfoDataObj():DriveListInfoData {

			return googleInfoProxyObj.getData(DataName.DRIVE_LIST_INFO) as DriveListInfoData;

		}

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

	}
}
