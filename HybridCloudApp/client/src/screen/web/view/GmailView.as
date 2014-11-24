package screen.web.view {
	
	import abstracts.WebViewAbstract;
	
	import identifier.ViewName;

	public class GmailView extends WebViewAbstract {
		
		private const VIEW_NAME:String = ViewName.GMAIL;
		
		public function GmailView() {
			
			super(VIEW_NAME);
			
		}
				
	}
}
