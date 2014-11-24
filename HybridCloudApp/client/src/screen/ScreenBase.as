package screen {

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import frame.ScreenFrame;
	
	import manager.screen.IScreen;
	import manager.screen.ScreenManager;
	
	import screen.application.ApplicationMediator;
	import screen.button.ButtonMediator;
	import screen.database.DatabaseMediator;
	import screen.guide.GuideMediator;
	import screen.loading.LoadingMediator;
	import screen.log.LogMediator;
	import screen.web.WebMediator;

	/**
	 *
	 *
	 */
	public class ScreenBase extends Sprite {

		private var hcmStage:DisplayObject;

		private const MEDIATOR_LIST:Vector.<IScreen> = Vector.<IScreen>([

			new ButtonMediator, new ApplicationMediator, new LogMediator, new DatabaseMediator, new WebMediator, new GuideMediator, new LoadingMediator

			]);

		public function ScreenBase() {

			hcmStage = ScreenFrame.hcm_stage;

			addChild(hcmStage);

			initMediator();

		}

		private function initMediator():void {

			for each (var mediator:IScreen in MEDIATOR_LIST)
				ScreenManager.screenManagerObj.addMediator(mediator);

		}


	}

}
