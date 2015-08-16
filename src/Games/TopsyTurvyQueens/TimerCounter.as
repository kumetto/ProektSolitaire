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
		private var tHours:String;
		private var tMinutes:String;
		private var tSeconds:String;
		private var seconds:Number;
		private var minutes:Number;
		private var hours:Number;
		private var tField:TextField;
		
		public function TimerCounter()
		{
			timerLoader();
		}
		
		private function timerLoader():void
		{
			
			seconds = Math.floor(0);
			minutes = Math.floor(seconds / 60);
			hours = Math.floor(minutes / 60);
			hours %= 24;
			minutes %= 60;
			seconds %= 60;
			
			// Create the timer
			// Checks the clock function every 1000 milisecond (1 second)
			var timer:Timer = new Timer(1000);
			//Text field
			tField= new TextField();
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
		}
		
		// Function that increments the timer
		private function clock(evt:TimerEvent):void
		{
			tHours = (hours < 10) ? "0" + hours.toString() : hours.toString();
			tMinutes = (minutes < 10) ? "0" + minutes.toString() : minutes.toString();
			tSeconds = (seconds < 10) ? "0" + seconds.toString() : seconds.toString();
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

