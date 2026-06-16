package com.mindgame.tweener.easing.equations
{
   import com.mindgame.tweener.easing.*;
   
   public final class ExpoEaseInOut implements IEasing
   {
       
      
      public function ExpoEaseInOut()
      {
         super();
      }
      
      public function calculate(param1:Number) : Number
      {
         if(param1 == 0)
         {
            return 0;
         }
         if(param1 == 1)
         {
            return 1;
         }
         if((param1 = param1 / (1 / 2)) < 1)
         {
            return 0.5 * Math.pow(2,10 * (param1 - 1));
         }
         return 0.5 * (2 - Math.pow(2,-10 * --param1));
      }
      
      public function ease(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 == 0)
         {
            return param2;
         }
         if(param1 == param4)
         {
            return param2 + param3;
         }
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * Math.pow(2,10 * (param1 - 1)) + param2;
         }
         return param3 / 2 * (2 - Math.pow(2,-10 * --param1)) + param2;
      }
   }
}
