package utils {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.StageWebView;
	
	import events.WebviewEvent;

	/**
	 * Can be generated in the 'StageWebView' movement path specified event.
	 *
	 */
	public class WebviewNotification extends EventDispatcher {

		private static var webviewNotification:WebviewNotification;

		private var hostStartStr:String = "//";
		private var hostEndStr:String = "/";
		private var queryStartStrList:Vector.<String> = Vector.<String>(["?", "#"]);

		private var firstOpen:Boolean;
		private var endOpen:Boolean;

		private var endPoint:String;

		public function WebviewNotification(blockWebviewNotification:BlockWebviewNotification) {

			firstOpen = endOpen = false;

		}

		public function firstOfAddress(swv:StageWebView):void {

			firstOpen = true;

			swv.addEventListener(Event.COMPLETE, swvCompleteHandler);

		}

		public function arriveOfAddress(swv:StageWebView, endPoint:String):void {

			endOpen = true;

			this.endPoint = endPoint;
			swv.addEventListener(Event.COMPLETE, swvCompleteHandler);

		}

		private function swvCompleteHandler(evt:Event):void {

			var _swv:StageWebView = evt.currentTarget as StageWebView;
			
			var _url:String = _swv.location;
			var _host:String = getLocationHost(_url);
			
			if (firstOpen)
				firstCompleteHander(_swv);

			if (_host == endPoint)
				endCompleteHander(_swv, getLocationQuery(_url));
			
		}
		
		/**
		 * First swv complete event. 
		 * @param swv Event target.
		 * 
		 */
		private function firstCompleteHander(swv:StageWebView):void {
			
			firstOpen = false;
			
			dispatchEvent(new WebviewEvent(WebviewEvent.FIRST_POINT_COMPLETE));
			
			if (!endOpen)
				swv.removeEventListener(Event.COMPLETE, swvCompleteHandler);
		
		}
		
		/**
		 * End swv complete event.
		 * @param swv Event target.
		 * @param query URL query.
		 * 
		 */
		private function endCompleteHander(swv:StageWebView, query:String):void {
			
			endOpen = false;
			
			swv.removeEventListener(Event.COMPLETE, swvCompleteHandler);
			
			var _paramObj:Object = {query: query}
			
			dispatchEvent(new WebviewEvent(WebviewEvent.END_POINT_COMPLETE, _paramObj));
			
		}


		/**
		 * Parse for url.
		 * @param url Parse URL.
		 * @return URL Host string.
		 *
		 */
		private function getLocationHost(url:String):String {

			var _startNum:uint = url.indexOf(hostStartStr) + hostStartStr.length;
			var _endNum:uint = _startNum + url.substr(_startNum).indexOf(hostEndStr);

			return url.substring(_startNum, _endNum);

		}

		/**
		 * Parse for url.
		 * @param url Parse URL.
		 * @return URL Query string.
		 *
		 */
		private function getLocationQuery(url:String):String {

			var _queryStr:String;

			var _queryStartNum:uint;
			var _queryStartStr:String = selectQueryStartStr(url);

			if (_queryStartStr != null) {

				_queryStartNum = url.indexOf(_queryStartStr) + _queryStartStr.length;

				_queryStr = url.substr(_queryStartNum);

			} else {

				_queryStr = "noQuery";

			}

			return _queryStr;

		}

		private function selectQueryStartStr(url:String):String {

			var _selStr:String;

			for each (var _queryStartStr:String in queryStartStrList) {

				if (url.indexOf(_queryStartStr) != -1) {

					_selStr = _queryStartStr;
					break;

				}

			}

			return _selStr;

		}

		public static function get webviewNotificationObj():WebviewNotification {

			if (webviewNotification == null)
				webviewNotification = new WebviewNotification(new BlockWebviewNotification());

			return webviewNotification;

		}

	}
}

/**
 *'WebviewNotification' is not possible to create an instance.
 *
 */
class BlockWebviewNotification {
}
