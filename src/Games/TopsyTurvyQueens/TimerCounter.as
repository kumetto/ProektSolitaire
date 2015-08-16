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
	import com.greensock.easing.*;
	import flash.ui.Keyboard;
	import flash.geom.ColorTransform;
	import flash.net.*;
	
	/**
	 * ...
	 * @author SS
	 */
	public class TimerCounter extends Sprite
	{
		
		public function TimerCounter()
		{
			
			var currentTime:Date = new Date();
			var seconds:Number = Math.floor(0);
			var minutes:Number = Math.floor(seconds / 60);
			var hours:Number = Math.floor(minutes / 60);
			hours %= 24;
			minutes %= 60;
			seconds %= 60;
			
			// Create the timer
			// Checks the clock function every 1000 milisecond (1 second)
			var timer:Timer = new Timer(1000);
			//Text field
			var tField:TextField = new TextField();
			tField.y = 1;
			tField.height = 30;
			tField.width = 200;
			tField.x = 355;
			var txtFormat:TextFormat = new TextFormat('Comic Sans MS', 15, 0xFFFFFF, true);
			txtFormat.align = "center";
			tField.defaultTextFormat = txtFormat;
			tField.mouseEnabled = false;
			addChild(tField);
			timer.addEventListener(TimerEvent.TIMER, clock);
			timer.start();
			
			// Function that increments the timer
			function clock(evt:TimerEvent):void
			{
				var tHours:String = (hours < 10) ? "0" + hours.toString() : hours.toString();
				var tMinutes:String = (minutes < 10) ? "0" + minutes.toString() : minutes.toString();
				var tSeconds:String = (seconds < 10) ? "0" + seconds.toString() : seconds.toString();
				// every time this function is checked increment second by one
				seconds += 1;
				// If the second is 59
				if (seconds > 59)
				{
					// The minute will be plussed with 1
					minutes += 1;
					//and the zero will be set to 00
					seconds = 00;
				}
				// Displays the time in the textbox
				tField.text = String(tHours + ":" + tMinutes + ":" + tSeconds);
			}
		}
	
	}
}

