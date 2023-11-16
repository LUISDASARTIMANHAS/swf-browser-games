package org.flixel.plugin.photonstorm
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import org.flixel.FlxPoint;
   import org.flixel.FlxSprite;
   
   public class FlxHealthBar extends FlxSprite
   {
      
      public static const FILL_LEFT_TO_RIGHT:int = 1;
      
      public static const FILL_RIGHT_TO_LEFT:int = 2;
      
      public static const FILL_INSIDE_OUT:int = 3;
      
      private static const BAR_FILLED:int = 1;
      
      private static const BAR_GRADIENT:int = 2;
      
      private static const BAR_IMAGE:int = 3;
       
      
      private var parent:FlxSprite;
      
      public var fixedPosition:Boolean = true;
      
      public var positionOffset:FlxPoint;
      
      public var positionOverSprite:Boolean = false;
      
      protected var prevHealth:int;
      
      protected var pxPerHealth:Number;
      
      protected var min:uint;
      
      protected var max:uint;
      
      private var zeroOffset:Point;
      
      protected var emptyBar:BitmapData;
      
      protected var emptyBarRect:Rectangle;
      
      protected var filledBar:BitmapData;
      
      protected var filledBarRect:Rectangle;
      
      protected var fillDirection:int;
      
      protected var barType:int;
      
      public function FlxHealthBar(param1:FlxSprite, param2:int, param3:int, param4:uint = 0, param5:uint = 100, param6:Boolean = false)
      {
         this.zeroOffset = new Point();
         super();
         this.parent = param1;
         if(param6)
         {
            makeGraphic(param2 + 2,param3 + 2,4294967295,true);
            width = param2 + 2;
            height = param3 + 2;
         }
         else
         {
            makeGraphic(param2,param3,4294967295,true);
            width = param2;
            height = param3;
         }
         this.fillDirection = FILL_LEFT_TO_RIGHT;
         this.setRange(param4,param5);
         this.createFilledBar(4278210816,4278252544,param6);
      }
      
      public function trackParent(param1:int, param2:int) : void
      {
         this.fixedPosition = false;
         this.positionOffset = new FlxPoint(param1,param2);
         scrollFactor.x = this.parent.scrollFactor.x;
         scrollFactor.y = this.parent.scrollFactor.y;
      }
      
      public function stopTrackingParent(param1:int, param2:int) : void
      {
         this.fixedPosition = true;
         x = param1;
         y = param2;
      }
      
      public function setRange(param1:uint, param2:uint) : void
      {
         if(param2 == 0)
         {
            return;
         }
         if(param1 == param2)
         {
            return;
         }
         if(param2 < param1)
         {
            throw Error("FlxHealthBar: max cannot be less than min");
         }
         this.min = param1;
         this.max = param2;
         this.pxPerHealth = width / this.max;
      }
      
      public function createFilledBar(param1:uint, param2:uint, param3:Boolean = false, param4:uint = 4294967295) : void
      {
         this.barType = BAR_FILLED;
         if(param3)
         {
            this.emptyBar = new BitmapData(width,height,true,param4);
            this.emptyBar.fillRect(new Rectangle(1,1,width - 2,height - 2),param1);
            this.filledBar = new BitmapData(width,height,true,param4);
            this.filledBar.fillRect(new Rectangle(1,1,width - 2,height - 2),param2);
         }
         else
         {
            this.emptyBar = new BitmapData(width,height,true,param1);
            this.filledBar = new BitmapData(width,height,true,param2);
         }
         this.filledBarRect = new Rectangle(0,0,this.filledBar.width,this.filledBar.height);
         this.emptyBarRect = new Rectangle(0,0,this.emptyBar.width,this.emptyBar.height);
      }
      
      public function createGradientBar(param1:Array, param2:Array, param3:int = 1, param4:int = 180, param5:Boolean = false, param6:uint = 4294967295) : void
      {
         this.barType = BAR_GRADIENT;
         if(param5)
         {
            this.emptyBar = new BitmapData(width,height,true,param6);
            FlxGradient.overlayGradientOnBitmapData(this.emptyBar,width - 2,height - 2,param1,1,1,param3,param4);
            this.filledBar = new BitmapData(width,height,true,param6);
            FlxGradient.overlayGradientOnBitmapData(this.filledBar,width - 2,height - 2,param2,1,1,param3,param4);
         }
         else
         {
            this.emptyBar = FlxGradient.createGradientBitmapData(width,height,param1,param3,param4);
            this.filledBar = FlxGradient.createGradientBitmapData(width,height,param2,param3,param4);
         }
         this.emptyBarRect = new Rectangle(0,0,this.emptyBar.width,this.emptyBar.height);
         this.filledBarRect = new Rectangle(0,0,this.filledBar.width,this.filledBar.height);
      }
      
      public function createImageBar(param1:Class = null, param2:Class = null, param3:uint = 4278190080, param4:uint = 4278255360) : void
      {
         this.barType = BAR_IMAGE;
         if(param1 == null && param2 == null)
         {
            return;
         }
         if(param1)
         {
            this.emptyBar = Bitmap(new param1()).bitmapData.clone();
         }
         else
         {
            this.emptyBar = new BitmapData(width,height,true,param3);
         }
         if(param2)
         {
            this.filledBar = Bitmap(new param2()).bitmapData.clone();
         }
         else
         {
            this.filledBar = new BitmapData(width,height,true,param4);
         }
         this.emptyBarRect = new Rectangle(0,0,this.emptyBar.width,this.emptyBar.height);
         this.filledBarRect = new Rectangle(0,0,this.filledBar.width,this.filledBar.height);
         if(this.emptyBarRect.width != width || this.emptyBarRect.height != height)
         {
            width = this.emptyBarRect.width;
            height = this.emptyBarRect.height;
         }
      }
      
      public function setFillDirection(param1:int) : void
      {
         if(param1 == FILL_LEFT_TO_RIGHT || param1 == FILL_RIGHT_TO_LEFT || param1 == FILL_INSIDE_OUT)
         {
            this.fillDirection = param1;
         }
      }
      
      private function updateBar() : void
      {
         var _loc1_:BitmapData = pixels;
         _loc1_.copyPixels(this.emptyBar,this.emptyBarRect,this.zeroOffset);
         if(this.parent.health < this.min)
         {
            this.filledBarRect.width = int(this.min * this.pxPerHealth);
         }
         else if(this.parent.health > this.max)
         {
            this.filledBarRect.width = int(this.max * this.pxPerHealth);
         }
         else
         {
            this.filledBarRect.width = int(this.parent.health * this.pxPerHealth);
         }
         if(this.parent.health != 0)
         {
            switch(this.fillDirection)
            {
               case FILL_LEFT_TO_RIGHT:
                  _loc1_.copyPixels(this.filledBar,this.filledBarRect,this.zeroOffset);
                  break;
               case FILL_RIGHT_TO_LEFT:
                  this.filledBarRect.x = width - this.filledBarRect.width;
                  _loc1_.copyPixels(this.filledBar,this.filledBarRect,new Point(width - this.filledBarRect.width,0));
                  addr34:
                  break;
               case FILL_INSIDE_OUT:
                  this.filledBarRect.x = int(width / 2 - this.filledBarRect.width / 2);
                  _loc1_.copyPixels(this.filledBar,this.filledBarRect,new Point(width / 2 - this.filledBarRect.width / 2,0));
                  if(true)
                  {
                     break;
                  }
                  §§goto(addr34);
            }
         }
         pixels = _loc1_;
         this.prevHealth = this.parent.health;
      }
      
      override public function update() : void
      {
         super.update();
         if(this.parent.exists)
         {
            if(this.fixedPosition == false)
            {
               x = this.parent.x + this.positionOffset.x;
               y = this.parent.y + this.positionOffset.y;
            }
            if(this.parent.health != this.prevHealth)
            {
               this.updateBar();
            }
         }
      }
   }
}
