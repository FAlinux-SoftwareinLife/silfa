package manager.model {

	public interface IData {

		function get name():String;
		function requestData():void;
		function parseData(data:Object):void;
		
	}
}
