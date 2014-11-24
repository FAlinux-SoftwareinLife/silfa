package abstracts {
	
	import flash.display.MovieClip;

	public class LoadingAbstract {
		
		private var _name:String;
		private var _loadArea:MovieClip;
		
		public function LoadingAbstract(name:String) {
			
			this._name = name;
			
		}
		
		public function init(loadArea:MovieClip):void {
		
			this._loadArea = loadArea;
		
		}
		
		public function get name():String {
		
			return _name;
		
		}
		
		public function set loadArea(targetArea:MovieClip):void {
			
			this._loadArea = targetArea;
			
		}
		
		public function get loadArea():MovieClip {
		
			return _loadArea;
		
		}
		
		public function open(areaSA:Number = 1):void {
			
		}
		
		public function close():void {
			
		}
		
	}
}
