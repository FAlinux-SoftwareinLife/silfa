package model.db.info {
	import flash.events.IEventDispatcher;
	
	import abstracts.ModelProxyAbstract;
	
	import identifier.ProxyName;
	
	import manager.model.IData;
	import manager.model.IModel;
	
	import model.db.info.data.ADFInfoData;
	import model.db.info.data.APInfoData;

	public class InfoProxy extends ModelProxyAbstract implements IModel {
		
		private const MODEL_NAME:String = ProxyName.INFO;
		
		private const INFO_DATA_LIST:Vector.<Object> = Vector.<Object>([
			
			new APInfoData, new ADFInfoData
			
		]);
		
		public function InfoProxy(target:IEventDispatcher = null) {
			
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
