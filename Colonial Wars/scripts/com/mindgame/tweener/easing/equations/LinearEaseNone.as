package com.mindgame.tweener.easing.equations
{
   import com.mindgame.tweener.easing.*;
   
   public final class LinearEaseNone implements IEasing
   {
       
      
      public function LinearEaseNone()
      {
         super();
      }
      
      public function calculate(param1:Number) : Number
      {
         return param1;
      }
      
      public function ease(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * param1 / param4 + param2;
      }
   }
}
