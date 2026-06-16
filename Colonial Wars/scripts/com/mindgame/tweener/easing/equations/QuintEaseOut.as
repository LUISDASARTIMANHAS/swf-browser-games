package com.mindgame.tweener.easing.equations
{
   import com.mindgame.tweener.easing.*;
   
   public final class QuintEaseOut implements IEasing
   {
       
      
      public function QuintEaseOut()
      {
         super();
      }
      
      public function calculate(param1:Number) : Number
      {
         return --param1 * param1 * param1 * param1 * param1 + 1;
      }
      
      public function ease(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * ((param1 = param1 / param4 - 1) * param1 * param1 * param1 * param1 + 1) + param2;
      }
   }
}
