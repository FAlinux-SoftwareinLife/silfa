package screen.application.drive {

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;

	import controller.apps.AppsController;

	import events.TitleAreaMouseEvent;

	import identifier.ControllerName;
	import identifier.DataName;

	import manager.controller.ControllerManager;

	public class DriveFile extends DriveFileObj {

		private var _infoObj:Object;
		private var _isOpen:Boolean;
		private var _prevDriveFile:DriveFile;

		private const THUMB_FRAME_DIFFER:Number = 7;
		private const BUTTON:Object = {TITLE: "titleArea", OPEN: "openBtn", EDIT: "editBtn", DOWN: "downBtn", TRASH: "trashBtn"};

		public function DriveFile(infoObj:Object) {

			this._infoObj = infoObj;

			init();

		}

		/**
		 * Initialize 'DriveFile' 
		 * 
		 */
		public function init():void {

			_isOpen = false;

			var _filenameTxt:TextField = titleArea.getChildByName("filenameTxt") as TextField;
			var _fileIconArea:MovieClip = titleArea.getChildByName("fileIconArea") as MovieClip;
			var _dateTxt:TextField = contentArea.getChildByName("dateTxt") as TextField;
			var _thumbArea:MovieClip = contentArea.getChildByName("thumbArea") as MovieClip;

			var _openBtn:MovieClip = contentArea.getChildByName("openBtn") as MovieClip;
			var _editBtn:MovieClip = contentArea.getChildByName("editBtn") as MovieClip;
			var _downBtn:MovieClip = contentArea.getChildByName("downBtn") as MovieClip;
			var _trashBtn:MovieClip = contentArea.getChildByName("trashBtn") as MovieClip;

			_filenameTxt.text = this._infoObj.title;
			_dateTxt.text = this._infoObj.modifiedDate;


			titleArea.mouseChildren = false;
			titleArea.buttonMode = true;
			titleArea.addEventListener(MouseEvent.CLICK, fileButtonMouseHandler);

			_trashBtn.buttonMode = true;
			_trashBtn.addEventListener(MouseEvent.CLICK, fileButtonMouseHandler);

			if (this._infoObj.embedLink != "") {
				_openBtn.buttonMode = true;
				_openBtn.openURL = this._infoObj.embedLink;
				_openBtn.addEventListener(MouseEvent.CLICK, fileButtonMouseHandler);
			}

			if (this._infoObj.alternateLink != "") {
				_editBtn.buttonMode = true;
				_editBtn.openURL = this._infoObj.alternateLink;
				_editBtn.addEventListener(MouseEvent.CLICK, fileButtonMouseHandler);
			}

			if (this._infoObj.pdfLink != "") {
				_downBtn.buttonMode = true;
				_downBtn.openURL = this._infoObj.pdfLink;
				_downBtn.addEventListener(MouseEvent.CLICK, fileButtonMouseHandler);
			}

			setFileIcon(_fileIconArea, this._infoObj.fileType);
			setThumbnail(_thumbArea, this._infoObj.thumbnailLink);

		}

		//===================== set get data =====================

		public function set prevFile(driveFile:DriveFile):void {

			_prevDriveFile = driveFile;

		}

		public function set isOpen(b:Boolean):void {

			_isOpen = b;

		}

		public function get isOpen():Boolean {

			return _isOpen;

		}
		
		public function get infoObj():Object {

			return this._infoObj;

		}

		//===================== parse file data =====================

		private function setFileIcon(fileIconArea:MovieClip, fileType:String):void {

			for each (var _icon:MovieClip in fileIconArea)
				_icon.visible = _icon.name == fileType ? true : false;

		}

		//===================== set thumbnail =====================

		private function setThumbnail(thumbArea:MovieClip, thumbnailLink:String):void {

			var _loader:Loader = new Loader();
			thumbArea.addChild(_loader);

			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, thumbnailComplete);

			_loader.load(new URLRequest(thumbnailLink));

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

			_thumbFrame.width = _imgArea.width + THUMB_FRAME_DIFFER;
			_thumbFrame.height = _imgArea.height + THUMB_FRAME_DIFFER;

			_thumbFrameShadow.width = _imgArea.width + THUMB_FRAME_DIFFER;
			_thumbFrameShadow.height = _imgArea.height + THUMB_FRAME_DIFFER;

			_imgArea.x = -_imgArea.width / 2;
			_imgArea.y = -_imgArea.height / 2;

		}

		//===================== button =====================

		private function fileButtonMouseHandler(evt:MouseEvent):void {

			var _btn:MovieClip = evt.currentTarget as MovieClip;

			switch (_btn.name) {

				case BUTTON.TITLE:

					dispatchEvent(new TitleAreaMouseEvent(TitleAreaMouseEvent.TITLE_AREA_CLICK));

					break;

				case BUTTON.OPEN:
				case BUTTON.EDIT:
				case BUTTON.DOWN:

					navigateToURL(new URLRequest(_btn.openURL));

					break;

				case BUTTON.TRASH:

					var _executeObj:Object = {type: DataName.DRIVE_FILE_TRASH, param: {id: this._infoObj.id}};

					appsControllerObj.setExecute(_executeObj);

					break;

			}


		}

		private function get appsControllerObj():AppsController {

			return ControllerManager.controllerManagerObj.getController(ControllerName.APPS) as AppsController;

		}

	}
}
