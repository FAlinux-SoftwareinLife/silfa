package screen {

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import manager.screen.IScreen;
	import manager.screen.ScreenManager;
	
	import screen.application.ApplicationMediator;
	import screen.button.ButtonMediator;
	import screen.database.DatabaseMediator;
	import screen.googleapps.GoogleAppsMediator;
	import screen.web.WebMediator;

	/**
	 *
	 * @author Softwareinlife inc.
	 *
	 */
	
	public class ScreenMediator extends Sprite {

		private var moduleStage:DisplayObject;

		private const BUTTON:uint = 0;
		private const APPLICATION:uint = 1;
		private const GOOGLEAPPS:uint = 2;
		private const DATABASE:uint = 3;
		private const WEB:uint = 4;

		private const MEDIATOR_LIST:Vector.<IScreen> = Vector.<IScreen>([

			new ButtonMediator, new ApplicationMediator, new GoogleAppsMediator, new DatabaseMediator, new WebMediator

			]);

		public function ScreenMediator() {

			moduleStage = ScreenFrame.module_stage;

			addChild(moduleStage);

			initMediator();

		}

		private function initMediator():void {

			for each (var mediator:IScreen in MEDIATOR_LIST)
				ScreenManager.screenManagerObj.addMediator(mediator);

		}


	}

}
