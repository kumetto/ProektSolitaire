package
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*
	import SharedClasses.*;
	import Games.GrandFather.Grandfather;
	import Games.Prison.PrisonSolitaire;
	import Games.TopsyTurvyQueens.TopsyTurvyQueens;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	/**
	 * ...
	 * @author SolitaireTeam
	 */
	
	public class MainMenu extends Sprite
	{
		private const MAIN_MENU_BUTTONS:Vector.<String> = new <String>["prison.png", "eightOff.png", "grandFather.png", "alternations.png", "topsyTurvyQueens.png"]
		
		private const STAGE_WIDTH:int = 800;
		private const STAGE_HEIGHT:int = 600;
		private const BUTTON_WIDTH:int = 200;
		private const BUTTON_HEIGHT:int = 60;
		private const BUTTON_SPACING:int = 5;
		private var winMessagePath:String = "winButton.png";
		private var loseMessagePath:String = "loseImage.png";
		private var backgroundPath:String = "background1.jpg";
		private var cash:int = 1000;
		private var bet:int = 0;
		
		private var backgroundContainer:Sprite = new Sprite();
		private var musicButtonContainer:Sprite = new Sprite();
		private var messageContainer:Sprite = new Sprite();
		
		private var menuContainer:Sprite = new Sprite();
		
		public function MainMenu()
		{
			loadBackground();
			loadMenuButtons();
			loadMusic();
		}
		
		private function loadMenuButtons():void
		{
			addChild(menuContainer);
			
			var buttonCounter:int = 0;
			
			for (var i:int = 0; i < MAIN_MENU_BUTTONS.length; i++)
			{
				var button:MenuButton = new MenuButton(MAIN_MENU_BUTTONS[i]);
				button.x = STAGE_WIDTH / 2 - BUTTON_WIDTH / 2;
				button.y = STAGE_HEIGHT / 5 + BUTTON_HEIGHT * buttonCounter + BUTTON_SPACING * buttonCounter;
				button.buttonMode = true;
				menuContainer.addChild(button);
				
				//add event listener
				var functionName:String = MAIN_MENU_BUTTONS[i].substring(0, MAIN_MENU_BUTTONS[i].length - 4);
				var buttonFunction:Function = this[functionName];
				button.addEventListener(MouseEvent.CLICK, buttonFunction);
				
				buttonCounter++;
			}
		}
		
		private function prison(e:Event):void
		{
			startGame(PrisonSolitaire);
		}
		
		private function eightOff(e:Event):void
		{
			//TODO:
			trace("eightOff");
		}
		
		private function grandFather(e:Event):void
		{
			//var grandfather:Grandfather = new Grandfather();
			startGame(Grandfather)
		}
		
		private function alternations(e:Event):void
		{
			//TODO:
			//startGame(alternations)
		}
		
		private function topsyTurvyQueens(e:Event):void
		{
			startGame(TopsyTurvyQueens);
		}
		
		private function startGame(game:Object)
		{
			clearMainMenu();
			
			cash -= bet;
			
			var selectedGame = new game();
			selectedGame.addEventListener(Event.ENTER_FRAME, checkGameOver, false, 0, true);
			
			addChild(selectedGame);
		}
		
		private function checkGameOver(e:Event):void
		{
			if (e.target.IsGameRunning == false)
			{
				e.target.removeEventListener(Event.ENTER_FRAME, checkGameOver);
				removeChild(e.target as Sprite);
				
				if (e.target.IsWin == true)
				{
					win();
				}
				else
				{
					lose();
				}
			}
		}
		
		private function win():void
		{
			cash += bet * 2;
			addChild(messageContainer);
			var winMessageURL:URLRequest = new URLRequest("Data/images/Buttons/" + winMessagePath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleate);
			loader.load(winMessageURL);
			var winMessage:Bitmap;
			function loaderCompleate():void
			{
				var bmp:Bitmap = loader.content as Bitmap;
				winMessage = new Bitmap(bmp.bitmapData);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaderCompleate);
				messageContainer.addChild(winMessage);
			
			}
			
			setTimeout(clearMessage, 4000);
		}
		
		private function lose():void
		{
			addChild(messageContainer);
			var loseMessageURL:URLRequest = new URLRequest("Data/images/Buttons/" + loseMessagePath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleate);
			loader.load(loseMessageURL);
			var loseMessage:Bitmap;
			function loaderCompleate():void
			{
				var bmp:Bitmap = loader.content as Bitmap;
				loseMessage = new Bitmap(bmp.bitmapData);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaderCompleate);
				messageContainer.addChild(loseMessage);
				messageContainer.x = -450;
				messageContainer.y = 200;
				TweenMax.to(messageContainer, 1, {x: 180, y: 200, ease: Bounce.easeOut});
				TweenMax.to(messageContainer, 1, {x: 900, y: 200, autoAlpha: 0, delay: 2.5});
			}
			
			setTimeout(clearMessage, 4000);
		}
		
		private function clearMessage():void
		{
			messageContainer.removeChildren();
			removeChild(messageContainer);
			
			showMainMenu();
		}
		
		private function loadMusic():void
		{
			addChild(musicButtonContainer);
			
			var music:Music = new Music();
			music.showButton();
			
			musicButtonContainer.addChild(music);
		}
		
		private function showMainMenu():void
		{
			addChild(menuContainer);
		}
		
		private function clearMainMenu():void
		{
			removeChild(menuContainer);
		}
		
		private function loadBackground():void
		{
			addChild(backgroundContainer);
			
			var backgroundUrl:URLRequest = new URLRequest("Data/images/Background/" + backgroundPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleate);
			loader.load(backgroundUrl);
			var background:Bitmap;
			function loaderCompleate():void
			{
				var bmp:Bitmap = loader.content as Bitmap;
				background = new Bitmap(bmp.bitmapData);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaderCompleate);
				backgroundContainer.addChild(background);
			}
		}
	}
}