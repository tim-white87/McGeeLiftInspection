package com.mcgeecompany.skins.customcomponents
{
	import mx.core.UIComponent;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	public class Background extends UIComponent
	{
		public static const NAVY:int = 0x344F72;
		public static const LIGHTGRAY:int = 0xEFEFEF;
		public static const SHADOWGRAY:int = 0x666666;
		
		[Embed(source = 'assets/images/mcGee114x114.png')]
		public var mcGeeLogo:Class;
		
		private var background:Sprite = new Sprite;
		private var background2:Sprite = new Sprite;
		private var backgroundLogo:Bitmap = new mcGeeLogo;
		
		override protected function updateDisplayList(
			unscaledWidth:Number, unscaledHeight:Number):void {
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			graphics.clear();
			drawRectangle(background, x, y, width, height, NAVY);
			drawRoundedRectangle(background2, (width - width *.85)/2, (height - height * .95)/2, width * .85, height * .95, LIGHTGRAY);
			drawImage(backgroundLogo, 10, 10);
			
		}
		
		private function drawRectangle(id:Sprite, xPosition:int, yPosition:int,
									   width:int, height:int, color:int):void
		{
			var rect:Sprite = id;			
			rect.graphics.beginFill(color);
			rect.graphics.drawRect(xPosition, yPosition, width, height);
			rect.graphics.endFill();
			this.addChild(rect);
			
		}
		
		private function drawRoundedRectangle(id:Sprite, xPosition:int, yPosition:int,
											  width:int, height:int, color:int):void
		{
			// Draw Rectangle
			var rect:Sprite = id;
			rect.graphics.beginFill(color);
			rect.graphics.drawRoundRect(xPosition, yPosition, width, height, 40);
			rect.graphics.endFill();
			this.addChild(rect);
			
			// Add Shadow
			var shadow:DropShadowFilter = new DropShadowFilter(); 
			shadow.distance = 20; 
			shadow.alpha = .4;
			shadow.angle = 135; 
			rect.filters = [shadow];
		}
		
		
		private function drawImage(id:Bitmap, xPosition:int, yPosition:int):void
			
		{
			// Create Image
			var image:Bitmap = id;
			image.x = xPosition;
			image.y = yPosition;
			this.addChild(image);
			
			// Round corners
			var roundedImageMask:Sprite = new Sprite();
			roundedImageMask.graphics.clear();
			roundedImageMask.graphics.beginFill(0xFF0000);
			roundedImageMask.graphics.drawRoundRect(image.x, image.y, image.width, image.height, 20);
			roundedImageMask.graphics.endFill();
			image.mask = roundedImageMask;
			this.addChild(roundedImageMask);
			
			// Add Shadow
			var shadow:DropShadowFilter = new DropShadowFilter(); 
			shadow.distance = 10; 
			shadow.alpha = .4;
			shadow.angle = 135; 
			image.filters = [shadow];
		}
	}
}