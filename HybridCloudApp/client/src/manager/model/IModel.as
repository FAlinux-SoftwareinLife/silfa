package manager.model {

	public interface IModel {

		function get name():String;
		function requestData(name:String):void;// request data
		function resultData(result:Object):void;// dispatch event
		function setData(dataObj:Object):void; // set data
		function getData(name:String):IData; // get data
		
	}

}

