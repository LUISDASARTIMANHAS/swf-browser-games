package org.flixel
{
   import flash.geom.Point;
   
   public class FlxPoint
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public function FlxPoint(param1:Number = 0, param2:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      public function make(param1:Number = 0, param2:Number = 0) : FlxPoint
      {
         this.x = param1;
         this.y = param2;
         return this;
      }
      
      public function copyFrom(param1:FlxPoint) : FlxPoint
      {
         this.x = param1.x;
         this.y = param1.y;
         return this;
      }
      
      public function copyTo(param1:FlxPoint) : FlxPoint
      {
         param1.x = this.x;
         param1.y = this.y;
         return param1;
      }
      
      public function copyFromFlash(param1:Point) : FlxPoint
      {
         this.x = param1.x;
         this.y = param1.y;
         return this;
      }
      
      public function copyToFlash(param1:Point) : Point
      {
         param1.x = this.x;
         param1.y = this.y;
         return param1;
      }
   }
}
