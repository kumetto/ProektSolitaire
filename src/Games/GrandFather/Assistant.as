package Games.GrandFather 
{
	import SharedClasses.Card;
	import flash.events.*
	
	/**
	 * ...
	 * @author Kolarov
	 */
	public class Assistant 
	{
		
		public function Assistant() 
		{
			
		}
		
		public static function dealing(deck:Deck,fieldPiles:Array):void {
			for (var pileIndex:int = 0; pileIndex < fieldPiles.length; pileIndex++) {
				var currentPile:FieldPile = fieldPiles[pileIndex];
				var dealtCard:Card = deck.giveTopCard();	
				currentPile.pushCard(dealtCard);
			}
		}
		
		public static function addEventListenerTo(obj:Object,eventConst:String,functionToTrigger:Function):void {
			obj.addEventListener(eventConst, functionToTrigger);
		}
		
		public static function removeEventListenerTo(obj:Object,eventConst:String,functionToTrigger:Function):void {
			obj.removeEventListener(eventConst, functionToTrigger);
		}
	}

}