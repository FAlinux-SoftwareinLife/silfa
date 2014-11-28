package model.db.arm {

	import abstracts.ModelProxyAbstract;
	
	import events.ArmEvent;
	
	import identifier.DataName;
	import identifier.ProxyName;
	
	import manager.model.IData;
	import manager.model.IModel;
	
	import model.db.arm.data.InsertDriveFileData;
	import model.db.arm.data.InsertMeasureData;
	import model.db.arm.data.InsertProfileData;
	import model.db.arm.data.ReceiveDriveFileData;
	import model.db.arm.data.ReceiveProfileData;


	public class ArmServerProxy extends ModelProxyAbstract implements IModel {

		private const MODEL_NAME:String = ProxyName.ARM_SERVER;

		private const ARM_DATA_LIST:Vector.<Object> = Vector.<Object>([

			new InsertProfileData, new ReceiveProfileData, new InsertDriveFileData, new ReceiveDriveFileData, new InsertMeasureData

			]);

		public function ArmServerProxy() {
		}

		public function get name():String {
			return MODEL_NAME;
		}

		public function requestData(name:String):void {

			for each (var _data:IData in ARM_DATA_LIST)
				if (name == _data.name)
					_data.requestData();

		}

		public function resultData(result:Object):void {

			switch (result.type) {

				case DataName.INSERT_PROFILE:

					dispatchEvent(new ArmEvent(ArmEvent.INSERT_PROFILE_COMPLETE, result.data));

					break;

				case DataName.RECEIVE_PROFILE:

					dispatchEvent(new ArmEvent(ArmEvent.RECEIVE_PROFILE_COMPLETE, result.data));

					break;

				case DataName.INSERT_DRIVE_FILE:

					dispatchEvent(new ArmEvent(ArmEvent.INSERT_DRIVE_FILE_COMPLETE, result.data));

					break;

				case DataName.RECEIVE_DRIVE_FILE:

					dispatchEvent(new ArmEvent(ArmEvent.RECEIVE_DRIVE_FILE_COMPLETE, result.data));

					break;

				case DataName.INSERT_MEASURE:

					dispatchEvent(new ArmEvent(ArmEvent.INSERT_MEASURE_COMPLETE, result.data));

					break;

				case DataName.RECEIVE_MEASURE:

					dispatchEvent(new ArmEvent(ArmEvent.RECEIVE_MEASURE_COMPLETE, result.data));

					break;

			}

		}

		public function setData(dataObj:Object):void {
			
			for each (var _data:IData in ARM_DATA_LIST)
				if (dataObj.name == _data.name)
					_data.parseData(dataObj.data);
				
		}

		public function getData(name:String):IData {

			var _selData:IData;

			for each (var _data:IData in ARM_DATA_LIST)
				if (name == _data.name)
					_selData = _data;

			return _selData;

		}
	}
}
