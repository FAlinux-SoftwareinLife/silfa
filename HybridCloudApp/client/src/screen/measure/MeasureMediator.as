package screen.measure {
	
	import abstracts.MeasureAbstract;
	
	import frame.ScreenFrame;
	
	import identifier.ScreenName;
	
	import manager.screen.IScreen;
	
	import screen.measure.connectivity.ConnectivityMeasure;

	public class MeasureMediator extends ScreenFrame implements IScreen {
		
		private const SCREEN_NAME:String = ScreenName.MEASURE;
		
		private const MEASURE_LIST:Vector.<MeasureAbstract> = Vector.<MeasureAbstract>([
			
			new ConnectivityMeasure
			
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
