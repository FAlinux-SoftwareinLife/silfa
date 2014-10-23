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

			for (var i:Object in data) {

				var _subObj:Object = data[i];

				trace(i + " = " + _subObj);

				for (var j:Object in _subObj) {

					var _trdObj:Object = _subObj[j];

					trace(j + " = " + _trdObj);

					for (var h:Object in _trdObj) {

						var _fourthObj:Object = _trdObj[h];

						trace(h + " = " + _fourthObj);

					}

				}

			}

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
