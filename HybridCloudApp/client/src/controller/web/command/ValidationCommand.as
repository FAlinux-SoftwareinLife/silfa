package controller.web.command {
	import abstracts.CommandAbstract;

	import events.OAuthEvent;

	import identifier.CommandName;
	import identifier.DataName;
	import identifier.GuideName;
	import identifier.ProxyName;
	import identifier.ScreenName;

	import manager.controller.ICommand;
	import manager.model.ModelManager;
	import manager.screen.ScreenManager;

	import model.google.oauth.GoogleOAuthProxy;

	import screen.guide.GuideMediator;
	import screen.loading.LoadingMediator;
	import screen.log.LogMediator;

	import utils.Tracer;

	public class ValidationCommand extends CommandAbstract implements ICommand {

		private static const COMMAND_NAME:String = CommandName.VALIDATION;

		public function ValidationCommand() {

		}

		public function get name():String {

			return COMMAND_NAME;

		}

		public function execute(obj:Object = null):void {

			executeObj = obj;

			loadingMediatorObj.openLoading();

			requestExecute(true);

		}

		override protected function requestExecute(executeOpen:Boolean):void {

			// tracking
			logMediatorObj.log("Request OAuth Validation");
			
			googleOAuthProxyObj.addEventListener(OAuthEvent.REQUEST_OAUTH_VALIDATION_COMPLETE, requestValidationComplete);
			googleOAuthProxyObj.requestData(DataName.OAUTH_VALIDATION);

		}

		private function requestValidationComplete(evt:OAuthEvent):void {

			googleOAuthProxyObj.removeEventListener(OAuthEvent.REQUEST_OAUTH_VALIDATION_COMPLETE, requestValidationComplete);

			var _resultObj:Object = evt.param.data;

			switch (_resultObj.expires_in) {

				case "requestLogin":

					super.setGuide(GuideName.LOGIN);

					break;

				case 0:

					// tracking
					logMediatorObj.log("Expire token time");

					break;

				default:

					// tracking
					logMediatorObj.log(Tracer.log(_resultObj));

			}

			loadingMediatorObj.closeLoading();

		}


		// ------------------------ get obj ------------------------

		private function get googleOAuthProxyObj():GoogleOAuthProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_OAUTH) as GoogleOAuthProxy;

		}

		private function get loadingMediatorObj():LoadingMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOADING) as LoadingMediator;

		}

		private function get guideMediatorObj():GuideMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.GUIDE) as GuideMediator;

		}

		private function get logMediatorObj():LogMediator {

			return ScreenManager.screenManagerObj.getMediator(ScreenName.LOG) as LogMediator;

		}


	}
}
