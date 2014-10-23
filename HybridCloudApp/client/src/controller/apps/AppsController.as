package controller.apps {

	import controller.apps.command.DocCommand;
	import controller.apps.command.ListCommand;
	import controller.apps.command.PresentCommand;
	import controller.apps.command.ProfileCommand;
	import controller.apps.command.SpreadCommand;
	
	import identifier.CommandName;
	import identifier.ControllerName;
	
	import manager.controller.ICommand;
	import manager.controller.IController;

	public class AppsController implements IController {

		private const CONTROLLER_NAME:String = ControllerName.APPS;

		private var APP_COMMAND_LIST:Vector.<ICommand> = Vector.<ICommand>([

			new ProfileCommand, new ListCommand, new DocCommand, new SpreadCommand, new PresentCommand

			]);

		public function AppsController() {

		}


		public function get name():String {

			return CONTROLLER_NAME;

		}

		public function setExecute(executeType:String):void {

			switch (executeType) {

				case "getUserProfile":

					getCommand(CommandName.PROFILE).execute();

					break;
				
				case "getFileList":
					
					getCommand(CommandName.LIST).execute();
					
					break;
				
				case "createDoc":
					
					getCommand(CommandName.DOC).execute();
					
					break;
				
				case "createSpr":
					
					getCommand(CommandName.SPREAD).execute();
					
					break;
				
				case "createPre":
					
					getCommand(CommandName.PRESENT).execute();
					
					break;

			}

		}

		private function getCommand(commandId:String):ICommand {

			var _selectCommand:ICommand;

			for each (var _command:ICommand in APP_COMMAND_LIST)
				if (commandId == _command.name)
					_selectCommand = _command as ICommand;

			return _selectCommand;

		}

	}
}
