package Games.TopsyTurvyQueens
{
	import com.greensock.events.LoaderEvent;
	import flash.display.*;
	import flash.media.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	import flash.geom.*;
	import com.greensock.*;
	import com.greensock.easing.*
	import flash.ui.Keyboard;
	import flash.geom.ColorTransform;
	import flash.net.*;
	
	/**
	 * ...
	 * @author SS
	 */
	public class TopsyMainMenu extends Sprite
	{
		
		
		private var backgroundContainer:Sprite = new Sprite();
		private var buttonsContainer:Sprite = new Sprite();
		
		public function TopsyMainMenu()
		{
			loadBackground();
			loadMenuButtons();
		
		}
		
		private function loadMenuButtons():void
		{
			addChild(buttonsContainer);
			var newGameButton:TopsyMenuButton = new TopsyMenuButton(100, 20, 30, 30, "New game", true, 0, 0.5, -3);
			newGameButton.x = 100;
			newGameButton.y = 5;
			buttonsContainer.addChild(newGameButton);
			
			var statisticsButton:TopsyMenuButton = new TopsyMenuButton(100, 20, 30, 30, "Statistics", true, 0, 0.5, -3);
			statisticsButton.x = 202;
			statisticsButton.y = 5;
			buttonsContainer.addChild(statisticsButton);
			
			var rulesButton:TopsyMenuButton = new TopsyMenuButton(100, 20, 30, 30, "Rules", true, 0, 0.5, -3);
			rulesButton.x = 304;
			rulesButton.y = 5;
			buttonsContainer.addChild(rulesButton);
			
			var soundButton:TopsyMenuButton = new TopsyMenuButton(100, 20, 30, 30, "Sound", true, 0, 0.5, -3);
			soundButton.x = 406;
			soundButton.y = 5;
			buttonsContainer.addChild(soundButton);
			
			var timerButton:TopsyMenuButton = new TopsyMenuButton(100, 20, 30, 30, "00:00:00", true, 0, 0.5, -3);
			timerButton.x = 508;
			timerButton.y = 5;
			buttonsContainer.addChild(timerButton);
		
		}
		
		private function loadBackground():void
		{
			addChild(backgroundContainer);
			
			var backgroundUrl:URLRequest = new URLRequest("Data/images/Background/background1.jpg");
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
			loader.load(backgroundUrl);
			var background:Bitmap;
			function loaderComplete():void
			{
				var bmp:Bitmap = loader.content as Bitmap;
				background = new Bitmap(bmp.bitmapData);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaderComplete);
				backgroundContainer.addChild(background);
			}
		
		}
	}
	

}