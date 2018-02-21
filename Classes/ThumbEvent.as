package  
{
	import flash.events.Event;
	
	/**
	* ...
	* @author Fernando "Vô" Santos
	*/
	public class ThumbEvent extends Event
	{
		
		public static const THUMB_SELECIONADA:String 	= "thumbSelecionada";
		public static const PROXIMA_FOTO	 :String	= "proximaFoto";
		public static const FOTO_ANTERIOR	 :String	= "fotoAnterior";
		private var _parametro:Object;
		public function get parametro():Object
		{
			return _parametro;
		}
		
		
		public function ThumbEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, parametro:Object = null)
		{ 
			super(type, bubbles, cancelable);
			_parametro = parametro;
		} 
		
		public override function clone():Event { 
			return new ThumbEvent(type, bubbles, cancelable, _parametro);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ThumbEvent", "type", "bubbles", "cancelable", "eventPhase", "parametro"); 
		}
		
	}
	
}