package com.mindgame.tweener.easing.equations
{
   import com.mindgame.tweener.easing.*;
   
   public final class QuintEaseInOut implements IEasing
   {
       
      
      public function QuintEaseInOut()
      {
         super();
      }
      
      public function calculate(param1:Number) : Number
      {
         if((param1 = param1 * 2) < 1)
         {
            return 0.5 * param1 * param1 * param1 * param1 * param1;
         }
         return 0.5 * ((param1 = param1 - 2) * param1 * param1 * param1 * param1 + 2);
      }
      
      public function ease(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * param1 * param1 * param1 * param1 * param1 + param2;
         }
         return param3 / 2 * ((param1 = param1 - 2) * param1 * param1 * param1 * param1 + 2) + param2;
      }
   }
}
