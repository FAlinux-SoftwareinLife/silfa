package model {

	import manager.model.IModel;
	import manager.model.ModelManager;
	
	import model.db.arm.ArmServerProxy;
	import model.db.info.ArmInfoProxy;
	import model.google.apps.GoogleAppsProxy;
	import model.google.info.GoogleInfoProxy;
	import model.google.oauth.GoogleOAuthProxy;

	public class ModelBase {

		private const DATA_LIST:Vector.<IModel> = Vector.<IModel>([

			new GoogleOAuthProxy, new GoogleAppsProxy, new GoogleInfoProxy, new ArmServerProxy, new ArmInfoProxy

			]);

		public function ModelBase() {

			initProxy();

		}

		private function initProxy():void {

			for each (var proxy:IModel in DATA_LIST)
				ModelManager.modelManagerObj.addProxy(proxy);

		}

	}
}
