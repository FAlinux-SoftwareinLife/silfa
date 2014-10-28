package screen.application.present {
	
	import com.greensock.TweenNano;
	
	import abstracts.ApplicationAbstract;
	
	import identifier.ApplicationName;

	public class PresentApplication extends ApplicationAbstract {

		private const APP_NAME:String = ApplicationName.PRESENT;

		public function PresentApplication() {
			
			super(APP_NAME);
			
		}
		
		override public function startApp():void {
			
			TweenNano.to(appArea, 1, {alpha: 1, onComplete: startMotionComplete});
			
		}
		
		override public function exitApp():void {
			
			TweenNano.to(appArea, 1, {alpha: 0, onComplete: outMotionComplete});
			
		}
		
		private function startMotionComplete():void {
			
			inMotionFinished();
			
		}
		
		private function outMotionComplete():void {
			
			outMotionFinished();
			
		}
		
	}
}
