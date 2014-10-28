package screen.button.auth {

	import flash.display.MovieClip;
	
	import abstracts.ButtonAbstract;

	public class RefreshTokenButton extends ButtonAbstract {

		public function RefreshTokenButton(name:String, button:MovieClip) {

			super(name, button);

		}
		
		override protected function mouseDownHandler():void {
			
			trace(this);
			
		}

	}
}
