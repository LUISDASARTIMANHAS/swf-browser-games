package org.flixel.system
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import org.flixel.FlxCamera;
   import org.flixel.FlxG;
   import org.flixel.FlxU;
   
   public class FlxTilemapBuffer
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var width:Number;
      
      public var height:Number;
      
      public var dirty:Boolean;
      
      public var rows:uint;
      
      public var columns:uint;
      
      protected var _pixels:BitmapData;
      
      protected var _flashRect:Rectangle;
      
      public function FlxTilemapBuffer(param1:Number, param2:Number, param3:uint, param4:uint, param5:FlxCamera = null)
      {
         super();
         if(param5 == null)
         {
            param5 = FlxG.camera;
         }
         this.columns = FlxU.ceil(param5.width / param1) + 1;
         if(this.columns > param3)
         {
            this.columns = param3;
         }
         this.rows = FlxU.ceil(param5.height / param2) + 1;
         if(this.rows > param4)
         {
            this.rows = param4;
         }
         this._pixels = new BitmapData(this.columns * param1,this.rows * param2,true,0);
         this.width = this._pixels.width;
         this.height = this._pixels.height;
         this._flashRect = new Rectangle(0,0,this.width,this.height);
         this.dirty = true;
      }
      
      public function destroy() : void
      {
         this._pixels = null;
      }
      
      public function fill(param1:uint = 0) : void
      {
         this._pixels.fillRect(this._flashRect,param1);
      }
      
      public function get pixels() : BitmapData
      {
         return this._pixels;
      }
      
      public function draw(param1:FlxCamera, param2:Point) : void
      {
         param1.buffer.copyPixels(this._pixels,this._flashRect,param2,null,null,true);
      }
   }
}
