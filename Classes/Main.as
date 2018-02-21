package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import Galeria;
	/**
	* ...
	* @author Edson Prata
	*/
	public class Main extends Sprite
	{
		private var loader	:URLLoader;
		
		public function Main():void
		{
			carregaXML();
		}
		//função que carrega o XML
		private function carregaXML():void
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, enviaFotosHandler);
			loader.load (new URLRequest("../xml/fotos.xml"));
		}
		//função para enviar as fotos do XML
		public function enviaFotosHandler(evento:Event):void
		{
			var guardaXML:XML = new XML(evento.target.data);
			var galeria:Galeria = new Galeria(guardaXML);
			addChild(galeria);
		}
		
	}
	
}