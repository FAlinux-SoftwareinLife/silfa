package model.google.oauth {

	import abstracts.ModelProxyAbstract;

	import events.OAuthEvent;

	import identifier.DataName;
	import identifier.ProxyName;

	import manager.model.IData;
	import manager.model.IModel;

	import model.google.oauth.data.GoogleLoginData;
	import model.google.oauth.data.OAuthValidationData;
	import model.google.oauth.data.PermissionDriveCalendarData;
	import model.google.oauth.data.PermissionGmailData;

	/**
	 *
	 * The request 'OAuth' data processing.
	 *
	 */
	public class GoogleOAuthProxy extends ModelProxyAbstract implements IModel {

		private static const PROXY_NAME:String = ProxyName.GOOGLE_OAUTH;

		private const OAUTH_DATA_LIST:Vector.<IData> = Vector.<IData>([

			new GoogleLoginData,

			new PermissionGmailData,

			new PermissionDriveCalendarData,

			new OAuthValidationData

			]);

		public function GoogleOAuthProxy() {

		}

		public function get name():String {

			return PROXY_NAME;

		}

		/**
		 * Authorization information.
		 * @param name
		 * Request type. ('DataName Class')
		 *
		 */
		public function requestData(name:String):void {

			for each (var _data:IData in OAUTH_DATA_LIST)
				if (name == _data.name)
					_data.requestData();

		}

		/**
		 * Result OAuth data for 'Data Class'.
		 * @param result
		 * result value.
		 *
		 */
		public function resultData(result:Object):void {

			switch (result.type) {

				case DataName.GOOGLE_LOGIN:

					dispatchEvent(new OAuthEvent(OAuthEvent.REQUEST_LOGIN_COMPLETE, result));

					break;

				case DataName.PERMISSION_GMAIL:

					dispatchEvent(new OAuthEvent(OAuthEvent.REQUEST_GMAIL_COMPLETE, result));

					break;

				case DataName.PERMISSION_DRIVE_CALENDAR:

					dispatchEvent(new OAuthEvent(OAuthEvent.REQUEST_DRIVE_CALENDAR_COMPLETE, result));

					break;

				case DataName.OAUTH_VALIDATION:

					dispatchEvent(new OAuthEvent(OAuthEvent.REQUEST_OAUTH_VALIDATION_COMPLETE, result));

					break;

			}


		}

		public function setData(dataObj:Object):void {

			for each (var _data:IData in OAUTH_DATA_LIST)
				if (dataObj.name == _data.name)
					_data.parseData(dataObj.data);

		}

		public function getData(name:String):IData {

			var _selData:IData;

			for each (var _data:IData in OAUTH_DATA_LIST)
				if (name == _data.name)
					_selData = _data;

			return _selData;

		}

	}
}
