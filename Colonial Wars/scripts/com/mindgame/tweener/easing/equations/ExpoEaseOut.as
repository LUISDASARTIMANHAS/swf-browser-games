package com.mindgame.tweener.easing.equations
{
   import com.mindgame.tweener.easing.*;
   
   public final class ExpoEaseOut implements IEasing
   {
       
      
      public function ExpoEaseOut()
      {
         super();
      }
      
      public function calculate(param1:Number) : Number
      {
         return param1 == 1 ? 1 : 1 - Math.pow(2,-10 * param1);
      }
      
      public function ease(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 == param4 ? param2 + param3 : param3 * (1 - Math.pow(2,-10 * param1 / param4)) + param2;
      }
   }
}
