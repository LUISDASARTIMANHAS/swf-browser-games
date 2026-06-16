package com.mindgame.framework
{
   public class Evector
   {
       
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public function Evector(param1:Number = 0, param2:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      public function copy(param1:Evector) : void
      {
         this.x = param1.x;
         this.y = param1.y;
      }
      
      public function set(param1:Number = 0, param2:Number = 0) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function add(param1:Evector) : void
      {
         this.x += param1.x;
         this.y += param1.y;
      }
      
      public function equal(param1:Evector, param2:Number = 0.00001) : Boolean
      {
         return Boolean(Emath.equal(this.x,param1.x,param2)) && Boolean(Emath.equal(this.y,param1.y,param2));
      }
      
      public function asSpeed(param1:Number, param2:Number) : void
      {
         this.x = param1 * Math.cos(param2);
         this.y = param1 * Math.sin(param2);
      }
      
      public function toString() : String
      {
         return "{Evector: " + this.x.toString() + ", " + this.y.toString() + "}";
      }
   }
}
