package manager.controller {

	public interface ICommand {

		function get name():String;
		function execute():void;
		
	}
}
