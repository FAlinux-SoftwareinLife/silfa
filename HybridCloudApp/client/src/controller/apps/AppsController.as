package controller.apps {


	import controller.apps.command.CreateDriveFileCommand;
	import controller.apps.command.DriveFileTrashCommand;
	import controller.apps.command.DriveListCommand;
	import controller.apps.command.ProfileCommand;

	import identifier.CommandName;
	import identifier.ControllerName;

	import manager.controller.ICommand;
	import manager.controller.IController;

	public class AppsController implements IController {

		private const CONTROLLER_NAME:String = ControllerName.APPS;

		private const APP_COMMAND_LIST:Vector.<ICommand> = Vector.<ICommand>([

			new ProfileCommand, new DriveListCommand, new DriveFileTrashCommand, new CreateDriveFileCommand

			]);

		public function AppsController() {

		}


		public function get name():String {

			return CONTROLLER_NAME;

		}

		public function setExecute(executeObj:Object):void {

			switch (executeObj.type) {

				case "getUserProfile":

					getCommand(CommandName.PROFILE).execute();

					break;

				case "getFileList":

					getCommand(CommandName.DRIVE_LIST).execute();

					break;

				case "driveFileTrash":

					getCommand(CommandName.DRIVE_FILE_TRASH).execute(executeObj.param);

					break;

				case "createDoc":
				case "createSpr":
				case "createPre":
					
					getCommand(CommandName.CREATE_DRIVE_FILE).execute(executeObj.param);

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
