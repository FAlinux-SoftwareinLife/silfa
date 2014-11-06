package model.db.info.data {

	import identifier.DataName;

	import manager.model.IData;

	public class APInfoData implements IData {

		private const DATA_NAME:String = DataName.ARM_PROFILE_INFO;

		private var profileInfoObj:Object;

		public function APInfoData() {

			profileInfoObj = {

					userId: "", authorize: "", email: "", gender: "", language: "", photo: ""

				};

		}

		public function get name():String {

			return DATA_NAME;

		}

		public function requestData():void {
		}

		public function parseData(data:Object):void {

			profileInfoObj.userId = String(data.userId);
			profileInfoObj.authorize = String(data.authorize);
			profileInfoObj.email = String(data.email);
			profileInfoObj.gender = String(data.gender);
			profileInfoObj.language = String(data.language);
			profileInfoObj.photo = String(data.photo);

		}

		public function getUserId():String {

			return profileInfoObj.userId;

		}

		public function getAuthorize():String {

			return profileInfoObj.authorize;

		}

		public function getEmail():String {

			return profileInfoObj.email;

		}

		public function getGender():String {

			return profileInfoObj.gender;

		}

		public function getLanguage():String {

			return profileInfoObj.language;

		}

		public function getPhoto():String {

			return profileInfoObj.photo;

		}

	}
}
