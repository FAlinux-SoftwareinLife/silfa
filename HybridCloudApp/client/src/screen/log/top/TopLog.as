package screen.log.top {

	import com.greensock.TweenNano;

	import flash.display.MovieClip;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.text.TextField;

	import abstracts.LogAbstract;
	import abstracts.SendLogAbstract;

	import identifier.LogName;

	import screen.log.top.log.WebTopLog;

	public class TopLog extends LogAbstract {

		private const LOG_NAME:String = LogName.TOP;

		private const LOG_TEXT_DIFFERH:Number = 10;
		private const WINDOW_DIFFERX:Number = 20;
		private const WINDOW_WIDTH:Number = 500;
		private const WINDOW_HEIGHT:Number = Capabilities.screenResolutionY - 100;
		private const OPEN_TEXT:String = "OPEN LOG POPUP";
		private const CLOSE_TEXT:String = "CLOSE LOG POPUP";

		private const TOP_LOG_LIST:Vector.<SendLogAbstract> = Vector.<SendLogAbstract>([

			new WebTopLog

			]);

		private const buttonList:Vector.<Object> = Vector.<Object>([

			{name: "windowOpen", func: windowOpenBtnExecute}, {name: "clear", func: clearBtnExecute}

			]);

		private var openPopupTxt:TextField;

		private var windowLog:NativeWindow;
		private var windowOpen:Boolean;
		private var windowLogTxtArea:WindowLogTxtArea;

		public function TopLog() {

			super(LOG_NAME);

			windowOpen = false;

		}

		override protected function initButton():void {

			for each (var _btnObj:Object in buttonList) {

				var _btnName:String = _btnObj.name as String;
				var _func:Function = _btnObj.func as Function;

				var _btn:MovieClip = logArea.getChildByName(_btnName + "Btn") as MovieClip;

				_btn.func = _func;

				if (_btnName == "windowOpen")
					openPopupTxt = _btn.openPopupTxt as TextField;

				_btn.buttonMode = true;
				_btn.mouseChildren = false;
				_btn.addEventListener(MouseEvent.MOUSE_OVER, logAreaBtnMouseHandler);
				_btn.addEventListener(MouseEvent.MOUSE_OUT, logAreaBtnMouseHandler);
				_btn.addEventListener(MouseEvent.MOUSE_DOWN, logAreaBtnMouseHandler);

			}

		}

		private function logAreaBtnMouseHandler(evt:MouseEvent):void {

			var _btn:MovieClip = evt.currentTarget as MovieClip;

			switch (evt.type) {

				case MouseEvent.MOUSE_OVER:

					TweenNano.to(_btn, 0.4, {alpha: 1});

					break;

				case MouseEvent.MOUSE_OUT:

					TweenNano.to(_btn, 0.4, {alpha: 0});

					break;

				case MouseEvent.MOUSE_DOWN:

					_btn.func();

					break;

			}

		}

		override public function updateLog(log:String):void {

			addLog(log);

		/*
		for each (var _logObj:SendLogAbstract in TOP_LOG_LIST)
			if (_logObj.name == name)
				addLog(_logObj.getLog(type) + (other == "" ? "" : "\n" + other));
		*/

		}

		private function addLog(log:String):void {

			logTxt.appendText(log + "\n");

			if (windowLogTxtArea !== null)
				windowLogTxtArea.logTxt.text = logTxt.text;

			if (logTxt.textHeight > logTxtOldH)
				logTxt.height = logTxt.textHeight + LOG_TEXT_DIFFERH;

			logTxt.y = logTxtOldY - (logTxt.textHeight - logTxtOldH);

		}

		private function windowOpenBtnExecute():void {

			windowOpen ? offWindow() : onWindow();

		}

		private function clearBtnExecute():void {

			logTxt.text = "";

			if (windowLogTxtArea !== null)
				windowLogTxtArea.logTxt.text = "";

		}

		private function onWindow():void {

			initWindow();

			setWindow();

			windowLog.activate();

			windowOpen = true;

			openPopupTxt.text = CLOSE_TEXT;

		}

		private function offWindow():void {

			windowLog.stage.removeChild(windowLogTxtArea);
			windowLogTxtArea = null;

			windowLog.close();

			windowOpen = false;

			openPopupTxt.text = OPEN_TEXT;

		}

		private function initWindow():void {

			var _nativeWindow:NativeWindow = logArea.stage.nativeWindow as NativeWindow;

			var _initOpt:NativeWindowInitOptions = new NativeWindowInitOptions();
			_initOpt.minimizable = _initOpt.maximizable = false;
			_initOpt.resizable = false;

			windowLog = new NativeWindow(_initOpt);

			windowLog.stage.scaleMode = StageScaleMode.NO_SCALE;
			windowLog.stage.align = StageAlign.TOP_LEFT;

			windowLog.title = "WindowLog";

			windowLog.x = _nativeWindow.x + _nativeWindow.width + WINDOW_DIFFERX;
			windowLog.y = _nativeWindow.y;
			windowLog.width = WINDOW_WIDTH;
			windowLog.height = WINDOW_HEIGHT;

			windowLog.addEventListener(Event.CLOSE, windowLogHandler);

		}

		private function setWindow():void {

			windowLogTxtArea = new WindowLogTxtArea();

			windowLog.stage.addChild(windowLogTxtArea);

			windowLogTxtArea.logTxt.text = logTxt.text;

		}

		private function windowLogHandler(evt:Event):void {

			switch (evt.type) {

				case Event.CLOSE:

					windowOpen ? offWindow() : null;

					break;

			}

		}

	}
}

