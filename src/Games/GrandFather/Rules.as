package
{
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author
	 */
	public class Rules extends Sprite
	{
		
		public function Rules()
		{
			fillContainerWithImg(this, "paper.gif", 700, 500);
			WriteRules();
		}
		
		private function fillContainerWithImg(container:Sprite, path:String, imgWidth:int, imgHeight:int):void
		{
			var img:Loader = new Loader();
			img.load(new URLRequest(path));
			img.contentLoaderInfo.addEventListener(Event.COMPLETE, function():void
			{
				onLoaderComplete(container, img, imgWidth, imgHeight)
			});
		}
		
		private function onLoaderComplete(container:Sprite, img:Loader, imgWidth:int, imgHeight:int):void
		{
			var bmp:Bitmap = new Bitmap();
			bmp = img.content as Bitmap;
			bmp.width = imgWidth;
			bmp.height = imgHeight;
			container.addChildAt(bmp, 0);
			}
		
		private function WriteRules():void
		{
			var WrRulesTxt:TextField = new TextField();
			var WrButtontxtFormat:TextFormat = new TextFormat();
			WrRulesTxt.setTextFormat(WrButtontxtFormat);
			WrRulesTxt.wordWrap = true;
			WrRulesTxt.defaultTextFormat = new TextFormat('Edwardian Script ITC', 30, 0xFFFFFF, 'bold');
			WrRulesTxt.text = "The top cards of tableau piles are available for play on foundations. You can move the cards from the waste pile to any tableau pile regardless of suit or rank. Each pile may contain up to 2 cards. Spaces are filled automatically from the waste or the stock piles. Cards cannot be moved from one tableau pile to another. When you have made all the moves initially available, begin turning over cards from the stock to the waste pile. The top card of the waste pile is available for play on the foundations or the tableau. There is one redeal.";
			WrRulesTxt.x = 100;
			WrRulesTxt.y = 65;
			WrRulesTxt.autoSize = TextFieldAutoSize.LEFT;
			WrRulesTxt.mouseEnabled = false;
			WrRulesTxt.selectable = false;
			WrRulesTxt.textColor = 0X000000;
			WrRulesTxt.height = 600;
			WrRulesTxt.width = 500;
			WrRulesTxt.border = false;
			WrRulesTxt.borderColor = 0X000000;
			addChild(WrRulesTxt);
			WrRulesTxt.background = false;
			WrRulesTxt.backgroundColor = 0X0000CC;
		
		}
	}

}