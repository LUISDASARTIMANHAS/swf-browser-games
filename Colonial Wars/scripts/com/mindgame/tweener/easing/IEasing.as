package com.mindgame.tweener.easing
{
   public interface IEasing
   {
       
      
      function calculate(param1:Number) : Number;
      
      function ease(param1:Number, param2:Number, param3:Number, param4:Number) : Number;
   }
}
