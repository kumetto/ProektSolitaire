package Games.TopsyTurvyQueens
{
	
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Loader;
    import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.display.Graphics;
	/**
	 * ...
	 * @author Desislava
	 */
	public class Cards extends Sprite
	{
		private var _cardSuit:String;
		private var _cardWidth:int;
		private var _cardHeight:int;
		private var ldr:Loader;
		private var _cardUrl:URLRequest;
		private var _cardValue:int;
		public function Cards(cardValue:int,cardSuit:String,cardWidth:int=72,cardHeight:int=96) 
		{
			_cardUrl = new URLRequest("Cards/" + String(cardValue) + cardSuit + ".png");
			_cardSuit = cardSuit;
			_cardValue = cardValue;
			_cardWidth = cardWidth;
			_cardHeight = cardHeight;
			loadCard();
		}
		
		private function loadCard():void 
		{
			ldr = new Loader();
			ldr.load(_cardUrl);
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleate);
			
		}
			
		private function loaderCompleate(evt:Event):void
		{
			
			var bmpData:BitmapData= new BitmapData(ldr.width,ldr.height,false);
			bmpData.draw(ldr);
			var bCard:Bitmap = new Bitmap(bmpData);
			addChild(bCard);
			
			
		}
		public function get cardValue():int
		{
			return _cardValue;
		}
		public function get cardSuit():String
		{
			return _cardSuit;
		}
		public function get cardWidth():int
		{
			return _cardWidth;
		}
		public function get cardHeight():int
		{
			return _cardHeight;
		}
		
		
		
	}
}