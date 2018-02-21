package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Thumb;
	/**
	* ...
	* @author Edson Prata
	*/
	public class Thumbs extends Sprite
	{
		private var thumb		:Thumb;
		private var arryThumb	:Array;
		private var cont		:Number = 0;
		private var contem		:Object;
		
		public function Thumbs(fotos:Array):void
		{
			super();
			carregaThumbs(fotos);
		}
		//carrega as thumbs do array
		private function carregaThumbs(fotos:Array):void
		{
			var len:Number = fotos.length;
			arryThumb = new Array();
			
			for (var i:int = 0; i < len ; i++) 
			{
				thumb = new Thumb(fotos[i]);
				arryThumb.push(thumb);
				addThumbs(i);
			}
			
		}
		
		
		//função que adicina e posiciona as  thumbs no stage
		public function addThumbs(i:Number):void
		{
			addChild(thumb)
			thumb.addEventListener(MouseEvent.CLICK,  thumbClicadoHandler);
			thumb.x = 10;
			thumb.y = 10;
			if (i % 5 == 0 && i > 0)
			{
				arryThumb[i].x = 10;
				arryThumb[i].y = arryThumb[i - 1].height + arryThumb[i - 1].y + 7;
			}
			else if (i > 0) 
			{
				arryThumb[i].x = arryThumb[i - 1].x + arryThumb[i].width + 7;
				arryThumb[i].y = arryThumb[i - 1].y;
			}
		}
		//evento da thumb clicada, passando o alvo clicado para classe Galeria
		private function thumbClicadoHandler(e:MouseEvent):void 
		{
			dispatchEvent(new ThumbEvent(ThumbEvent.THUMB_SELECIONADA, false, false, e.currentTarget.conteudo ));
		}
		
		
		
	}
	
}