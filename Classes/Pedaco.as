package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Edson Prata
	 */
	public class Pedaco extends Sprite
	{
		private var ix:Number;
		
		private var ax:Number;
		private var ay:Number;
		
		private var giro:Number;
		
		public function Pedaco () :void
		{
			super();
			
			giro = Math.random() * 20;
			ax = Math.random() * 20 - 10;
			ay = Math.random() * -20;
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		};
		
		private function enterFrameHandler (e:Event) :void 
		{
			ay++;
			giro++;
			
			this.x += ax;
			this.y += ay;
			
			this.rotation += ax;
			/*this.scaleX += 0.03;
			this.scaleY += 0.03;*/
			
			this.scaleX = ((giro % 20) - 10) / 10;
			
			this.alpha -= .015;
			
			if (this.y > 800)
			{
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				parent.removeChild(this);
			};
		};
		
		public function populaBitmap (bitmapData:BitmapData) :void
		{
			addChild(new Bitmap(bitmapData));
		};
	}
	
}