package manager.controller {

	public interface ICommand {

		function get name():String;
		function execute(obj:Object = null):void;
		
	}
}
