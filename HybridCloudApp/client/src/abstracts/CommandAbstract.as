package abstracts {

	import controller.web.WebController;
	
	import events.OAuthEvent;
	
	import identifier.ApplicationName;
	import identifier.ButtonName;
	import identifier.CommandName;
	import identifier.ControllerName;
	import identifier.DataName;
	import identifier.GuideName;
	import identifier.LogName;
	import identifier.ProxyName;
	import identifier.ScreenName;
	
	import info.GoogleClientInfo;
	
	import manager.controller.ControllerManager;
	import manager.model.ModelManager;
	import manager.screen.ScreenManager;
	
	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.DriveListInfoData;
	import model.google.info.data.OAuthInfoData;
	import model.google.oauth.GoogleOAuthProxy;
	
	import screen.application.ApplicationMediator;
	import screen.button.ButtonMediator;
	import screen.button.auth.LoginButton;
	import screen.guide.GuideMediator;
	import screen.log.LogMediator;
	import screen.log.top.TopLog;
	
	public class CommandAbstract {

		protected var executeObj:Object;

		private var requireType:String;

		public function CommandAbstract() {

		}

		protected function checkRequirement(type:String):void {

			this.requireType = type;

			checkToken() ? checkValidation() : setGuide(GuideName.LOGIN);

		}

		protected function setGuide(guideType:String):void {

			switch (guideType) {

				case GuideName.LOGIN:
					
					// tracking
					logMediatorObj.log("You need a login");
					
					guideMediatorObj.open(GuideName.LOGIN);

					loginButtonObj.enableButton();					
					
					break;

				case GuideName.DRIVE:
					
					// tracking
					logMediatorObj.log("You need a Authorize for Drive");
					
					guideMediatorObj.open(GuideName.DRIVE);					

					break;

				case GuideName.LIST:
					
					// tracking
					logMediatorObj.log("You need a File list");

					guideMediatorObj.open(GuideName.LIST);

					break;

				case GuideName.PROFILE:
					
					// tracking
					logMediatorObj.log("You need a Profile info");

					guideMediatorObj.open(GuideName.PROFILE);

					break;

				case GuideName.FILE:
					
					// tracking
					logMediatorObj.log("You need a Create file");
					
					guideMediatorObj.open(GuideName.FILE);

					break;

			}

		}

		protected function requestExecute(executeOpen:Boolean):void {

		}

		protected function trackingLog(logName:String, issueType:String):void {

			//topLogObj.updateLog(logName, issueType);

		}

		// ------------------------ check ------------------------

		private function checkToken():Boolean {

			return oauthInfoDataObj.getAccessToken();

		}

		private function checkValidation():void {

			googleOAuthProxyObj.addEventListener(OAuthEvent.REQUEST_OAUTH_VALIDATION_COMPLETE, requestValidationComplete);
			googleOAuthProxyObj.requestData(DataName.OAUTH_VALIDATION);

		}

		private function requestValidationComplete(evt:OAuthEvent):void {

			googleOAuthProxyObj.removeEventListener(OAuthEvent.REQUEST_OAUTH_VALIDATION_COMPLETE, requestValidationComplete);

			var _validationObj:Object = evt.param.data;
			_validationObj.expires_in > 0 ? checkType() : setGuide(GuideName.LOGIN);

		}

		/**
		 * Check requirement type.
		 * @param type Receive type.
		 *
		 */
		private function checkType():void {

			var _executeOpen:Boolean = false;

			switch (requireType) {

				case CommandName.WEB_RP_GMAIL:

					if (oauthInfoDataObj.getScope().indexOf(GoogleClientInfo.SCOPE_GMAIL) == -1)
						_executeOpen = true;

					requestExecute(_executeOpen);

					break;

				case CommandName.WEB_RP_DRIVE_CALENDAR:

					if (oauthInfoDataObj.getScope().indexOf(GoogleClientInfo.SCOPE_DRIVE) == -1 &&

						oauthInfoDataObj.getScope().indexOf(GoogleClientInfo.SCOPE_CALENDAR) == -1)
						_executeOpen = true;

					requestExecute(_executeOpen);

					break;

				case CommandName.PROFILE:

					_executeOpen = true;
					requestExecute(_executeOpen);

					break;

				case CommandName.DRIVE_LIST:

					if (oauthInfoDataObj.getScope().indexOf(GoogleClientInfo.SCOPE_DRIVE) !== -1)
						_executeOpen = true;

					requestExecute(_executeOpen);

					break;

				case CommandName.CREATE_DRIVE_FILE:

					if (applicationMediator.currentApp == ApplicationName.DRIVE)
						_executeOpen = true;

					requestExecute(_executeOpen);

					break;

				case CommandName.DRIVE_FILE_TRASH:

					_executeOpen = true;
					requestExecute(_executeOpen);

					break;

				case CommandName.INSERT_PROFILE:
				case CommandName.REQUEST_PROFILE:

					if (applicationMediator.currentApp == ApplicationName.PROFILE)
						_executeOpen = true;

					requestExecute(_executeOpen);

					break;

				case CommandName.INSERT_DRIVE_FILE:
				case CommandName.REQUEST_DRIVE_FILE:

					if (applicationMediator.currentApp == ApplicationName.DRIVE &&

						driveListInfoDataObj.getFileList().length > 0)
						_executeOpen = true;

					requestExecute(_executeOpen);

					break;

			}

		}


		// ------------------------ get obj ------------------------

		private function get webControllerObj():WebController {

			return ControllerManager.controllerManagerObj.getController(ControllerName.WEB) as WebController;

		}
		
		private function get applicationMediator():ApplicationMediator {
			
			return ScreenManager.screenManagerObj.getMediator(ScreenName.APPLICATION) as ApplicationMediator;
			
		}
		private function get googleOAuthProxyObj():GoogleOAuthProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_OAUTH) as GoogleOAuthProxy;

		}

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

		private function get oauthInfoDataObj():OAuthInfoData {

			return googleInfoProxyObj.getData(DataName.OAUTH_INFO) as OAuthInfoData;

		}

		private function get driveListInfoDataObj():DriveListInfoData {

			return googleInfoProxyObj.getData(DataName.DRIVE_LIST_INFO) as DriveListInfoData;

		}
		
		private function get logMediatorObj():LogMediator {
			
			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOG) as LogMediator;
			
		}

		private function get topLogObj():TopLog {

			return logMediatorObj.getLog(LogName.TOP) as TopLog;

		}

		private function get guideMediatorObj():GuideMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.GUIDE) as GuideMediator;

		}

		private function get buttonMediatorObj():ButtonMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.BUTTON) as ButtonMediator;

		}

		private function get loginButtonObj():LoginButton {

			return buttonMediatorObj.getButton(ButtonName.LOGIN) as LoginButton;

		}


	}
}
