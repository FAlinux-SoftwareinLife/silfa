package controller.arm {

	import controller.arm.command.InsertDriveFileCommand;
	import controller.arm.command.InsertProfileCommand;
	import controller.arm.command.RequestDriveFileCommand;
	import controller.arm.command.RequestProfileCommand;
	
	import identifier.CommandName;
	import identifier.ControllerName;
	
	import manager.controller.ICommand;
	import manager.controller.IController;

	public class ArmController implements IController {

		private const CONTROLLER_NAME:String = ControllerName.ARM;
		
		private const ARM_COMMAND_LIST:Vector.<ICommand> = Vector.<ICommand>([
			
			new InsertProfileCommand, new InsertDriveFileCommand, new RequestProfileCommand, new RequestDriveFileCommand
			
		]);
		
		public function ArmController() {
			
		}

		public function get name():String {
			
			return CONTROLLER_NAME;
			
		}

		public function setExecute(executeObj:Object):void {
			
			switch(executeObj.type){
			
				case "profileInfo" :
					
					getCommand(CommandName.INSERT_PROFILE).execute();
					
					break;
				
				case "driveFileInfo" :
					
					getCommand(CommandName.INSERT_DRIVE_FILE).execute();
					
					break;
				
				case "requestProfile" :
					
					getCommand(CommandName.REQUEST_PROFILE).execute();
					
					break;
				
				case "requestDriveFile" :
					
					getCommand(CommandName.REQUEST_DRIVE_FILE).execute();
					
					break;
			
			}
			
		}
		
		private function getCommand(commandId:String):ICommand {
			
			var _selectCommand:ICommand;
			
			for each (var _command:ICommand in ARM_COMMAND_LIST)
			if (commandId == _command.name)
				_selectCommand = _command as ICommand;
			
			return _selectCommand;
			
		}
		
	}
}
