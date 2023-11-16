package org.flixel
{
   import flash.geom.Rectangle;
   
   public class FlxRect
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var width:Number;
      
      public var height:Number;
      
      public function FlxRect(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.width = param3;
         this.height = param4;
      }
      
      public function get left() : Number
      {
         return this.x;
      }
      
      public function get right() : Number
      {
         return this.x + this.width;
      }
      
      public function get top() : Number
      {
         return this.y;
      }
      
      public function get bottom() : Number
      {
         return this.y + this.height;
      }
      
      public function make(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : FlxRect
      {
         this.x = param1;
         this.y = param2;
         this.width = param3;
         this.height = param4;
         return this;
      }
      
      public function copyFrom(param1:FlxRect) : FlxRect
      {
         this.x = param1.x;
         this.y = param1.y;
         this.width = param1.width;
         this.height = param1.height;
         return this;
      }
      
      public function copyTo(param1:FlxRect) : FlxRect
      {
         param1.x = this.x;
         param1.y = this.y;
         param1.width = this.width;
         param1.height = this.height;
         return param1;
      }
      
      public function copyFromFlash(param1:Rectangle) : FlxRect
      {
         this.x = param1.x;
         this.y = param1.y;
         this.width = param1.width;
         this.height = param1.height;
         return this;
      }
      
      public function copyToFlash(param1:Rectangle) : Rectangle
      {
         param1.x = this.x;
         param1.y = this.y;
         param1.width = this.width;
         param1.height = this.height;
         return param1;
      }
      
      public function overlaps(param1:FlxRect) : Boolean
      {
         return param1.x + param1.width > this.x && param1.x < this.x + this.width && param1.y + param1.height > this.y && param1.y < this.y + this.height;
      }
   }
}
