package
{
	import fl.transitions.easing.Bounce;
	import fl.transitions.easing.None;
	import fl.transitions.Tween;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.TextEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.ui.Mouse;
	
	/**
	* ...
	* @author Edson Prata
	*/
	public class FotoGrande extends MovieClip
	{
		private var fundo 		:Shape;
		private var loader		:Loader;
		private var arryFoto	:Array;
		private var loader_txt	:TextField;
		private var anima		:Tween;
		private var _foto		:Object;
		private var btn_next	:Sprite;
		private var btn_back	:Sprite;
		private var _totalFotos	:Number;
		
		public function set totalFotos(valor:Number):void
		{
			_totalFotos = valor;
		};
		
		private const WIDTH_PEDACO:int = 25;
		private const HEIGHT_PEDACO:int = 25;
		
		public function FotoGrande():void 
		{
			super();
			
			fundo = new Shape();
			fundo.x = 175;
			fundo.y = 250;
			fundo.graphics.beginFill(0x000000);
			fundo.graphics.drawRect(0, 0, 450, 340);
			fundo.graphics.endFill();
			
			btn_back = new Sprite();
			btn_back.x = 150;
			btn_back.y = 400;
			btn_back.graphics.beginFill(0x000000);
			btn_back.graphics.drawCircle(0, 0, 10);
			btn_back.graphics.endFill();
			
			btn_next = new Sprite();
			btn_next.x = 650;
			btn_next.y = 400;
			btn_next.graphics.beginFill(0x000000);
			btn_next.graphics.drawCircle(0, 0, 10);
			btn_next.graphics.endFill();
			
			loader_txt = new TextField();
			loader_txt.y = 250;
			loader_txt.textColor = (0x000000);
			
			addChild(loader_txt);
			addChild(btn_back);
			addChild(btn_next);
			addChild(fundo);
			
			loader = new Loader();
			
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderProgressHandler);
			loader.contentLoaderInfo.addEventListener(Event.INIT, animaIntroFotoHandler);
			loader.contentLoaderInfo.addEventListener(Event.OPEN, desabilitaBotao);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, habilitaBotao);
			loader.x = 175;
			loader.y = 250;
			addChild(loader);
			btn_back.addEventListener(MouseEvent.CLICK, fotoAnterior);
			btn_next.addEventListener(MouseEvent.CLICK, proximaFoto);
			
			btn_back.useHandCursor = true;
			btn_back.buttonMode = true;
			btn_next.useHandCursor = true;
			btn_next.buttonMode = true;
			
		}
		
		private function loaderProgressHandler(e:ProgressEvent):void 
		{
			btn_back.mouseEnabled = false;
			btn_next.mouseEnabled = false;
			loader_txt.text = Math.round(e.bytesLoaded / e.bytesTotal * 100) + "%";
		};
		
		public function carregaFoto(foto:Object):void
		{
			quebraBagulho();
			fundo.visible = true;
			loader.visible = true;
			loader.load(new URLRequest("../fotos/" + foto.foto));
			_foto = foto;
			controlaBotoes();
		};
		
		private function animaIntroFotoHandler(e:Event):void
		{
			anima = new Tween(loader, "alpha", None.easeOut, 0, 1, 1, true);
		};
		
		private function quebraBagulho () :void 
		{
			var bitmapData:BitmapData;
			var pedaco:Pedaco;
			var matrix:Matrix = new Matrix();
			
			for (var py:Number = 0; py < loader.height; py += HEIGHT_PEDACO)
			{
				for (var px:Number = 0; px < loader.width; px += WIDTH_PEDACO)
				{
					bitmapData = new BitmapData(WIDTH_PEDACO, HEIGHT_PEDACO);
					pedaco = new Pedaco();
					pedaco.x = px + 175;
					pedaco.y = py + 250;
					
					matrix.tx = -px;
					matrix.ty = -py;
					
					bitmapData.draw(loader, matrix);
					pedaco.populaBitmap(bitmapData);
					addChild(pedaco);
				};
			};
			/*loader.visible = false;
			fundo.visible = false;*/
		};
		private function proximaFoto(e:MouseEvent):void
		{				
			dispatchEvent(new ThumbEvent(ThumbEvent.PROXIMA_FOTO, false, false, _foto));
		};
		
		private function fotoAnterior(e:MouseEvent):void
		{
			dispatchEvent(new ThumbEvent(ThumbEvent.FOTO_ANTERIOR, false, false, _foto));
		};
		private function controlaBotoes():void
		{
			if (_foto.indice < 1)
				btn_back.visible = false;
			else if (_foto.indice == _totalFotos-1)
				btn_next.visible = false;
			else
			{
				btn_back.visible = true;
				btn_next.visible = true;
			}
		};
		private function desabilitaBotao(e:Event):void
		{
			btn_back.mouseEnabled = false;
			btn_next.mouseEnabled = false;
		};
		
		private function habilitaBotao(e:Event):void
		{
			btn_back.mouseEnabled = true;
			btn_next.mouseEnabled = true;
		};
	};
	
}