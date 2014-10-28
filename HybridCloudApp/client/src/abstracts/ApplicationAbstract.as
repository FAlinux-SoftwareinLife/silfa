package abstracts {
	
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	
	import events.MotionEvent;

	public class ApplicationAbstract extends EventDispatcher {
		
		private var _name:String;
		private var _appArea:MovieClip
		
		public function ApplicationAbstract(name:String) {
			this._name = name;
		}
		
		public function init(appArea:MovieClip):void {
		
			this._appArea = appArea;
			this._appArea.visible = false;
			
			initDisplayObj();
		
		}
		
		protected function initDisplayObj():void {
		
		
		}
		
		public function startApp():void {
		
		
		}
		
		public function exitApp():void {
		
		
		}
		
		protected function inMotionFinished():void {
			
			dispatchEvent(new MotionEvent(MotionEvent.IN_MOTION_FINISHED));
			
		}
		
		protected function outMotionFinished():void {
		
			dispatchEvent(new MotionEvent(MotionEvent.OUT_MOTION_FINISHED));
		
		}
		
		public function get name():String {
		
			return this._name;
		
		}
		
		protected function get appArea():MovieClip {
		
			return this._appArea;
		
		}
		
	}
}
