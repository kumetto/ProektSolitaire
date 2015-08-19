package Games.EightOff
{
	import flash.display.Sprite;
	import Games.GrandFather.Assistant;
	import flash.events.MouseEvent;
	import SharedClasses.Card;
	
	/**
	 * ...
	 * @author Kolarov
	 */
	public class Engine
	{
		private var general:Sprite;
		private var extraPiles:Array = [];//8
		private var fieldPiles:Array = [];//8
		private var sidePiles:Array = [];//4
		private var tempPile:TempCardsPile = new TempCardsPile();
		
		private var deck:Deck;
		private var dealing:Dealing;
		
		private var pressedExtraPile:ExtraPile;
		private var pressedFieldPile:FieldPile;
		private var cardForMoving:Card;
		private var cardsForMoving:Array;
		
		private var isGameRunning:Boolean = true;
		private var isWin:Boolean = false;
		
		public function Engine(generalPar:Sprite, extraPilesPar:Array, fieldPilesPar:Array, sidePilesPar:Array, deckPar:Deck, isGameRunningPar:Boolean, isWinPar:Boolean)
		{
			initFields(generalPar, extraPilesPar, fieldPilesPar, sidePilesPar, deckPar, isGameRunningPar, isWinPar);
			dealing.initialDealing();
			makeInteraction();
		}
		
		/////////////////////////////////////////// INTERACTION //////////////////////////////////////////////////////
		private function makeInteraction():void
		{
			makeExtraPilesInteractive();
			makeFieldPilesInteractive();
		}
		
		// EXTRA PILES INTERACTION
		private function makeExtraPilesInteractive():void
		{
			for (var extraPileIndex:int = 0; extraPileIndex < this.extraPiles.length; extraPileIndex++)
			{
				var extraPile:ExtraPile = this.extraPiles[extraPileIndex];
				Assistant.addEventListenerTo(extraPile, MouseEvent.MOUSE_DOWN, dragCardFromExtraPile);
			}
		}
		
		private function dragCardFromExtraPile(e:MouseEvent):void
		{
			this.pressedExtraPile = e.currentTarget as ExtraPile;
			this.cardForMoving = this.pressedExtraPile.giveCard();
			invokeTempPileToMouse();
			this.tempPile.pushCard(this.cardForMoving);
			this.tempPile.startDrag();
			Assistant.addEventListenerTo(this.tempPile, MouseEvent.MOUSE_UP, dropTakenCardFromExtraPile);
		}
		
		private function dropTakenCardFromExtraPile(e:MouseEvent):void
		{
			var isAllowedToDrop:Boolean = false;
			for (var extraPileIndex:int = 0; extraPileIndex < extraPiles.length; extraPileIndex++)
			{//check for extra pile collision
				var extraPile:ExtraPile = this.extraPiles[extraPileIndex];
				if (extraPile.hitTestPoint(this.general.mouseX, this.general.mouseY))
				{
					if (extraPile.isEmpty)
					{
						this.cardForMoving = this.tempPile.giveCard();
						extraPile.pushCard(this.cardForMoving);
						isAllowedToDrop = true;
						this.tempPile.stopDrag();
					}
				}
			}
			
			if (!isAllowedToDrop)
			{
				for (var fieldPileIndex:int = 0; fieldPileIndex < fieldPiles.length; fieldPileIndex++)
				{//check for field pile collision
					var fieldPile:FieldPile = this.fieldPiles[fieldPileIndex];
					if (fieldPile.hitTestPoint(this.general.mouseX, this.general.mouseY))
					{
						if (fieldPile.CardsCount != 0 && fieldPile.TopCard.CardValue - 1 == this.tempPile.FirstCard.CardValue && fieldPile.TopCard.CardSign == this.tempPile.FirstCard.CardSign || fieldPile.CardsCount == 0 && tempPile.FirstCard.CardValue == 13)
						{
							this.cardForMoving = this.tempPile.giveCard();
							fieldPile.pushCard(this.cardForMoving);
							isAllowedToDrop = true;
							this.tempPile.stopDrag();
						}
					}
				}
			}
			
			if (!isAllowedToDrop)
			{
				for (var sidePileIndex:int = 0; sidePileIndex < sidePiles.length; sidePileIndex++)
				{//check for side pile collision
					var sidePile:SidePile = this.sidePiles[sidePileIndex];
					if (sidePile.hitTestPoint(this.general.mouseX, this.general.mouseY))
					{
						if ((sidePile.TopCard == null && this.tempPile.FirstCard.CardValue == 1 && sidePile.Suit == this.tempPile.FirstCard.CardSign) || (sidePile.TopCard != null && sidePile.TopCard.CardValue == this.tempPile.FirstCard.CardValue - 1 && sidePile.Suit == tempPile.FirstCard.CardSign))
						{
							this.cardForMoving = this.tempPile.giveCard();
							sidePile.pushCard(this.cardForMoving);
							isAllowedToDrop = true;
							this.tempPile.stopDrag();
						}
					}
				}
				if (isThereWin())
				{
					this.isWin = true;
					this.isGameRunning = false;
				}
			}
			
			if (!isAllowedToDrop)
			{
				returnCardToExtraPile();
			}
			Assistant.removeEventListenerTo(this.tempPile, MouseEvent.MOUSE_UP, dropTakenCardFromExtraPile);
			removeTempPile();
		}
		
		// FIELD PILES INTERACTION
		private function makeFieldPilesInteractive():void
		{
			for (var fieldPileIndex:int = 0; fieldPileIndex < this.fieldPiles.length; fieldPileIndex++)
			{
				var fieldPile:FieldPile = this.fieldPiles[fieldPileIndex];
				Assistant.addEventListenerTo(fieldPile, MouseEvent.MOUSE_DOWN, dragCardsFromFieldPile);
			}
		}
		
		private function dragCardsFromFieldPile(e:MouseEvent):void
		{
			this.pressedFieldPile = e.currentTarget as FieldPile;
			var choosenStartCard:Card;
			for (var cardIndex:int = 0; cardIndex < this.pressedFieldPile.CardsCount; cardIndex++)
			{
				var card:Card = pressedFieldPile.Cards[cardIndex];
				if (card.hitTestPoint(this.general.mouseX, this.general.mouseY))
				{
					choosenStartCard = card;
				}
			}
			if (pressedFieldPile.isSequenceFrom(choosenStartCard))
			{
				
				this.cardsForMoving = this.pressedFieldPile.giveCards(choosenStartCard);
				invokeTempPileToMouse();
				this.tempPile.pushCards(this.cardsForMoving);
				this.tempPile.startDrag();
				Assistant.addEventListenerTo(this.tempPile, MouseEvent.MOUSE_UP, dropTakenCardsFromFieldPile);
			}
		}
		
		private function dropTakenCardsFromFieldPile(e:MouseEvent):void
		{
			var isAllowedToDrop:Boolean = false;
			if (this.tempPile.CardsCount == 1)
			{
				//check extra piles for collision
				for (var extraPileIndex:int = 0; extraPileIndex < extraPiles.length; extraPileIndex++)
				{
					var extraPile:ExtraPile = this.extraPiles[extraPileIndex];
					if (extraPile.hitTestPoint(this.general.mouseX, this.general.mouseY))
					{
						if (extraPile.isEmpty)
						{
							this.cardForMoving = this.tempPile.giveCard();
							extraPile.pushCard(this.cardForMoving);
							isAllowedToDrop = true;
							this.tempPile.stopDrag();
						}
					}
				}
				if (!isAllowedToDrop)
				{
					//check field piles for collision	
					for (var fieldPileIndex:int = 0; fieldPileIndex < this.fieldPiles.length; fieldPileIndex++)
					{
						var fieldPile:FieldPile = this.fieldPiles[fieldPileIndex];
						if (fieldPile.hitTestPoint(this.general.mouseX, this.general.mouseY))
						{
							if (fieldPile.CardsCount != 0 && fieldPile.TopCard.CardValue - 1 == this.tempPile.FirstCard.CardValue && fieldPile.TopCard.CardSign == this.tempPile.FirstCard.CardSign || (fieldPile.CardsCount == 0 && this.tempPile.FirstCard.CardValue == 13))
							{
								this.cardForMoving = this.tempPile.giveCard();
								fieldPile.pushCard(this.cardForMoving);
								isAllowedToDrop = true;
								this.tempPile.stopDrag();
							}
						}
					}
					if (isThereWin())
					{
						this.isGameRunning = false;
						this.isWin = true;
					}
				}
				if (!isAllowedToDrop)
				{
					for (var sidePileIndex:int = 0; sidePileIndex < this.sidePiles.length; sidePileIndex++)
					{
						//check side piles for collision
						var sidePile:SidePile = this.sidePiles[sidePileIndex];
						if (sidePile.hitTestObject(this.tempPile) && this.tempPile.CardsCount == 1)
						{
							if ((sidePile.TopCard == null && this.tempPile.FirstCard.CardValue == 1 && sidePile.Suit == this.tempPile.FirstCard.CardSign) || (sidePile.TopCard != null && sidePile.TopCard.CardValue == this.tempPile.FirstCard.CardValue - 1 && sidePile.Suit == tempPile.FirstCard.CardSign))
							{
								this.cardForMoving = this.tempPile.giveCard();
								sidePile.pushCard(this.cardForMoving);
								isAllowedToDrop = true;
								this.tempPile.stopDrag();
							}
						}
					}
				}
			}
			else if (this.tempPile.CardsCount > 1)
			{
				for (fieldPileIndex = 0; fieldPileIndex < this.fieldPiles.length; fieldPileIndex++)
				{
					fieldPile = this.fieldPiles[fieldPileIndex];
					if (fieldPile.hitTestPoint(this.general.mouseX, this.general.mouseY))
					{
						if (((fieldPile.CardsCount > 0) && (fieldPile.TopCard.CardValue == this.tempPile.FirstCard.CardValue + 1) && (fieldPile.TopCard.CardSign == this.tempPile.FirstCard.CardSign)) || (fieldPile.CardsCount == 0))
						{
							this.cardsForMoving = this.tempPile.giveCards();
							fieldPile.pushCards(this.cardsForMoving);
							isAllowedToDrop = true;
							this.tempPile.stopDrag();
						}
					}
				}
			}
			if (!isAllowedToDrop)
			{
				returnCardsToFieldPile();
			}
			Assistant.removeEventListenerTo(this.tempPile, MouseEvent.MOUSE_UP, dropTakenCardsFromFieldPile);
			removeTempPile();
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		private function initFields(generalPar:Sprite, extraPilesPar:Array, fieldPilesPar:Array, sidePilesPar:Array, deckPar:Deck, isGameRunningPar:Boolean, isWinPar:Boolean):void
		{
			this.general = generalPar;
			this.extraPiles = extraPilesPar;
			this.fieldPiles = fieldPilesPar;
			this.sidePiles = sidePilesPar;
			this.deck = deckPar;
			this.isGameRunning = isGameRunningPar;
			this.isWin = isWinPar;
			this.dealing = new Dealing(this.deck, this.fieldPiles, this.extraPiles);
		}
		
		private function invokeTempPileToMouse():void
		{
			this.general.addChild(tempPile);
			this.tempPile.x = general.mouseX - 20;
			this.tempPile.y = general.mouseY - 20;
		}
		
		private function removeTempPile():void
		{
			this.general.removeChild(tempPile);
		}
		
		private function returnCardToExtraPile():void
		{
			this.pressedExtraPile.pushCard(this.cardForMoving);
		}
		
		private function returnCardsToFieldPile():void
		{
			this.pressedFieldPile.pushCards(this.cardsForMoving);
		}
		
		private function isThereWin():Boolean
		{
			var win:Boolean = false;
			for (var sidePileIndex:int = 0; sidePileIndex < this.sidePiles.length; sidePileIndex++)
			{
				var currentSidePile:SidePile = this.sidePiles[sidePileIndex];
				if (currentSidePile.CardsCount == 13)
				{
					win = true;
				}
			}
			return win;
		}
	
	}

}