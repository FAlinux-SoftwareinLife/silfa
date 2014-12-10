package utils {

	import com.greensock.TweenNano;
	import com.greensock.easing.Sine;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class ContentScroll {

		private var scrollBar:MovieClip;
		private var scrollBg:MovieClip;
		private var conArea:MovieClip;
		private var conBg:MovieClip;

		private var moveRatio:Number;
		private var conAreaOldY:Number;
		private var scrollBarOldX:Number;
		private var scrollBarRect:Rectangle;

		private var downOpen:Boolean;
		private var overOpen:Boolean;

		private var targetConY:Number;
		private var targetScrollY:Number;
		private var targetScrollH:Number;
		private var targetScrollA:Number;


		public function ContentScroll() {


		}

		public function init(scrollBar:MovieClip, scrollBg:MovieClip, conArea:MovieClip, conBg:MovieClip):void {

			this.scrollBar = scrollBar;
			this.scrollBg = scrollBg;
			this.conArea = conArea;
			this.conBg = conBg;

			moveRatio = 0;
			conAreaOldY = this.conArea.y;
			scrollBarOldX = this.scrollBar.x;

			downOpen = overOpen = false;

			this.scrollBar.buttonMode = true;
			this.scrollBar.addEventListener(MouseEvent.MOUSE_DOWN, scrollBarMouseHandler);
			this.scrollBar.addEventListener(MouseEvent.MOUSE_OVER, scrollBarMouseHandler);
			this.scrollBar.addEventListener(MouseEvent.MOUSE_OUT, scrollBarMouseHandler);

			scrollBar.alpha = 0;

		}

		public function visibleScroll(scrollOpen:Boolean):void {

			scrollOpen ? setScroll() : removeScroll();

		}

		private function setScroll():void {

			//scrollBar.stage.addEventListener(MouseEvent.MOUSE_WHEEL, scrollBarMouseHandler);

			conArea.addEventListener(Event.ENTER_FRAME, enterHandler);

		}

		private function removeScroll():void {

			conArea.removeEventListener(Event.ENTER_FRAME, enterHandler);

		}



		private function scrollBarMouseHandler(evt:MouseEvent):void {

			switch (evt.type) {

				case MouseEvent.MOUSE_DOWN:

					scrollBarRect = new Rectangle(scrollBar.x + 1, scrollBg.y, 0, scrollBg.height - scrollBar.height);

					scrollBar.startDrag(false, scrollBarRect);

					scrollBar.stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseHandler);

					downOpen = true;

					break;

				case MouseEvent.MOUSE_OVER:

					overOpen = true;
					TweenNano.to(scrollBar, 0.2, {x: scrollBarOldX - 5, ease: Sine.easeOut});

					break;

				case MouseEvent.MOUSE_OUT:

					overOpen = false;

					if (!downOpen)
						TweenNano.to(scrollBar, 0.2, {x: scrollBarOldX, ease: Sine.easeOut});

					break;

				case MouseEvent.MOUSE_WHEEL:

					downOpen = true;

					if (evt.delta > 0) {

						if (scrollBar.y - 30 < 0) {

							scrollBar.y = 0;

						} else {

							scrollBar.y -= 30;

						}
					}

					if (evt.delta < 0) {

						if (scrollBar.y + scrollBar.height + 30 > scrollBg.height) {

							scrollBar.y = scrollBg.height - scrollBar.height;

						} else {

							scrollBar.y += 30;

						}

					}

					downOpen = false;

					break;

			}

		}

		private function stageMouseHandler(evt:MouseEvent):void {

			switch (evt.type) {

				case MouseEvent.MOUSE_UP:

					scrollBar.stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseHandler);

					scrollBar.stopDrag();

					if (!overOpen)
						TweenNano.to(scrollBar, 0.2, {x: scrollBarOldX, ease: Sine.easeOut});

					downOpen = false;

					break;
			}

		}

		private function enterHandler(evt:Event):void {

			if (conAreaOldY + getConAreaHeight() > conBg.height) {

				targetScrollA = 1;

				if (downOpen) {

					moveRatio = (conAreaOldY + getConAreaHeight() - conBg.height) / (scrollBg.height - scrollBar.height);
					targetConY = -(scrollBar.y * moveRatio) + conAreaOldY;
					conArea.y += (targetConY - conArea.y) * 0.2;

				} else {

					moveRatio = (scrollBg.height - scrollBar.height) / (conAreaOldY + getConAreaHeight() - conBg.height);
					targetScrollY = (-conArea.y) * moveRatio + conAreaOldY * moveRatio;

					scrollBar.y += (targetScrollY - scrollBar.y) * 0.2;

				}

				targetScrollH = scrollBg.height - (getConAreaHeight() - conBg.height) * 0.2;

				if (targetScrollH < 100)
					targetScrollH = 100;

				scrollBar.height += (targetScrollH - scrollBar.height) * 0.1;

			} else {

				targetScrollA = 0;
				targetScrollH = scrollBg.height;
				scrollBar.y = scrollBg.y;

			}

			scrollBar.alpha += (targetScrollA - scrollBar.alpha) * 0.05;
			scrollBar.height += (targetScrollH - scrollBar.height) * 0.1;

		}

		private function getConAreaHeight():Number {

			var _height:Number = 0;

			var _conNum:uint = conArea.numChildren;

			for (var i:uint = 0; i < _conNum; i++) {

				var _con:MovieClip = conArea.getChildAt(i) as MovieClip;
				_height += _con.isOpen ? _con.height + 5 : _con.titleArea.height + 5;

			}

			return _height;

		}

	}
}
