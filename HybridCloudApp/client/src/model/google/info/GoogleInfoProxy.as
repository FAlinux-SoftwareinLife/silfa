package model.google.info {

	import abstracts.ModelProxyAbstract;
	
	import events.OAuthEvent;
	
	import identifier.DataName;
	import identifier.ProxyName;
	
	import manager.model.IData;
	import manager.model.IModel;
	
	import model.google.info.data.DriveListInfoData;
	import model.google.info.data.OAuthInfoData;
	import model.google.info.data.ProfileInfoData;

	public class GoogleInfoProxy extends ModelProxyAbstract implements IModel {

		private const MODEL_NAME:String = ProxyName.GOOGLE_INFO;

		private const INFO_DATA_LIST:Vector.<IData> = Vector.<IData>([

			new OAuthInfoData, new ProfileInfoData, new DriveListInfoData

			]);

		public function GoogleInfoProxy() {

		}


		public function get name():String {
			return MODEL_NAME;
		}

		public function requestData(name:String):void {

			for each (var _data:IData in INFO_DATA_LIST)
				if (name == _data.name)
					_data.requestData();

		}

		public function resultData(result:Object):void {
			
			switch (result.type) {
				
				case DataName.OAUTH_INFO:
					
					dispatchEvent(new OAuthEvent(OAuthEvent.SET_LOGIN_COMPLETE, result));
					
					break;
				
			}
			
		}

		public function setData(dataObj:Object):void {

			for each (var _data:IData in INFO_DATA_LIST)
				if (dataObj.name == _data.name)
					_data.parseData(dataObj.data);

		}

		public function getData(name:String):IData {

			var _selData:IData;

			for each (var _data:IData in INFO_DATA_LIST)
				if (name == _data.name)
					_selData = _data;

			return _selData;

		}

	}
}
