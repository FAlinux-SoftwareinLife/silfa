package screen.web.view {
	
	import abstracts.WebViewAbstract;
	
	import identifier.ViewName;

	public class DriveCalendarView extends WebViewAbstract {
		
		private const VIEW_NAME:String = ViewName.DRIVE_CALENDAR;
		
		public function DriveCalendarView() {
			
			super(VIEW_NAME);
			
		}
		
	}
}
