package Games.TopsyTurvyQueens
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import com.greensock.*;
	import SharedClasses.*;
	
	
	/**
	 * ...
	 * @author Desislava
	 */
	public class TopsyQueensPlay extends Sprite
	{
		private var currCardTalon:Cards;
		private var countTalon:int = 0;
		private var moveCardsToStockTween:TweenLite;
		private var arrCardsDeck:Array = new Array();
		private var cardCoordsContainer:Dictionary = null;
		//private var arrCardsDeck2:Array = new Array();
		private const paddingCardsX:int = 20;
		private var paddingCardsY:int = 10;
		private var arrFaceDownStock:Array = new Array();
		
		private var isInit:Boolean = true;
		private var arrFaceUpTalon:Array = new Array();
		private var arrFaceDownFoundation:Array = new Array();
		
		private var arrFaceUpFoundation:Array = new Array();
		
		//private var arrFaceUpFoundation2:Array = new Array();
		//private var arrFaceUpFoundation3:Array = new Array();
		//private var arrFaceUpFoundation4:Array = new Array();
		//private var arrFaceUpFoundation5:Array = new Array();
		//private var arrFaceUpFoundation6:Array = new Array();
		//private var arrFaceUpFoundation7:Array = new Array();
		//private var arrFaceUpFoundation8:Array = new Array();
		
		//private var arrTableau:Array = new Array();
		private var arrTableau1:Array = new Array();
		private var arrTableau2:Array = new Array();
		private var arrTableau3:Array = new Array();
		private var arrTableau4:Array = new Array();
		private var arrTableau5:Array = new Array();
		private var arrTableau6:Array = new Array();
		private var arrTableau7:Array = new Array();
		private var arrTableau8:Array = new Array();
		
		public function TopsyQueensPlay()
		{
			
			var stockRect:Sprite = new Sprite();
			stockRect.graphics.beginFill(0x008080);
			stockRect.graphics.drawRect(42, 64, 72, 94);
			stockRect.graphics.endFill();
			addChild(stockRect);
			stockRect.alpha = 0;
			stockRect..addEventListener(MouseEvent.CLICK, clickStock);
			initCardsDeck();
			dealStock();
			initCoordsContainer();
		}
		
		private function initCardsDeck():void
		{
			const arrSuits:Array = ["C", "H", "S", "D"];
			for (var i:int = 0; i < 13; i++)
			{
				for (var k:int = 0; k < 2; k++)
				{
					for (var j:int = 0; j < 4; j++)
					{
						var currCardFaceUp:Cards = new Cards(i, arrSuits[j]);
						trace(currCardFaceUp.cardValue, currCardFaceUp.cardSuit);
						arrCardsDeck.push(currCardFaceUp);
							//arrCardsDeck2.push(currCardFaceUp);
						
					}
				}
			}
		
			//dealStock();
		}
		
		private function initCoordsContainer():void
		{
			cardCoordsContainer = new Dictionary(true);
			for (var i:int = 0; i < 65; i++)
			{
				cardCoordsContainer[arrFaceDownStock[i]] = new Point(arrFaceDownStock[i].x, arrFaceDownStock[i].y);
			}
			dealFoundation();
		}
		
		private function dealStock():void
		{
			var currFaceDownCardStock:Cards;
			for (var i:int = 0; i < 13; i++)
			{
				for (var j:int = 0; j < 5; j++)
				{
					currFaceDownCardStock = new Cards(13, "Back");
					currFaceDownCardStock.x = 42 + 1.5 * i;
					currFaceDownCardStock.y = 52 + paddingCardsY + 0.2 * i;
					addChild(currFaceDownCardStock);
					arrFaceDownStock.push(currFaceDownCardStock);
					currFaceDownCardStock.addEventListener(MouseEvent.CLICK, moveToTalon);				}
			}
			//for (var j:int = 0; j < 57; j++)
			//{
			//
			//var currFaceDownCard:Card = new Card(13, "Back");
			//currFaceDownCard.x = 42;
			//currFaceDownCard.y = 52 + paddingCardsY;
			//addChild(currFaceDownCard);
			//arrFaceDownStock.push(currFaceDownCard);
			//currFaceDownCard.addEventListener(MouseEvent.CLICK, moveToTalon);
			//
			//}
			//for (var i:int = 0; i < 8; i++)
			//{
			////42-stage.width/2-(currFaceDownCard.width*7+6*paddingCards);
			//var currFaceDownCard:Card = new Card(13, "Back");
			//currFaceDownCard.x = 42 - 1.5 * i;
			//currFaceDownCard.y = 52 + paddingCardsY - 1.5 * i;
			//addChild(currFaceDownCard);
			//arrFaceDownStock.push(currFaceDownCard);
			//currFaceDownCard.addEventListener(MouseEvent.CLICK, moveToTalon);
			//
			//}
		
		}
		
		private function dealFoundation():void
		{
			
			var padding:int = 0;
			paddingCardsY += 10;
			for (var i:int = 0; i < 7; i++)
			{
				var currFaceDownCard:Cards = new Cards(13, "Back");
				currFaceDownCard.x = 44 + currFaceDownCard.cardWidth * i + padding;
				padding += paddingCardsX;
				currFaceDownCard.y = 54 + currFaceDownCard.cardHeight + paddingCardsY;
				addChild(currFaceDownCard);
				arrFaceDownFoundation.push(currFaceDownCard);
			}
			dealTableaus();
		
		}
		
		private function dealTableaus():void
		{
			//optm
			var count:int = 0;
			var paddingX:int = 0;
			paddingCardsY += 10;
			var currIndex:int = 0;
			for (var i:int = 0; i < 4; i++)
			{
				currIndex = getRandomNumber();
				if ((currIndex < arrCardsDeck.length) && (currIndex > -1))
				{
					var currCardTableau1:Cards = arrCardsDeck[currIndex];
					addChild(currCardTableau1);
					currCardTableau1.x = 44 + paddingX + (currCardTableau1.width * count);
					currCardTableau1.y = 54 + 2 * currCardTableau1.cardHeight + paddingCardsY + i * paddingCardsX;
					arrTableau1.push(currCardTableau1);
					arrCardsDeck.splice(currIndex, 1);
				}
				
			}
			//arrTableau.push(arrTableau1);
			count++;
			paddingX += paddingCardsX;
			for (var j:int = 0; j < 4; j++)
			{
				currIndex = getRandomNumber();
				if ((currIndex < arrCardsDeck.length) && (currIndex > -1))
				{
					var currCardTableau2:Cards = arrCardsDeck[currIndex];
					addChild(currCardTableau2);
					currCardTableau2.x = 42 + paddingX + (currCardTableau2.cardWidth * count);
					currCardTableau2.y = 54 + 2 * currCardTableau2.cardHeight + paddingCardsY + j * paddingCardsX;
					arrTableau2.push(currCardTableau2);
					arrCardsDeck.splice(currIndex, 1);
				}
				
			}
			//arrTableau.push(arrTableau2);
			count++;
			paddingX += paddingCardsX;
			for (var k:int = 0; k < 4; k++)
			{
				currIndex = getRandomNumber();
				if ((currIndex < arrCardsDeck.length) && (currIndex > -1))
				{
					var currCardTableau3:Cards = arrCardsDeck[currIndex];
					addChild(currCardTableau3);
					currCardTableau3.x = 42 + paddingX + (currCardTableau3.cardWidth * count);
					currCardTableau3.y = 54 + 2 * currCardTableau2.cardHeight + paddingCardsY + k * paddingCardsX;
					arrTableau3.push(currCardTableau3);
					arrCardsDeck.splice(currIndex, 1);
				}
				
			}
			//arrTableau.push(arrTableau3);
			count++;
			paddingX += paddingCardsX;
			for (var l:int = 0; l < 4; l++)
			{
				currIndex = getRandomNumber();
				if ((currIndex < arrCardsDeck.length) && (currIndex > -1))
				{
					var currCardTableau4:Cards = arrCardsDeck[currIndex];
					addChild(currCardTableau4);
					currCardTableau4.x = 42 + paddingX + (currCardTableau4.cardWidth * count);
					currCardTableau4.y = 54 + 2 * currCardTableau4.cardHeight + paddingCardsY + l * paddingCardsX;
					arrTableau4.push(currCardTableau4);
					arrCardsDeck.splice(currIndex, 1);
				}
				
			}
			//arrTableau.push(arrTableau4);
			count++;
			paddingX += paddingCardsX;
			for (var m:int = 0; m < 4; m++)
			{
				currIndex = getRandomNumber();
				if ((currIndex < arrCardsDeck.length) && (currIndex > -1))
				{
					var currCardTableau5:Cards = arrCardsDeck[currIndex];
					addChild(currCardTableau5);
					currCardTableau5.x = 42 + paddingX + (currCardTableau5.cardWidth * count);
					currCardTableau5.y = 54 + 2 * currCardTableau4.cardHeight + paddingCardsY + m * paddingCardsX;
					arrTableau5.push(currCardTableau5);
					arrCardsDeck.splice(currIndex, 1);
				}
				
			}
			//arrTableau.push(arrTableau5);
			count++;
			paddingX += paddingCardsX;
			for (var n:int = 0; n < 4; n++)
			{
				currIndex = getRandomNumber();
				if ((currIndex < arrCardsDeck.length) && (currIndex > -1))
				{
					var currCardTableau6:Cards = arrCardsDeck[currIndex];
					addChild(currCardTableau6);
					currCardTableau6.x = 42 + paddingX + (currCardTableau5.cardWidth * count);
					currCardTableau6.y = 54 + 2 * currCardTableau4.cardHeight + paddingCardsY + n * paddingCardsX;
					arrTableau6.push(currCardTableau6);
					arrCardsDeck.splice(currIndex, 1);
				}
				
			}
			//arrTableau.push(arrTableau6);
			count++;
			paddingX += paddingCardsX;
			for (var o:int = 0; o < 4; o++)
			{
				currIndex = getRandomNumber();
				if ((currIndex < arrCardsDeck.length) && (currIndex > -1))
				{
					var currCardTableau7:Cards = arrCardsDeck[currIndex];
					addChild(currCardTableau7);
					currCardTableau7.x = 42 + paddingX + (currCardTableau5.cardWidth * count);
					currCardTableau7.y = 54 + 2 * currCardTableau4.cardHeight + paddingCardsY + o * paddingCardsX;
					arrTableau7.push(currCardTableau7);
					arrCardsDeck.splice(currIndex, 1);
				}
				
			}
			//arrTableau.push(arrTableau7);
			count++;
			paddingX += paddingCardsX;
			for (var p:int = 0; p < 4; p++)
			{
				currIndex = getRandomNumber();
				if ((currIndex < arrCardsDeck.length) && (currIndex > -1))
				{
					var currCardTableau8:Cards = arrCardsDeck[currIndex];
					addChild(currCardTableau8);
					currCardTableau8.x = 42 + paddingX + (currCardTableau5.cardWidth * count);
					currCardTableau8.y = 54 + 2 * currCardTableau4.cardHeight + paddingCardsY + p * paddingCardsX;
					arrTableau8.push(currCardTableau8);
					arrCardsDeck.splice(currIndex, 1);
					
				}
				
			}
			//arrTableau.push(arrTableau7);
			
		
		}
		
		private function getRandomNumber():int
		{
			var randomNum:int = Math.floor(Math.random() * ((arrCardsDeck.length - 1) - 0 + 1) + 0);
			return randomNum;
		}
		
		private function moveToTalon(evt:MouseEvent):void
		{
			trace(arrFaceUpFoundation.length);
			var currFreeIndex:int = arrFaceUpFoundation.length;
			var currIndex:int = getRandomNumber();
			var currCardTalon:Cards = arrCardsDeck[currIndex];
			var currCardFaceDown:Cards = evt.currentTarget as Cards;
			addChild(currCardTalon);
			
			if ((currFreeIndex < 8) && (currCardTalon.cardValue == 0))
			{
				if (currFreeIndex == 7)
				{
					currCardTalon.x = 44 + currCardFaceDown.cardWidth * 7 + 120;
					currCardTalon.y = 54 + currCardFaceDown.cardHeight + paddingCardsY;
					
					arrFaceUpFoundation.push(currCardTalon);
					
					arrCardsDeck.splice(currIndex, 1);
					arrFaceDownStock.splice(currIndex, 1);
					currCardFaceDown.removeEventListener(MouseEvent.CLICK, moveToTalon);
					removeChild(currCardFaceDown);
				}
				else
				{
					currCardTalon.x = arrFaceDownFoundation[currFreeIndex].x
					currCardTalon.y = arrFaceDownFoundation[currFreeIndex].y;
					arrFaceUpFoundation.push(currCardTalon);
					arrCardsDeck.splice(currIndex, 1);
					arrFaceDownStock.splice(currIndex, 1);
					currCardFaceDown.removeEventListener(MouseEvent.CLICK, moveToTalon);
					removeChild(currCardFaceDown);
				}
			}
			else
			{
			
				currCardTalon.x = 42 + paddingCardsX + currCardTalon.cardWidth;
				currCardTalon.y = 64;
				currCardFaceDown.removeEventListener(MouseEvent.CLICK, moveToTalon);
				removeChild(currCardFaceDown);
				arrFaceUpTalon.push(currCardTalon);
				arrFaceUpTalon[arrFaceUpTalon.length - 1].addEventListener(MouseEvent.MOUSE_DOWN, moveTalonCardDown, false, 0, true);
				arrFaceUpTalon[arrFaceUpTalon.length - 1].addEventListener(MouseEvent.MOUSE_UP, moveTalonCardUp,false,0,true);
				arrCardsDeck.splice(currIndex, 1);
			}
			
		
		}
		private function resetMoveToTalon():void
		{
		
			for (var i:int = 0; i < arrFaceDownStock.length; i++)
			{
				if (arrFaceDownStock[i] != null)
				{
					arrFaceDownStock[i].addEventListener(MouseEvent.CLICK, clickResetMoveToTalon, false, 0, true);
				}
			}
		}
		private function clickResetMoveToTalon(evt:MouseEvent):void
		{
			if (countTalon >= arrFaceUpTalon.length)
			{
				countTalon = 0;
			}
			var currFaceDownCard:Cards = evt.currentTarget as Cards;
			removeChild(currFaceDownCard);
			addChild(arrFaceUpTalon[countTalon]);
			countTalon++;
			
		}
		
		private function clickStock(evt:MouseEvent):void
		{
			
			//trace(arrFaceDownStock.length);
			//initMoveCardsToStock();
			
			
			var indexFaceUpTalon:int = arrFaceUpTalon.length - 1;
			
			
			for (var i:int = 0; i < arrFaceUpTalon.length; i++)
			{
				if ((arrFaceUpTalon[indexFaceUpTalon] != null)&&(arrFaceDownStock[i]!= null))
				{
					arrFaceUpTalon[indexFaceUpTalon].parent.removeChild(arrFaceUpTalon[indexFaceUpTalon]);
					addChild(arrFaceDownStock[i]);
				}
				indexFaceUpTalon--;
			}
			resetMoveToTalon();
		
		}
		private function moveTalonCardDown(evt:MouseEvent):void
		{
			
			evt.currentTarget.startDrag();
			currCardTalon = evt.currentTarget as Cards;
			
		}
		private function moveTalonCardUp(evt:MouseEvent):void
		{
			
			evt.currentTarget.stopDrag();
			
			checkCollisionTalon();
		}
		private function checkCollisionTalon():void
		{
			var currIndex:int = arrFaceUpTalon.indexOf(currCardTalon);
			trace(arrTableau1[arrTableau1.length - 1].cardSuit);
			trace(currCardTalon.cardSuit);
			trace(arrTableau1[arrTableau1.length - 1].cardValue);
			trace(currCardTalon.cardValue+1);
			if ((arrTableau1[arrTableau1.length - 1].hitTestPoint(mouseX, mouseY)) &&
			(arrTableau1[arrTableau1.length - 1].cardValue == currCardTalon.cardValue+1) &&
			(arrTableau1[arrTableau1.length - 1].cardSuit == currCardTalon.cardSuit))
			{
				trace(arrFaceUpTalon.indexOf(currCardTalon) > -1);
				//if (arrFaceUpTalon.indexOf(currCardTalon) > -1)
				//{
					//var currIndex:int = arrFaceUpTalon.indexOf(currCardTalon);
					arrFaceUpTalon.splice(currIndex, 1);
					arrFaceDownStock.splice(currIndex, 1);
					//arrFaceDownStock[currIndex].removeEventListener(MouseEvent.CLICK, clickResetMoveToTalon);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_DOWN, moveTalonCardDown);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_UP, moveTalonCardUp);
					
					
				//}
				
				currCardTalon.x = arrTableau1[arrTableau1.length - 1].x;
				currCardTalon.y = arrTableau1[arrTableau1.length - 1].y + 20;
				arrTableau1.push(currCardTalon);
				
			}
			
			else if ((arrTableau2[arrTableau2.length - 1].hitTestPoint(mouseX, mouseY)) &&
			(arrTableau2[arrTableau2.length - 1].cardValue == currCardTalon.cardValue+1) &&
			(arrTableau2[arrTableau2.length - 1].cardSuit == currCardTalon.cardSuit))
			{
				trace(arrFaceUpTalon.indexOf(currCardTalon) > -1);
				//if (arrFaceUpTalon.indexOf(currCardTalon) > -1)
				//{
					
					arrFaceUpTalon.splice(currIndex, 1);
					arrFaceDownStock.splice(currIndex, 1);
					//arrFaceDownStock[currIndex].removeEventListener(MouseEvent.CLICK, clickResetMoveToTalon);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_DOWN, moveTalonCardDown);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_UP, moveTalonCardUp);
					
				//}
				
				currCardTalon.x = arrTableau2[arrTableau2.length - 1].x;
				currCardTalon.y = arrTableau2[arrTableau2.length - 1].y + 20;
				arrTableau2.push(currCardTalon);
				
			}
			else if ((arrTableau3[arrTableau3.length - 1].hitTestPoint(mouseX, mouseY)) &&
			(arrTableau3[arrTableau3.length - 1].cardValue == currCardTalon.cardValue+1) &&
			(arrTableau3[arrTableau3.length - 1].cardSuit == currCardTalon.cardSuit))
			{
				trace(arrFaceUpTalon.indexOf(currCardTalon) > -1);
				//if (arrFaceUpTalon.indexOf(currCardTalon) > -1)
				//{
					
					arrFaceUpTalon.splice(currIndex, 1);
					arrFaceDownStock.splice(currIndex, 1);
					//arrFaceDownStock[currIndex].removeEventListener(MouseEvent.CLICK, clickResetMoveToTalon);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_DOWN, moveTalonCardDown);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_UP, moveTalonCardUp);
					
				//}
				
				currCardTalon.x = arrTableau3[arrTableau3.length - 1].x;
				currCardTalon.y = arrTableau3[arrTableau3.length - 1].y + 20;
				arrTableau3.push(currCardTalon);
				
			}
			else if ((arrTableau4[arrTableau4.length - 1].hitTestPoint(mouseX, mouseY)) &&
			(arrTableau4[arrTableau4.length - 1].cardValue == currCardTalon.cardValue+1) &&
			(arrTableau4[arrTableau4.length - 1].cardSuit == currCardTalon.cardSuit))
			{
				trace(arrFaceUpTalon.indexOf(currCardTalon) > -1);
				//if (arrFaceUpTalon.indexOf(currCardTalon) > -1)
				//{
					
					arrFaceUpTalon.splice(currIndex, 1);
					arrFaceDownStock.splice(currIndex, 1);
					//arrFaceDownStock[currIndex].removeEventListener(MouseEvent.CLICK, clickResetMoveToTalon);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_DOWN, moveTalonCardDown);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_UP, moveTalonCardUp);
					
				//}
				
				currCardTalon.x = arrTableau4[arrTableau4.length - 1].x;
				currCardTalon.y = arrTableau4[arrTableau4.length - 1].y + 20;
				arrTableau4.push(currCardTalon);
				
			}
			else if ((arrTableau5[arrTableau5.length - 1].hitTestPoint(mouseX, mouseY)) &&
			(arrTableau5[arrTableau5.length - 1].cardValue == currCardTalon.cardValue+1) &&
			(arrTableau5[arrTableau5.length - 1].cardSuit == currCardTalon.cardSuit))
			{
				trace(arrFaceUpTalon.indexOf(currCardTalon) > -1);
				//if (arrFaceUpTalon.indexOf(currCardTalon) > -1)
				//{
					
					arrFaceUpTalon.splice(currIndex, 1);
					arrFaceDownStock.splice(currIndex, 1);
					//arrFaceDownStock[currIndex].removeEventListener(MouseEvent.CLICK, clickResetMoveToTalon);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_DOWN, moveTalonCardDown);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_UP, moveTalonCardUp);
					
				//}
				
				currCardTalon.x = arrTableau5[arrTableau5.length - 1].x;
				currCardTalon.y = arrTableau5[arrTableau5.length - 1].y + 20;
				arrTableau5.push(currCardTalon);
				
			}
			else if ((arrTableau6[arrTableau6.length - 1].hitTestPoint(mouseX, mouseY)) &&
			(arrTableau6[arrTableau6.length - 1].cardValue == currCardTalon.cardValue+1) &&
			(arrTableau6[arrTableau6.length - 1].cardSuit == currCardTalon.cardSuit))
			{
				trace(arrFaceUpTalon.indexOf(currCardTalon) > -1);
				//if (arrFaceUpTalon.indexOf(currCardTalon) > -1)
				//{
					
					arrFaceUpTalon.splice(currIndex, 1);
					arrFaceDownStock.splice(currIndex, 1);
					//arrFaceDownStock[currIndex].removeEventListener(MouseEvent.CLICK, clickResetMoveToTalon);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_DOWN, moveTalonCardDown);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_UP, moveTalonCardUp);
					
				//}
				
				currCardTalon.x = arrTableau6[arrTableau6.length - 1].x;
				currCardTalon.y = arrTableau6[arrTableau6.length - 1].y + 20;
				arrTableau6.push(currCardTalon);
				
			}
			else if ((arrTableau7[arrTableau7.length - 1].hitTestPoint(mouseX, mouseY)) &&
			(arrTableau7[arrTableau7.length - 1].cardValue == currCardTalon.cardValue+1) &&
			(arrTableau7[arrTableau7.length - 1].cardSuit == currCardTalon.cardSuit))
			{
				trace(arrFaceUpTalon.indexOf(currCardTalon) > -1);
				//if (arrFaceUpTalon.indexOf(currCardTalon) > -1)
				//{
					
					arrFaceUpTalon.splice(currIndex, 1);
					arrFaceDownStock.splice(currIndex, 1);
					//arrFaceDownStock[currIndex].removeEventListener(MouseEvent.CLICK, clickResetMoveToTalon);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_DOWN, moveTalonCardDown);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_UP, moveTalonCardUp);
					
				//}
				
				currCardTalon.x = arrTableau7[arrTableau7.length - 1].x;
				currCardTalon.y = arrTableau7[arrTableau7.length - 1].y + 20;
				arrTableau7.push(currCardTalon);
				
			}
			else if ((arrTableau8[arrTableau8.length - 1].hitTestPoint(mouseX, mouseY)) &&
			(arrTableau8[arrTableau8.length - 1].cardValue == currCardTalon.cardValue+1) &&
			(arrTableau8[arrTableau8.length - 1].cardSuit == currCardTalon.cardSuit))
			{
				trace(arrFaceUpTalon.indexOf(currCardTalon) > -1);
				//if (arrFaceUpTalon.indexOf(currCardTalon) > -1)
				//{
					
					arrFaceUpTalon.splice(currIndex, 1);
					arrFaceDownStock.splice(currIndex, 1);
					//arrFaceDownStock[currIndex].removeEventListener(MouseEvent.CLICK, clickResetMoveToTalon);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_DOWN, moveTalonCardDown);
					currCardTalon.removeEventListener(MouseEvent.MOUSE_UP, moveTalonCardUp);
					
				//}
				
				currCardTalon.x = arrTableau8[arrTableau8.length - 1].x;
				currCardTalon.y = arrTableau8[arrTableau8.length - 1].y + 20;
				arrTableau8.push(currCardTalon);
				
			}
			else
			{
				TweenMax.to(currCardTalon, 0.5, { x:42 + paddingCardsX + currCardTalon.cardWidth, y:64 } );
				return;
			}
		}
	
	
		//private function initMoveCardsToStock():void
		//{
		//
		////indexFaceUpCards--;
		////indexFaceDownCard++;
		////addChild(arrFaceDownStock[indexFaceUpCards]);
		//moveCardsToStock(arrFaceUpTalon.length - 1, 0);
		//
		//}
		//
		//private function moveCardsToStock(indexFaceUpCard:int, indexFaceDownCard:int):void
		//{
		//
		////enterFrame
		//moveCardsToStockTween = new TweenMax(arrFaceUpTalon[indexFaceUpCard], 0,1, {rotationY: 180, x: arrFaceDownStock[indexFaceDownCard].x, y: arrFaceDownStock[indexFaceDownCard].y, onComplete: resetIndex, onCompleteParams: [indexFaceUpCard, indexFaceDownCard],delay:1.5});
		//}
	
		//private function resetIndex(resetIndexFaceUpCard:int, resetIndexFaceDownCard:int):void
		//{
		//if (resetIndexFaceUpCard > -1)
		//{
		//resetIndexFaceUpCard--;
		//resetIndexFaceDownCard++;
		//removeChild(arrFaceUpTalon[resetIndexFaceUpCard]);
		//addChild(arrFaceDownStock[resetIndexFaceDownCard]);
		//moveCardsToStock(resetIndexFaceUpCard, resetIndexFaceDownCard);
		//}
		//else
		//{
		//return;
		//}
		//}
	
	}

}