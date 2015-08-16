package
{
	import flash.display.Sprite;
	import Games.TopsyTurvyQueens.TopsyMainMenu;
	import SharedClasses.MenuButton;
	
	/**
	 * ...
	 * @author SS
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			var game:TopsyMainMenu = new TopsyMainMenu();
			addChild(game);
			
		}
		
	}
	
}