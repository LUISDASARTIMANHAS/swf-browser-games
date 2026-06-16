package com.mindgame.tweener.easing.equations
{
   import com.mindgame.tweener.easing.*;
   
   public final class ExpoEaseIn implements IEasing
   {
       
      
      public function ExpoEaseIn()
      {
         super();
      }
      
      public function calculate(param1:Number) : Number
      {
         return param1 == 0 ? 0 : Number(Math.pow(2,10 * (param1 - 1)));
      }
      
      public function ease(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 == 0 ? param2 : param3 * Math.pow(2,10 * (param1 / param4 - 1)) + param2;
      }
   }
}
