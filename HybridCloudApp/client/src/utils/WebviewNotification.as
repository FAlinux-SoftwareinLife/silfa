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

		private var endPoint:String;

		public function WebviewNotification(blockWebviewNotification:BlockWebviewNotification) {


		}

		public function arriveOfAddress(swv:StageWebView, endPoint:String):void {

			this.endPoint = endPoint;
			swv.addEventListener(Event.COMPLETE, swvCompleteHandler);

		}

		private function swvCompleteHandler(evt:Event):void {

			var _url:String = evt.target.location;
			var _host:String = getLocationHost(_url);
			var _query:String = getLocationQuery(_url);

			trace("_url = " + _url);
			trace("host = " + _host);
			trace("query = " + _query);

			if (_host == endPoint) {

				evt.target.removeEventListener(Event.COMPLETE, swvCompleteHandler);

				trace("ok endPoint");

				var _paramObj:Object = {query: _query}

				dispatchEvent(new WebviewEvent(WebviewEvent.END_POINT_COMPLETE, _paramObj));

			}

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
