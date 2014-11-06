package screen.database.tables {

	import flash.display.MovieClip;
	import flash.text.TextField;

	import abstracts.TableAbstract;

	import identifier.DataName;
	import identifier.ProxyName;
	import identifier.TableName;

	import manager.model.ModelManager;

	import model.db.info.InfoProxy;
	import model.db.info.data.APInfoData;

	public class ProfileTable extends TableAbstract {

		private const TABLE_NAME:String = TableName.PROFILE;

		private const VALUE_AREA_NAME:String = "profileValueArea";

		public function ProfileTable() {

			super(TABLE_NAME);

		}

		override public function updateField():void {

			var _tableValueArea:MovieClip = tableArea.getChildByName(VALUE_AREA_NAME) as MovieClip;

			var _userIdTxt:TextField = _tableValueArea.userIdTxt as TextField;
			var _photoTxt:TextField = _tableValueArea.photoTxt as TextField;
			var _genderTxt:TextField = _tableValueArea.genderTxt as TextField;
			var _emailTxt:TextField = _tableValueArea.emailTxt as TextField;
			var _languageTxt:TextField = _tableValueArea.languageTxt as TextField;
			var _authorizeTxt:TextField = _tableValueArea.authorizeTxt as TextField;

			_userIdTxt.text = apInfoDataObj.getUserId();
			_photoTxt.text = apInfoDataObj.getPhoto();
			_genderTxt.text = apInfoDataObj.getGender();
			_emailTxt.text = apInfoDataObj.getEmail();
			_languageTxt.text = apInfoDataObj.getLanguage();
			_authorizeTxt.text = apInfoDataObj.getAuthorize();
			
		}

		private function get infoProxyObj():InfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.INFO) as InfoProxy;

		}

		private function get apInfoDataObj():APInfoData {

			return infoProxyObj.getData(DataName.ARM_PROFILE_INFO) as APInfoData;

		}

	}
}
