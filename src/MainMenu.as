package
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import SharedClasses.*;
	import Games.GrandFather.Grandfather;
	import Games.EightOff.EightOff;
	import Games.Prison.PrisonSolitaire;
	import Games.Alternations.AlternationSolitaire
	import Games.TopsyTurvyQueens.TopsyTurvyQueens;

	
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

		private var backgroundPath:String = "background1.jpg";
		private var cash:int = 1000;
		private var bet:int = 0;
		
		private var backgroundContainer:Sprite = new Sprite();
		private var musicButtonContainer:Sprite = new Sprite();
		private var messageContainer:Sprite = new Sprite();
		private var buttonsContainer:Sprite = new Sprite();
		
		private var menuContainer:Sprite = new Sprite();
		
		private var moneyStatus:Button;
		private var betStatus:Button;
		private var ingame:Boolean = false; 						// if you bet ingame = true;
		private var standClicked:Boolean = false;
		
		public function MainMenu()
		{
			loadBackground();
			loadMenuButtons();
			loadBetButtons();
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
			startGame(EightOff);
		}
		
		private function grandFather(e:Event):void
		{
			startGame(Grandfather)
		}
		
		private function alternations(e:Event):void
		{
			startGame(AlternationSolitaire)
		}
		
		private function topsyTurvyQueens(e:Event):void
		{
			startGame(TopsyTurvyQueens);
		}
		
		private function startGame(game:Object)
		{
			clearMainMenu();
			clearBetButtons();			
			
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
					cash += bet * 2;
					bet = 0;
					win();
				}
				else
				{
					bet = 0;
					resetStatusBar();
					lose();
				}
			}
		}
		
		private function win():void
		{
			var winMessagePath:String = "winButton.png";
		
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
			var loseMessagePath:String = "loseImage.png";
			
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
				messageContainer.x =-450;
				messageContainer.y = 200;
			}
			TweenMax.to(messageContainer, 1, {x: 180, y: 200, ease: Bounce.easeOut});
			TweenMax.to(messageContainer, 1, {x: 900, y: 200, autoAlpha: 0, delay: 2.5});
		
			setTimeout(clearMessage, 4000);
		}
		
		
		private function clearMessage():void
		{
			messageContainer.x = -450;
			messageContainer.y = 200;
			messageContainer.removeChildren();
			removeChild(messageContainer);
			
			showMainMenu();
			showBetButtons();
		}
		
		private function loadMusic():void
		{
			var musicButtonWidth:int = 40;
			var musicButtonHeight:int = 40;
			var spacePadding:int = 10;
			
			addChild(musicButtonContainer);
			musicButtonContainer.y = STAGE_HEIGHT - musicButtonHeight - spacePadding;
			musicButtonContainer.x = STAGE_WIDTH - musicButtonWidth - spacePadding;
			
			var music:Music = new Music();
			music.showButton();
			
			musicButtonContainer.addChild(music);
		}
		
		private function showMainMenu():void
		{
			addChild(menuContainer);
		}
		
		private function showBetButtons():void
		{
			addChild(buttonsContainer);
		}
		
		private function clearBetButtons():void
		{
			removeChild(buttonsContainer)
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
		
		private function loadBetButtons():void
		{
			addChild(buttonsContainer);
			var buttonWidth:int = 65;
			
			moneyStatus = new Button(120, "Credits: " + cash.toString(), false);
			addChild(moneyStatus);
			moneyStatus.height = 25;
			moneyStatus.x = 150;
			moneyStatus.y = 575;
			
			betStatus = new Button(120, "Bet: ", false);
			addChild(betStatus);
			betStatus.height = 25;
			betStatus.x = 300;
			betStatus.y = 575;
			
			var bet1:Button = new Button(buttonWidth, "Bet 1");
			bet1.name = String(1);
			bet1.addEventListener(MouseEvent.CLICK, addBet);
			buttonsContainer.addChild(bet1);
			bet1.x = 40;
			bet1.y = 300;
			
			var bet5:Button = new Button(buttonWidth, "Bet 5");
			bet5.name = String(5);
			bet5.addEventListener(MouseEvent.CLICK, addBet);
			buttonsContainer.addChild(bet5);
			bet5.x = 115;
			bet5.y = 300;
			
			var bet10:Button = new Button(buttonWidth, "Bet 10");
			bet10.name = String(10);
			bet10.addEventListener(MouseEvent.CLICK, addBet);
			buttonsContainer.addChild(bet10);
			bet10.x = 190;
			bet10.y = 300;
			
			var bet25:Button = new Button(buttonWidth, "Bet 25");
			bet25.name = String(25);
			bet25.addEventListener(MouseEvent.CLICK, addBet);
			buttonsContainer.addChild(bet25);
			bet25.x = 80;
			bet25.y = 350;
			
			var bet100:Button = new Button(buttonWidth, "Bet 100");
			bet100.name = String(100);
			bet100.addEventListener(MouseEvent.CLICK, addBet);
			buttonsContainer.addChild(bet100);
			bet100.x = 150;
			bet100.y = 350;
			
			var bet250:Button = new Button(buttonWidth, "Bet 250");
			bet250.name = String(250);
			bet250.addEventListener(MouseEvent.CLICK, addBet);
			buttonsContainer.addChild(bet250);
			bet250.x = 115;
			bet250.y = 400;
		
		}
		
		private function addBet(e:Event):void
		{
			var betString:String = e.currentTarget.name;
			var currentBet:int = int(betString);
			
			if (currentBet <= cash && !ingame)
			{
				bet += int(currentBet);
				cash -= int(currentBet);
				resetStatusBar();
			}
		}
		
		private function resetStatusBar():void
		{
			removeChild(moneyStatus);
			moneyStatus = new Button(120, "Credits: " + cash.toString(), false);
			addChild(moneyStatus);
			moneyStatus.height = 25;
			moneyStatus.x = 150;
			moneyStatus.y = 575;
			
			removeChild(betStatus);
			betStatus = new Button(120, "Bet: " + bet.toString(), false);
			addChild(betStatus);
			betStatus.height = 25;
			betStatus.x = 300;
			betStatus.y = 575;
		}
	}
}