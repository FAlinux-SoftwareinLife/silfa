package controller.arm.command {
	import abstracts.CommandAbstract;
	
	import identifier.CommandName;
	
	import manager.controller.ICommand;

	public class RequestMeasureCommand extends CommandAbstract implements ICommand {
		
		private static const COMMAND_NAME:String = CommandName.REQUEST_MEASURE;
		
		public function RequestMeasureCommand() {
			
		}

		public function get name():String {
			return COMMAND_NAME;
		}

		public function execute(obj:Object = null):void {
			trace(this);
		}
	}
}
