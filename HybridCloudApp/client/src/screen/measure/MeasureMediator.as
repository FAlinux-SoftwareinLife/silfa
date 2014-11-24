package screen.measure {
	
	import abstracts.ApplicationAbstract;
	
	import frame.ScreenFrame;
	
	import identifier.ScreenName;
	
	import manager.screen.IScreen;
	
	import screen.application.drive.DriveApplication;
	import screen.application.profile.ProfileApplication;

	public class MeasureMediator extends ScreenFrame implements IScreen {
		
		private const SCREEN_NAME:String = ScreenName.MEASURE;
		
		private const MEASURE_LIST:Vector.<ApplicationAbstract> = Vector.<ApplicationAbstract>([
			
			new ProfileApplication, new DriveApplication
			
		]);
		
		public function MeasureMediator() {
		}

		public function get name():String {
			return SCREEN_NAME;
		}

		public function reset():void {
		}
	}
}
