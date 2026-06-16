package com.mindgame.tweener.easing.equations
{
   import com.mindgame.tweener.easing.*;
   
   public final class ElasticEaseInOut implements IEasing
   {
       
      
      public var a:Number;
      
      public var p:Number;
      
      public function ElasticEaseInOut(param1:Number, param2:Number)
      {
         super();
         this.a = param1;
         this.p = param2;
      }
      
      public function calculate(param1:Number) : Number
      {
         if(param1 == 0)
         {
            return 0;
         }
         if((param1 = param1 / (1 / 2)) == 2)
         {
            return 1;
         }
         var _loc2_:Number = 0.3 * 1.5;
         var _loc3_:Number = 1;
         var _loc4_:Number = _loc2_ / 4;
         if(param1 < 1)
         {
            return -0.5 * (Math.pow(2,10 * (param1 = param1 - 1)) * Math.sin((param1 - _loc4_) * (2 * Math.PI) / _loc2_));
         }
         return Math.pow(2,-10 * (param1 = param1 - 1)) * Math.sin((param1 - _loc4_) * (2 * Math.PI) / _loc2_) * 0.5 + 1;
      }
      
      public function ease(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = NaN;
         if(param1 == 0)
         {
            return param2;
         }
         if((param1 = param1 / (param4 / 2)) == 2)
         {
            return param2 + param3;
         }
         if(!this.p)
         {
            this.p = param4 * (0.3 * 1.5);
         }
         if(!this.a || this.a < Math.abs(param3))
         {
            this.a = param3;
            _loc5_ = this.p / 4;
         }
         else
         {
            _loc5_ = this.p / (2 * Math.PI) * Math.asin(param3 / this.a);
         }
         if(param1 < 1)
         {
            return -0.5 * (this.a * Math.pow(2,10 * (param1 = param1 - 1)) * Math.sin((param1 * param4 - _loc5_) * (2 * Math.PI) / this.p)) + param2;
         }
         return this.a * Math.pow(2,-10 * (param1 = param1 - 1)) * Math.sin((param1 * param4 - _loc5_) * (2 * Math.PI) / this.p) * 0.5 + param3 + param2;
      }
   }
}
