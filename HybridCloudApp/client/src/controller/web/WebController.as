package controller.web {

	import controller.web.command.WebLoginCommand;
	import controller.web.command.WebRPDriveCalendarCommand;
	import controller.web.command.WebRPGmailCommand;

	import identifier.CommandName;
	import identifier.ControllerName;

	import manager.controller.ICommand;
	import manager.controller.IController;

	public class WebController implements IController {

		private const CONTROLLER_NAME:String = ControllerName.WEB;

		private const INFO_COMMAND_LIST:Vector.<ICommand> = Vector.<ICommand>([

			new WebLoginCommand, new WebRPGmailCommand, new WebRPDriveCalendarCommand

			]);

		public function WebController() {
		}

		public function get name():String {

			return CONTROLLER_NAME;

		}

		public function setExecute(executeObj:Object):void {

			switch (executeObj.type) {

				case "login":

					getCommand(CommandName.WEB_LOGIN).execute();

					break;

				case "rpGmail":

					getCommand(CommandName.WEB_RP_GMAIL).execute();

					break;

				case "rpDriveCalendar":

					getCommand(CommandName.WEB_RP_DRIVE_CALENDAR).execute();

					break;

			}

		}

		private function getCommand(commandId:String):ICommand {

			var _selectCommand:ICommand;

			for each (var _command:ICommand in INFO_COMMAND_LIST)
				if (commandId == _command.name)
					_selectCommand = _command as ICommand;

			return _selectCommand;

		}

	}
}
