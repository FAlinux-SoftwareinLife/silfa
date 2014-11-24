package screen.web.view {
	
	import abstracts.WebViewAbstract;
	
	import identifier.ViewName;

	public class LogoutView extends WebViewAbstract {
		
		private const VIEW_NAME:String = ViewName.LOGOUT;
				
		public function LogoutView() {
			
			super(VIEW_NAME);
			
		}
		
	}
}
