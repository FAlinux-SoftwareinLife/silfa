package model.google.info.data {
	import identifier.DataName;

	import manager.model.IData;

	public class ProfileInfoData implements IData {

		private static const DATA_NAME:String = DataName.PROFILE_INFO;

		private var profileInfoObj:Object;

		public function ProfileInfoData() {

			profileInfoObj = {

					circledByCount: "",

					gender: "",

					isPlusUser: "",

					kind: "",

					familyName: "",

					givenName: "",

					etag: "",

					objectType: "",

					email: "",

					ageRange: "",

					domain: "",

					displayName: "",

					imageURL: "",

					language: "",

					id: "",

					plusURL: ""

				};

		}

		public function get name():String {
			return DATA_NAME;
		}

		public function requestData():void {
		}

		public function parseData(data:Object):void {

			profileInfoObj.circledByCount = data.circledByCount;
			profileInfoObj.gender = data.gender;
			profileInfoObj.isPlusUser = data.isPlusUser;
			profileInfoObj.kind = data.kind;
			profileInfoObj.familyName = data.name.familyName;
			profileInfoObj.givenName = data.name.givenName;
			profileInfoObj.etag = data.etag;
			profileInfoObj.objectType = data.objectType;
			profileInfoObj.email = data.emails[0].value;
			profileInfoObj.displayName = data.displayName;
			profileInfoObj.imageURL = data.image.url+"&sz=100";
			profileInfoObj.language = data.language;
			profileInfoObj.id = data.id;
			profileInfoObj.plusURL = data.url;

		}

		public function getUserName():String {

			return profileInfoObj.displayName;

		}

		public function getUserEmail():String {

			return profileInfoObj.email;

		}

		public function getUserId():String {

			return profileInfoObj.id;

		}

		public function getUserImageURL():String {

			return profileInfoObj.imageURL;

		}

		public function getUserGender():String {

			return profileInfoObj.gender;

		}

		public function getUserLanguage():String {

			return profileInfoObj.language;

		}

	}
}
