package com.mindgame.tweener.easing.equations
{
   import com.mindgame.tweener.easing.*;
   
   public final class ElasticEaseOut implements IEasing
   {
       
      
      public var a:Number;
      
      public var p:Number;
      
      public function ElasticEaseOut(param1:Number, param2:Number)
      {
         super();
         this.a = param1;
         this.p = param2;
      }
      
      public function calculate(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         if(param1 == 0)
         {
            return 0;
         }
         if(param1 == 1)
         {
            return 1;
         }
         if(!this.p)
         {
            this.p = 0.3;
         }
         if(!this.a || this.a < 1)
         {
            this.a = 1;
            _loc2_ = this.p / 4;
         }
         else
         {
            _loc2_ = this.p / (2 * Math.PI) * Math.asin(1 / this.a);
         }
         return this.a * Math.pow(2,-10 * param1) * Math.sin((param1 - _loc2_) * (2 * Math.PI) / this.p) + 1;
      }
      
      public function ease(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = NaN;
         if(param1 == 0)
         {
            return param2;
         }
         if((param1 = param1 / param4) == 1)
         {
            return param2 + param3;
         }
         if(!this.p)
         {
            this.p = param4 * 0.3;
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
         return this.a * Math.pow(2,-10 * param1) * Math.sin((param1 * param4 - _loc5_) * (2 * Math.PI) / this.p) + param3 + param2;
      }
   }
}
