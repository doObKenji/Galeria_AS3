package
{
	import fl.transitions.easing.Bounce;
	import fl.transitions.easing.Elastic;
	import fl.transitions.easing.None;
	import fl.transitions.Tween;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	* ...
	* @author Edson Prata
	*/
	public class Thumb extends MovieClip
	{
		private var loader		:Loader;
		private var _conteudo	:Object;
		public function get conteudo():Object { return _conteudo; }
		public function set conteudo(value:Object):void { _conteudo = value; }
		
		private var fundo		:Shape;
		private var anima		:Tween;
		private var barraLoader:Sprite;
		
		public function Thumb(conteudo:Object):void 
		{
			super();
			//cria um fundo para foto
			fundo = new Shape();
			fundo.graphics.beginFill(0x000000);
			fundo.graphics.drawRect(0, 0, 150, 90);
			fundo.graphics.endFill();
			
			addChild(fundo);
			
			loader = new Loader();
			this.conteudo = conteudo;
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderProgressHandler);
			loader.contentLoaderInfo.addEventListener(Event.INIT, thumbCarregada);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, animaIntroFotoHandler);
			loader.load(new URLRequest("../thumbs/" + conteudo.thumb));
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			barraLoader = new Sprite();
			barraLoader.blendMode = BlendMode.INVERT;
			barraLoader.graphics.beginFill(0x000000);
			barraLoader.x = 10;
			barraLoader.y = 40;
			barraLoader.graphics.drawRect(0, 0, 130, 10);
			barraLoader.graphics.endFill();
			
			addChild(barraLoader);
			useHandCursor = true;
			buttonMode = true;
			
		}
		//função para carregar a thumb
		private function thumbCarregada(e:Event):void 
		{
			addChild(loader);
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			anima = new Tween(this, "scaleX", Bounce.easeOut, this.scaleX, 1.03, 1, true);
			anima = new Tween(this, "scaleY", Bounce.easeOut, this.scaleY, 1.03, 1, true);
		}
		private function onMouseOut(e:MouseEvent):void
		{
			anima = new Tween(this, "scaleX", Bounce.easeOut, this.scaleX , 1, 1, true);
			anima = new Tween(this, "scaleY", Bounce.easeOut, this.scaleY , 1, 1, true);
		}
		
		private function loaderProgressHandler(e:ProgressEvent):void 
		{
			barraLoader.scaleX = e.bytesLoaded / e.bytesTotal;
		};
		
		
		private function animaIntroFotoHandler(e:Event):void
		{
			barraLoader.visible = false;
			anima = new Tween(loader, "alpha", None.easeOut, 0, 1, 2, true);
		}
	}
	
}