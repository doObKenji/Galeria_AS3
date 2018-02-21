package
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Thumbs;
	import flash.display.Sprite;
	import FotoGrande;
	
	/**
	* ...
	* @author Edson Prata
	*/
	public class Galeria extends Sprite
	{
		private var conteudoXML 	:XML;
		private var fotoGrande:FotoGrande;
		private var arrObjConteudo:Array;
		
		public function Galeria(conteudo:XML) 
		{
			super();
			conteudoXML = conteudo;
			addFotos()
		}
		//função que carrega as fotos, coloca dentro de um array de objetos e envia para classe thumbs e fotoGrande
		private function addFotos():void
		{
			try
			{
				arrObjConteudo = new Array();
				
				var galeria:XML = new XML(conteudoXML);
				galeria.ignoreWhitespace = true;
				
				
				for (var i:Number = 0; i < galeria.fotos.length(); i++)
				{
					arrObjConteudo.push( { foto:galeria.fotos.fotoGrande[i], thumb:galeria.fotos.thumb[i], indice:i } )
				}
				
				var totalFotos:Thumbs = new Thumbs(arrObjConteudo);
				fotoGrande = new FotoGrande();
				
				fotoGrande.totalFotos = arrObjConteudo.length;				
				
				totalFotos.addEventListener(ThumbEvent.THUMB_SELECIONADA, onThumbClicadaHandler);
				fotoGrande.addEventListener(ThumbEvent.PROXIMA_FOTO, procuraProximaFoto);
				fotoGrande.addEventListener(ThumbEvent.FOTO_ANTERIOR, procuraFotoAnterior);
				fotoGrande.visible = false;
				
				addChild(totalFotos);
				addChild(fotoGrande);
			}
			catch (e:TypeError)
			{
				trace("Erro ao carregar as Fotos");
				trace(e.message);
			}
		}
		private function onThumbClicadaHandler(e:ThumbEvent):void
		{
			fotoGrande.carregaFoto(e.parametro);
			fotoGrande.visible = true;
		};
		
		private function procuraProximaFoto(e:ThumbEvent):void
		{
			fotoGrande.carregaFoto(arrObjConteudo[Number(e.parametro.indice) + 1]);
		}
		
		private function procuraFotoAnterior(e:ThumbEvent):void
		{
			fotoGrande.carregaFoto(arrObjConteudo[Number(e.parametro.indice) - 1]);
		}
		
	}
	
}