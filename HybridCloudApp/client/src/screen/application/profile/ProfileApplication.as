package screen.application.profile {


	import com.greensock.TweenNano;
	import com.greensock.easing.Back;
	import com.greensock.easing.Sine;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;

	import abstracts.ApplicationAbstract;

	import identifier.ApplicationName;
	import identifier.DataName;
	import identifier.ProxyName;

	import manager.model.ModelManager;

	import model.google.info.GoogleInfoProxy;
	import model.google.info.data.ProfileInfoData;

	public class ProfileApplication extends ApplicationAbstract {

		private const APP_NAME:String = ApplicationName.PROFILE;

		private var area_list:Vector.<Object>;

		public function ProfileApplication() {

			super(APP_NAME);

			area_list = Vector.<Object>([

				{name: "name", area: null, initX: 0},

				{name: "gender", area: null, initX: 0},

				{name: "email", area: null, initX: 0},

				{name: "language", area: null, initX: 0}

				]);

		}

		override protected function initDisplayObj():void {

			for each (var _areaObj:Object in area_list) {

				var _area:MovieClip = appArea.getChildByName(_areaObj.name + "Area") as MovieClip;

				_areaObj.area = _area;
				_areaObj.initX = _area.x;

			}

		}

		override public function startApp():void {

			setProfieValue();

		}

		override public function exitApp():void {

			TweenNano.to(appArea, 1, {alpha: 0, onComplete: outMotionComplete});

		}

		private function setProfieValue():void {

			var _nameArea:MovieClip = appArea.nameArea as MovieClip;
			var _photoArea:MovieClip = _nameArea.photoArea as MovieClip;
			var _nameTxt:TextField = _nameArea.nameTxt as TextField;
			var _photoLoader:Loader = new Loader();

			_nameTxt.text = profileInfoDataObj.getUserName();

			_photoArea.addChild(_photoLoader);
			_photoLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, photoLoadComplete);
			_photoLoader.load(new URLRequest(profileInfoDataObj.getUserImageURL()));


			var _genderArea:MovieClip = appArea.genderArea as MovieClip;
			var _maleIcon:MovieClip = _genderArea.maleIcon as MovieClip;
			var _femaleIcon:MovieClip = _genderArea.femaleIcon as MovieClip;
			var _userGender:String = profileInfoDataObj.getUserGender();

			_maleIcon.visible = _userGender == "male" ? true : false;
			_femaleIcon.visible = _userGender == "female" ? true : false;


			var _emailArea:MovieClip = appArea.emailArea as MovieClip;
			var _emailTxt:TextField = _emailArea.emailTxt as TextField;

			_emailTxt.text = profileInfoDataObj.getUserEmail();


			var _languageArea:MovieClip = appArea.languageArea as MovieClip;
			var _languageTxt:TextField = _languageArea.languageTxt as TextField;

			_languageTxt.text = profileInfoDataObj.getUserLanguage();


		}

		private function startMotion():void {

			appArea.visible = true;

			var _bg:MovieClip = appArea.bg as MovieClip;

			var _areaNum:uint = area_list.length;

			for (var i:uint = 0; i < _areaNum; i++) {

				var _areaObj:Object = area_list[i] as Object;
				var _area:MovieClip = _areaObj.area as MovieClip;
				var _initX:Number = _areaObj.initX;

				_area.x = _bg.x + _bg.width;
				_area.alpha = 0;

				TweenNano.to(_area, 0.4, {

						alpha: 1,

						x: _initX,

						delay: i * 0.04,

						ease: Sine.easeOut,

						onComplete: startMotionCompleteCheck,

						onCompleteParams: [i]

					});

			}

			TweenNano.to(appArea, 1, {alpha: 1, ease: Sine.easeOut});

		}

		private function outMotion():void {


		}

		private function photoLoadComplete(evt:Event):void {

			var _nameArea:MovieClip = appArea.nameArea as MovieClip;
			var _photoAreaMask:MovieClip = _nameArea.photoAreaMask as MovieClip;
			var _photoArea:MovieClip = _nameArea.photoArea as MovieClip;
			var _photoLoader:Loader = evt.target.loader as Loader;

			var _photoImg:Bitmap = _photoLoader.content as Bitmap;

			_photoImg.smoothing = true;

			_photoLoader.x = -_photoLoader.width / 2;
			_photoLoader.y = -_photoLoader.height / 2;

			//_photoArea.scaleX = _photoArea.scaleY = 0;
			_photoAreaMask.scaleX = _photoAreaMask.scaleY = 0;

			//TweenNano.to(_photoArea, 0.4, {scaleX: 1, scaleY: 1, delay: 1, ease: Back.easeOut});
			TweenNano.to(_photoAreaMask, 0.4, {scaleX: 1, scaleY: 1, delay: 1, ease: Back.easeOut});

			startMotion();

		}

		private function startMotionCompleteCheck(num:uint):void {

			var _areaNum:uint = area_list.length;

			if (_areaNum == (num + 1))
				startMotionComplete();

		}

		private function startMotionComplete():void {

			inMotionFinished();

		}

		private function outMotionComplete():void {

			appArea.visible = false;

			outMotionFinished();

		}

		private function get profileInfoDataObj():ProfileInfoData {

			return googleInfoProxyObj.getData(DataName.PROFILE_INFO) as ProfileInfoData;

		}

		private function get googleInfoProxyObj():GoogleInfoProxy {

			return ModelManager.modelManagerObj.getProxy(ProxyName.GOOGLE_INFO) as GoogleInfoProxy;

		}

	}
}
