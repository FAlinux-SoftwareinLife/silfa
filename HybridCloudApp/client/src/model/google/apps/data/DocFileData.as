package model.google.apps.data {

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestHeader;
	
	import abstracts.AppsDataAbstract;
	
	import identifier.DataName;
	import identifier.FileName;
	import identifier.ProxyName;
	
	import info.GoogleHTTPRequestInfo;
	
	import manager.model.IData;
	import manager.model.ModelManager;
	
	import model.google.apps.GoogleAppsProxy;
	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.OAuthInfoData;
	
	import utils.FileUpload;
	import utils.Tracer;

	public class DocFileData extends AppsDataAbstract implements IData {

		private const DATA_NAME:String = DataName.DOC_FILE;

		private var result:Object;

		public function DocFileData() {

			result = {type: DATA_NAME, data: ""};

		}

		public function get name():String {

			return DATA_NAME;

		}

		public function requestData():void {

			requestDocData();

		}

		private function requestDocData():void {

			var _token:String;
			var _header:URLRequestHeader;
			var _loader:URLLoader;
			var _fileUpload:FileUpload = new FileUpload();
			var _docData:Object = {title: FileName.DOCUMENT, mimeType: GoogleHTTPRequestInfo.MIME_TYPE_DOC}

			_token = oauthInfoDataObj.getAccessToken();

			_header = new URLRequestHeader();
			_header.name = headerNameAuth;
			_header.value = headerValueAuth + _token;

			_fileUpload.addVariable("", JSON.stringify(_docData));

			_fileUpload.requestHeaders.push(_header);
			_fileUpload.dataFormat = URLLoaderDataFormat.BINARY;
			_fileUpload.load(GoogleHTTPRequestInfo.DRIVE_FILE);

			_fileUpload.addEventListener(Event.COMPLETE, loaderComplete);

		}

		public function parseData(data:Object):void {
		}

		private function loaderComplete(evt:Event):void {

			var _data:Object = JSON.parse(evt.currentTarget.loader.data);
			
			result.data = _data;
			
			sendProxy();

		}
		
		private function sendProxy():void {
			
			googleAppsProxyObj.resultData(result);
			
		}

		private function get oauthInfoDataObj():OAuthInfoData {

			return googleInfoProxyObj.getData(DataName.OAUTH_INFO) as OAuthInfoData;

		}

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}
		
		private function get googleAppsProxyObj():GoogleAppsProxy {
			
			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_APPS) as GoogleAppsProxy;
			
		}

	}
}
