package Games.Alternations
{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;
	import flash.net.URLRequest;
	import SharedClasses.*
	
	/**
	 * ...
	 * @author Jordan
	 */
	public class AlternationSolitaire extends Sprite
	{
		private const STAGE_WIDTH = 800;
		private const STAGE_HEIGHT = 600;
		
		private const DECK_CONTAINER_X = 25;
		private const DECK_CONTAINER_Y = 70;
		private const FOUNDATION_CONTAINER_X:int = 175;
		private const FOUNDATION_CONTAINER_Y:int = 70;
		private const TAUBLE_CONTAINER_X:int = 250;
		private const TAUBLE_CONTAINER_Y:int = 195;
		
		private const CONTAINER_WIDTH:int = 65;
		private const CONTAINER_HEIGHT:int = 100;
		private const CONTAINER_WIDTH_SPACING:int = 10;
		private const CARDS_Y_SPACING:int = 35;
		
		private var cardsSkin:String;
		
		private var score:int = 0;
		
		private var cards:Vector.<Card> = new Vector.<Card>();
		private var isWin:Boolean = false;
		private var isGameRunning:Boolean = true;
		private var counterPlacedCards:int = 0;
		
		private var movCardCurrentSprite:Sprite;
		private var movCardNewSprite:Sprite;
		private var movingCardObject:Sprite;
		private var movCardToFoundation:Boolean = false;
		private var movingCardX:int;
		private var movingCardY:int;
		
		private var menuContainer:Sprite;
		private var buttonsContainer:Sprite;
		private var deckContainer:Sprite;
		private var foundationContainer:Sprite;
		private var taublePilesContainer:Sprite;
		
		public function AlternationSolitaire(cardsSkin:String = "skin1/")
		{
			this.cardsSkin = cardsSkin;
			
			showMenu();
		}
		
		public function get IsGameRunning():Boolean
		{
			return this.isGameRunning;
		}
		
		public function get IsWin():Boolean
		{
			return this.isWin;
		}
		
		private function showMenu():void
		{
			menuContainer = new Sprite();
			
			var helpMenu:AlternationHelpMenu = new AlternationHelpMenu();
			menuContainer.addChild(helpMenu);
			
			var startButton:MenuButton = new MenuButton("start.png");
			startButton.addEventListener(MouseEvent.CLICK, startGame,false,0,true);
			startButton.x = 150;
			startButton.y = helpMenu.height + 20;
			startButton.buttonMode = true;
			menuContainer.addChild(startButton);
			
			var scoreButton:MenuButton = new MenuButton("score.png");
			scoreButton.addEventListener(MouseEvent.CLICK, showScore,false,0,true);
			scoreButton.x = 150;
			scoreButton.y = helpMenu.height + 90;
			scoreButton.buttonMode = true;
			menuContainer.addChild(scoreButton);
			
			menuContainer.x = STAGE_WIDTH / 2 - menuContainer.width / 2;
			addChild(menuContainer);
		}
		
		private function startGame(e:MouseEvent):void
		{
			removeChild(menuContainer);
			menuContainer = null;
			
			showSurrenderButton();
			
			DealSolitaire();
		}
		
		private function DealSolitaire():void
		{
			addCardContainers();
			
			loadDeck();
			
			loadCardDeck();
			loadTaublePilesCards();
		}
		
		private function addCardContainers():void
		{
			fillDeckContainer();
			fillFoundationContainer();
			fillTaubleContainer();
			
			function fillDeckContainer():void
			{
				deckContainer = new Sprite();
				deckContainer.x = DECK_CONTAINER_X
				deckContainer.y = DECK_CONTAINER_Y
				
				for (var pileCount:int = 0; pileCount < 2; pileCount++)
				{
					if (pileCount == 1) // dont place backgroundPile
					{
						var containerX:int = CONTAINER_WIDTH * pileCount + pileCount * CONTAINER_WIDTH_SPACING;
						deckContainer.addChild(addCardContainer(containerX, "deck" + pileCount, true));
						continue;
					}
					var containerX:int = CONTAINER_WIDTH * pileCount + pileCount * CONTAINER_WIDTH_SPACING;
					deckContainer.addChild(addCardContainer(containerX, "deck" + pileCount));
					
				}
				
				addChild(deckContainer);
			}
			
			function fillTaubleContainer():void
			{
				taublePilesContainer = new Sprite();
				taublePilesContainer.x = TAUBLE_CONTAINER_X
				taublePilesContainer.y = TAUBLE_CONTAINER_Y
				
				for (var pileCount:int = 0; pileCount < 7; pileCount++)
				{
					var containerX:int = CONTAINER_WIDTH * pileCount + pileCount * CONTAINER_WIDTH_SPACING;
					taublePilesContainer.addChild(addCardContainer(containerX, "tauble" + pileCount));
				}
				
				addChild(taublePilesContainer);
			}
			
			function fillFoundationContainer():void
			{
				foundationContainer = new Sprite();
				foundationContainer.x = FOUNDATION_CONTAINER_X;
				foundationContainer.y = FOUNDATION_CONTAINER_Y;
				
				for (var pileCount:int = 0; pileCount < 8; pileCount++)
				{
					var containerX:int = CONTAINER_WIDTH * pileCount + pileCount * CONTAINER_WIDTH_SPACING;
					foundationContainer.addChild(addCardContainer(containerX, "foundation" + pileCount));
				}
				
				addChild(foundationContainer);
			}
			
			function addCardContainer(x:int, name:String, noBackground:Boolean = false):Sprite
			{
				var container:Sprite = new Sprite();
				container.x = x;
				container.name = name;
				if (noBackground != true)
				{
					container.addChild(new PileBackground());
				}
				
				return container;
			}
		}
		
		private function loadCardDeck():void
		{
			var deck:Sprite = deckContainer.getChildAt(0) as Sprite;
			deck.buttonMode = true ;
			
			var cardColor:String = "Back";
			var cardUrl:String = 0 + cardColor;
			
			for (var i:int = 0; i < 55; i++)
			{
				var card:Card = new Card(cardUrl, i, cardsSkin);
				card.name = "back";
				card.addEventListener(MouseEvent.CLICK, dealDeckCard,false,0,true);
				
				deck.addChild(card);
			}
		}
		
		private function loadTaublePilesCards():void
		{
			var taublePiles:int = 7;
			var taubleCards:int = 7;
			
			for (var pile:int = 0; pile < taublePiles; pile++)
			{
				for (var card:int = 0; card < taubleCards; card++)
				{
					var pileContainer:Sprite = taublePilesContainer.getChildAt(pile) as Sprite;
					var cardY = (pileContainer.numChildren - 1) * CARDS_Y_SPACING;
					if (card % 2 == 0) {
							
							dealRandomCard(pileContainer, cardY);
					}
					else 
					{
						dealBackCard(pileContainer);
					}
				
				}
			}
		}
		
		private function dealDeckCard(e:MouseEvent):void
		{
			var currentCard:Sprite = e.target as Sprite;
			
			var undealedCards:Sprite = deckContainer.getChildAt(0) as Sprite
			undealedCards.removeChild(currentCard);
			
			var dealPile:Sprite = deckContainer.getChildAt(1) as Sprite
			dealRandomCard(dealPile);
		}
		
		private function dealBackCard(dealAt:Sprite):void {
			var cardColor:String = "Back";
			var cardUrl:String = 0 + cardColor; 
			
			var card:Card = new Card(cardUrl, 0, cardsSkin);
				card.name = "back";
				card.addEventListener(MouseEvent.CLICK, flipCard, false, 0, true);
				card.y = (dealAt.numChildren - 1) * CARDS_Y_SPACING
				
			dealAt.addChild(card);
		}
		
		private function flipCard(e:MouseEvent):void {
			var backCard:Card = e.target as Card;
			var parentContainer:Sprite = backCard.parent as Sprite;
			
			if (isLastCardOfPile(backCard,parentContainer))
			{
				var cardY =  (parentContainer.numChildren - 2) * CARDS_Y_SPACING
				parentContainer.removeChild(backCard);
				dealRandomCard(parentContainer,cardY);
			}
		}
		
		private function dealRandomCard(dealAt:Sprite, y:int = 0):void
		{
			var rndCardNumber:int = randomRange(0, 103 - counterPlacedCards);
			dealAt.addChild(cards[rndCardNumber]).y = y;
			counterPlacedCards++;
			cards.splice(rndCardNumber, 1);
		}
		
		private function showSurrenderButton():void
		{
			buttonsContainer = new Sprite();
			
			var buttonWidth:int = 100;
			
			var surrenderButton:Button = new Button(buttonWidth, "  Surrender", true);
			surrenderButton.x = - 125
			surrenderButton.addEventListener(MouseEvent.CLICK, surrender, false, 0, true);
			
			var time:TimerCounter = new TimerCounter();
			time.y = 10;
			
			buttonsContainer.x = STAGE_WIDTH - buttonWidth;
			buttonsContainer.addChild(time);
			buttonsContainer.addChild(surrenderButton);
			
			addChild(buttonsContainer);
		}
		
		private function surrender(e:MouseEvent):void
		{
			gameOver();
		}
		
		private function showScore(e:MouseEvent):void { 
			//TODO:
		}
		
		private function saveScore():void {
			//TODO:
		}
		
		private function gameOver():void
		{
			saveScore();
			isGameRunning = false;
		}
		
		private function loadDeck():void
		{
			var cardUrl:String;
			var cardNumbers:int = 14;
			var cardColors:int = 4
			
			for (var loadTimes:int = 0; loadTimes < 2; loadTimes++)
			{
				for (var i:int = 0; i < cardNumbers; i++)
				{
					if (i == 0)
					{ //pass back card
						continue;
					}
					
					for (var j:int = 0; j < cardColors; j++)
					{
						var cardColor:String;
						
						if (i == 0)
						{
							cardColor = "Back";
							cardUrl = i + cardColor;
							
							var card:Card = new Card(cardUrl, i);
							cards.push(card);
							
							break;
						}
						else
						{
							switch (j)
							{
							case 0: 
								cardColor = "C";
								break;
							case 1: 
								cardColor = "D";
								break;
							case 2: 
								cardColor = "H";
								break;
							case 3: 
								cardColor = "S";
								break;
							}
						}
						
						cardUrl = i + cardColor;
						
						var card:Card = new Card(cardUrl, i, cardsSkin);
						card.addEventListener(MouseEvent.MOUSE_DOWN, startDraging, false, 0, true);
						card.addEventListener(MouseEvent.MOUSE_UP, stopDraging, false, 0, true);
						card.buttonMode = false;
						cards.push(card);
					}
				}
			}
		}
		
		private function startDraging(e:MouseEvent):void
		{
			var cardContainer:Sprite = e.target.parent as Sprite;
			
			if (isLastCardOfPile(e.target as Card, cardContainer))
			{
				movingCardObject = e.target as Sprite;
				
				movCardCurrentSprite = movingCardObject.parent as Sprite;
				movingCardObject.parent.removeChild(movingCardObject);
				
				addChild(movingCardObject);
				movingCardObject.x = mouseX - movingCardObject.width / 2;
				movingCardObject.y = mouseY - movingCardObject.height / 2;
				
				movingCardX = mouseX;
				movingCardY = mouseY;
				
				e.target.startDrag();
			}
		}
		
		private function stopDraging(e:MouseEvent):void
		{
			if (movingCardObject != null)
			{
				movingCardObject.stopDrag();
				var movingCard:Card = movingCardObject as Card;
				
				if (canBeMoved(movingCard))
				{
					removeChild(movingCardObject);
					movingCardObject.x = 0;
					
					if (movCardToFoundation)
					{
						movingCardObject.y = 0;
						movingCardObject.buttonMode = false;
						movingCardObject.removeEventListener(MouseEvent.MOUSE_DOWN, startDraging);
						movingCardObject.removeEventListener(MouseEvent.MOUSE_UP, stopDraging);
						
						score += 100;
					}
					else
					{
						movingCardObject.y = (movCardNewSprite.numChildren - 1) * CARDS_Y_SPACING
					}
					
					movCardNewSprite.addChild(movingCardObject);
					checkWin();
					
					resetMovCardVariables();
				}
				else // if can't be moved 
				{
					removeChild(movingCardObject);
					
					e.target.x = 0
					
					if (movCardCurrentSprite == deckContainer.getChildAt(1))
					{
						movingCardObject.y = 0;
					}
					else
					{
						e.target.y = (movCardCurrentSprite.numChildren - 1) * CARDS_Y_SPACING
					}
					movCardCurrentSprite.addChild(movingCardObject);
					
					resetMovCardVariables();
				}
			}
		}
		
		private function canBeMoved(givenCard:Card):Boolean
		{
			// check if card can be moved to target possition and if its true sets the sprite field to it 
			
			//foundation container
			if (givenCard.hitTestObject(foundationContainer))
			{
				for (var pile:int = 0; pile < foundationContainer.numChildren; pile++)
				{
					var pileContainer:Sprite = foundationContainer.getChildAt(pile) as Sprite;
					var lastCardIndex:int = pileContainer.numChildren - 1;
					var lastCard:Card;
					try
					{
						lastCard = pileContainer.getChildAt(lastCardIndex) as Card;
					}
					catch (err:Error)
					{
						trace("no last card");
					}
					
					if (givenCard.hitTestObject(pileContainer))
					{
						if (pileContainer.numChildren == 1 && givenCard.CardValue == 1)
						{
							movCardNewSprite = pileContainer as Sprite;
							movCardToFoundation = true ;
							return true;
						}
						else if (lastCard != null)
						{
							if (givenCard.CardValue == lastCard.CardValue + 1 && givenCard.CardSign == lastCard.CardSign)
							{
								movCardNewSprite = pileContainer as Sprite;
								movCardToFoundation = true ;
								return true;
							}
						}
					}
				}
			}
			
			//tauble container
			if (givenCard.hitTestObject(taublePilesContainer))
			{
				for (var pile:int = 0; pile < taublePilesContainer.numChildren; pile++)
				{
					var pileContainer:Sprite = taublePilesContainer.getChildAt(pile) as Sprite;
					var lastCardIndex:int = pileContainer.numChildren - 1;
					var lastCard:Card = pileContainer.getChildAt(lastCardIndex) as Card;
					
					if (givenCard.hitTestObject(pileContainer))
					{
						if (pileContainer.numChildren > 1)
						{
							if (lastCard.CardValue - 1 == givenCard.CardValue)
							{
								movCardNewSprite = pileContainer as Sprite;
								return true;
							}
						}
						else
						{
							movCardNewSprite = pileContainer as Sprite;
							return true;
						}
					}
				}
			}
			
			return false
		}
		
		private function resetMovCardVariables():void
		{
			movCardNewSprite = null;
			movCardToFoundation = false;
			movingCardObject = null;
			movCardCurrentSprite = null;
		}
		
		private function isLastCardOfPile(givenCard:Card, spriteContainer):Boolean
		{
			//checks in each container - reserved and container if the given object is equal to the last in the pile 
			
			for (var pile:int = 0; pile < spriteContainer.numChildren; pile++)
			{
				var pileContainer:Sprite = spriteContainer.getChildAt(pile) as Sprite;
				
				var lastCardIndex:int = spriteContainer.numChildren - 1;
				
				var card:Card = spriteContainer.getChildAt(lastCardIndex) as Card;
				
				if (givenCard == card)
				{
					return true;
				}
				
			}
			
			return false;
		}
		
		private function checkWin():void
		{
			isWin = true;
			
			for (var pile:int = 0; pile < foundationContainer.numChildren; pile++)
			{
				var pileContainer:Sprite = foundationContainer.getChildAt(pile) as Sprite;
				
				if (pileContainer.numChildren != 14)
				{
					isWin = false
				}
			}
			
			if (isWin)
			{
				gameOver();
			}
		}
		
		private function randomRange(minNum:Number, maxNum:Number):int
		{
			return (int(Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum));
		}
	}
}